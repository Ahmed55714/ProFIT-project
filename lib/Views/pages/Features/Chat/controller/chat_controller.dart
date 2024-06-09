import 'package:get/get.dart';
import 'package:profit1/services/api_service.dart';
import 'package:intl/intl.dart';
import '../model/chat_list.dart';
import 'dart:io';

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
  }

  Future<void> fetchCurrentUserId() async {
    try {
      currentUserId.value = await apiService.getCurrentUserId();
      print("Current User ID: ${currentUserId.value}"); // Debugging log
    } catch (e) {
      errorMessage.value = e.toString();
      print("Error fetching user ID: $e"); // Debugging log
    }
  }

  Future<void> fetchConversationsList() async {
    isLoading.value = true;
    try {
      List<Conversation> fetchedConversations = await apiService.fetchConversations();
      conversations.value = fetchedConversations;
      print("Conversations fetched: ${conversations.length}"); // Debugging log
    } catch (e) {
      errorMessage.value = e.toString();
      print("Error fetching conversations: $e"); // Debugging log
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMessages(String conversationId) async {
    isLoading.value = true;
    try {
      print("Fetching messages for conversation ID: $conversationId"); // Debugging log
      List<Message> fetchedMessages = await apiService.fetchMessages(conversationId);
      messages.assignAll(fetchedMessages); // Update the messages list
      print("Messages fetched: ${messages.length}"); // Debugging log
    } catch (e) {
      errorMessage.value = e.toString();
      print("Error fetching messages: $e"); // Debugging log
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage(String conversationId, String content, {File? imageFile}) async {
    try {
      print("Sending message to conversation ID: $conversationId with content: $content"); // Debugging log
      final newMessage = await apiService.sendMessage(conversationId, content, imageFile: imageFile);
      messages.add(newMessage);
      print("Message sent: ${newMessage.content}"); // Debugging log
      await fetchMessages(conversationId); // Fetch messages to update the list
    } catch (e) {
      errorMessage.value = e.toString();
      print("Error sending message: $e"); // Debugging log
    }
  }

  String formatTime(String isoTime) {
    final DateTime dateTime = DateTime.parse(isoTime);
    final DateFormat formatter = DateFormat.jm(); // '2:23 AM'
    return formatter.format(dateTime);
  }
}
