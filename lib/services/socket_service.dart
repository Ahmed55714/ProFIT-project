import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SocketService {
  IO.Socket? socket;

  Future<void> connect() async {
    final token = await getToken();
    print('Token: $token');

    if (token != null) {
      socket = IO.io('https://pro-fit.onrender.com', <String, dynamic>{
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
        // Handle new message received
      });

      socket!.on('old_messages', (data) {
        print('Old messages received: $data');
        // Handle old messages received
      });

      socket!.on('disconnect', (_) {
        print('Disconnected from the server');
      });
    } else {
      print('Token not found');
    }
  }

  bool isConnected() {
    return socket != null && socket!.connected;
  }

  void sendMessage(String conversationId, String content, List<String> images) {
    if (isConnected()) {
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

  void requestOldMessages(String conversationId) {
    if (isConnected()) {
      print('Requesting old messages for conversation ID: $conversationId');
      socket!.emit('fetch_messages', conversationId);
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
