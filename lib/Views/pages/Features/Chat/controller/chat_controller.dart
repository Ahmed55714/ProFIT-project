

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
    fetchCurrentUserId().then((_) {
      fetchConversationsList();
      connectSocket().then((_) {
        conversations.forEach((conversation) {
          fetchMessages(conversation.id);
        });
      });
    });
  }

  Future<void> fetchCurrentUserId() async {
    try {
      String userId = await apiService.getCurrentUserId();
      currentUserId.value = userId;
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  Future<void> fetchConversationsList() async {
    isLoading.value = true;
    try {
      List<Conversation> fetchedConversations = await apiService.fetchConversations();
      conversations.value = fetchedConversations;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMessages(String conversationId) async {
    isLoading.value = true;
    try {
      List<Message> fetchedMessages = await apiService.fetchMessages(conversationId);
      messages.assignAll(fetchedMessages);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage(String conversationId, String content, {File? imageFile}) async {
    try {
      String? base64Image;
      if (imageFile != null) {
        List<int> imageBytes = await imageFile.readAsBytes();
        base64Image = base64Encode(imageBytes);
      }

      apiService.socketService.sendMessage(conversationId, content, base64Image != null ? [base64Image] : []);

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
    } catch (e) {
      errorMessage.value = e.toString();
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

  Future<void> connectSocket() async {
    await apiService.socketService.connect();

    apiService.socketService.socket?.on('newMessage', (data) {
      final newMessage = Message.fromJson(data);
      messages.add(newMessage);
      updateLastMessage(newMessage.conversationId, newMessage);
    });

    apiService.socketService.socket?.on('old_messages', (data) {
      final fetchedMessages = (data as List)
          .map((message) => Message.fromJson(message))
          .toList();
      messages.assignAll(fetchedMessages);
    });
  }

  String formatTime(String isoTime) {
    final DateTime dateTime = DateTime.parse(isoTime).toLocal();
    final DateFormat formatter = DateFormat.jm(); // '2:23 AM'
    return formatter.format(dateTime);
  }

  @override
  void onClose() {
    apiService.socketService.disconnect();
    super.onClose();
  }
}
