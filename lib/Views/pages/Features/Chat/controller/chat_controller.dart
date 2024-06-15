import 'package:get/get.dart';
import 'package:profit1/services/api_service.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:convert';
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
      apiService.socketService.requestOldMessages(conversationId);
    } catch (e) {
      errorMessage.value = e.toString();
      print("Error fetching messages: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void sendMessage(String conversationId, String content, {File? imageFile}) {
    try {
      print("Sending message to conversation ID: $conversationId with content: $content");
      apiService.sendMessage(conversationId, content, imageFile: imageFile);
      final message = Message(
        id: DateTime.now().toString(),
        content: content,
        images: imageFile != null ? [imageFile.path] : [],
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

    apiService.socketService.socket?.on('message', (data) {
      print('New message received: $data');
      final newMessage = Message.fromJson(jsonDecode(data));
      messages.add(newMessage);
      updateLastMessage(newMessage.conversationId, newMessage);
    });

    apiService.socketService.socket?.on('old_messages', (data) {
      print('Old messages received: $data');
      final fetchedMessages = (jsonDecode(data) as List)
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
