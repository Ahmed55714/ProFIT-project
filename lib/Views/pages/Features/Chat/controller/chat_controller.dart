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

  @override
  void onInit() {
    super.onInit();
    fetchConversationsList();
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
      messages.value = fetchedMessages;
      print('Messages fetched successfully in ChatController: $fetchedMessages');
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage(String conversationId, String content, {File? imageFile}) async {
    try {
      final newMessage = await apiService.sendMessage(conversationId, content, imageFile: imageFile);
      messages.add(newMessage);
      print('Message sent successfully: $newMessage');
    } catch (e) {
      errorMessage.value = e.toString();
      print('Error sending message: $e');
    }
  }

  String formatTime(String isoTime) {
    final DateTime dateTime = DateTime.parse(isoTime);
    final DateFormat formatter = DateFormat.jm(); // '2:23 AM'
    return formatter.format(dateTime);
  }
}
