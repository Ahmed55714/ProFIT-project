import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class SocketService {
  IO.Socket? socket;

  Future<void> connect() async {
    final token = await getToken();
    print('Token: $token');

    if (token != null) {
      socket = IO.io('https://profit-qjbo.onrender.com/', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'auth': {
          'token': token,
        },
      });

      print('Socket initialized: $socket');

      socket!.connect();

      socket!.on('connect', (_) {
        print('Connected to the server');
      });

      socket!.on('newMessage', (data) {
        print('Message received: $data');
        // Implement your logic to update the messages list in the controller
      });

      socket!.on('old_messages', (data) {
        print('Old messages received: $data');
        // Implement your logic to update the messages list in the controller
      });

      socket!.on('disconnect', (_) {
        print('Disconnected from the server');
      });
    } else {
      print('Token not found');
    }
  }

  void sendMessage(String conversationId, String content, List<String> images) {
    if (socket != null && socket!.connected) {
      Map<String, dynamic> message = {
        'conversationId': conversationId,
        'content': content,
        'images': images
      };
      print('Sending message: $message');
      socket!.emit('message', message);
    } else {
      print('Socket is not connected');
    }
  }

  Future<void> fetchMessages(String conversationId) async {
    if (socket != null && socket!.connected) {
      print('Requesting messages for conversation ID: $conversationId');
      socket!.emit('fetch_messages', conversationId);
    } else {
      print('Socket is not connected');
    }
  }

  void requestOldMessages(String conversationId) {
    if (socket != null && socket!.connected) {
      print('Requesting old messages for conversation ID: $conversationId');
      socket!.emit('request_old_messages', conversationId);
    } else {
      print('Socket is not connected');
    }
  }

  void disconnect() {
    if (socket != null) {
      socket!.disconnect();
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
