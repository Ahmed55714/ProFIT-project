import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:profit1/services/api_service.dart';
import '../model/chat_list.dart';

class ChatController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  ApiService apiService = Get.put(ApiService());
  var conversations = <Conversation>[].obs;
  var messages = <Message>[].obs;
  var currentUserId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUserId();
    fetchConversationsList();
    connectSocket();
  }

  Future<void> fetchCurrentUserId() async {
    try {
      currentUserId.value = await apiService.getCurrentUserId();
      print("Current User ID: ${currentUserId.value}");
    } catch (e) {
      errorMessage.value = e.toString();
      print("Error fetching user ID: $e");
    }
  }

  Future<void> fetchConversationsList() async {
    isLoading.value = true;
    try {
      List<Conversation> fetchedConversations = await apiService.fetchConversations();
      conversations.value = fetchedConversations;
      print("Conversations fetched: ${conversations.length}");

      for (var conversation in fetchedConversations) {
        print("Conversation ID: ${conversation.id}");
      }
    } catch (e) {
      errorMessage.value = e.toString();
      print("Error fetching conversations: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMessages(String conversationId) async {
    isLoading.value = true;
    try {
      print("Fetching messages for conversation ID: $conversationId");
      List<Message> fetchedMessages = await apiService.fetchMessages(conversationId);
      messages.value = fetchedMessages;
    } catch (e) {
      errorMessage.value = e.toString();
      print("Error fetching messages: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage(String conversationId, String content, {File? imageFile}) async {
    try {
      print("Sending message to conversation ID: $conversationId with content: $content");

      // Convert image to base64 if provided
      String? base64Image;
      if (imageFile != null) {
        List<int> imageBytes = await imageFile.readAsBytes();
        base64Image = base64Encode(imageBytes);
      }

      // Send message via WebSocket
      apiService.socketService.sendMessage(conversationId, content, base64Image != null ? [base64Image] : []);

      // Add message locally
      final message = Message(
        id: DateTime.now().toString(),
        content: content,
        images: base64Image != null ? [base64Image] : [],
        sender: Sender(
          id: currentUserId.value,
          firstName: '',
          lastName: '',
          email: '',
          profilePhoto: '',
        ),
        userId: currentUserId.value,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        conversationId: conversationId,
      );

      messages.add(message);
      updateLastMessage(conversationId, message);
      print("Message sent: $message");
    } catch (e) {
      errorMessage.value = e.toString();
      print("Error sending message: $e");
    }
  }

  void updateLastMessage(String conversationId, Message message) {
    final conversationIndex = conversations.indexWhere((c) => c.id == conversationId);
    if (conversationIndex != -1) {
      conversations[conversationIndex].lastMessage = ChatMessage(
        content: message.content,
        createdAt: message.createdAt,
      );
      conversations.refresh();
    }
  }

  void connectSocket() {
    apiService.socketService.connect();

    apiService.socketService.socket?.on('newMessage', (data) {
      print('New message received: $data');
      final newMessage = Message.fromJson(data);
      messages.add(newMessage);
      updateLastMessage(newMessage.conversationId, newMessage);
    });

    apiService.socketService.socket?.on('old_messages', (data) {
      print('Old messages received: $data');
      final fetchedMessages = (data as List)
          .map((message) => Message.fromJson(message))
          .toList();
      messages.assignAll(fetchedMessages);
    });
  }

  String formatTime(String isoTime) {
    final DateTime dateTime = DateTime.parse(isoTime);
    final DateFormat formatter = DateFormat.jm(); // '2:23 AM'
    return formatter.format(dateTime);
  }

  @override
  void onClose() {
    apiService.socketService.disconnect();
    super.onClose();
  }
}
