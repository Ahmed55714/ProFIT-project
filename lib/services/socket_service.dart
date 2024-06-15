import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SocketService {
  IO.Socket? socket;

  Future<void> connect() async {
    final token = await getToken();
    print('Token: $token'); // Print the token

    if (token != null) {
      socket = IO.io('https://profit-qjbo.onrender.com/', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'auth': {
          'token': token,
        },
      });

      print('Socket initialized: $socket'); // Print the socket initialization

      socket!.connect();

      socket!.on('connect', (_) {
        print('Connected to the server');
      });

      socket!.on('message', (data) {
        print('Message received: $data');
      });

      socket!.on('old_messages', (data) {
        print('Old messages received: $data'); // Print the old messages received
        // Implement your logic to update the messages list in the controller
      });

      socket!.on('disconnect', (_) {
        print('Disconnected from the server');
      });
    } else {
      print('Token not found');
    }
  }

  void sendMessage(Map<String, dynamic> message) {
    if (socket != null && socket!.connected) {
      print('Sending message: $message'); // Print the message being sent
      socket!.emit('message', jsonEncode(message));
    } else {
      print('Socket is not connected');
    }
  }

  void fetchMessages(String conversationId) {
    if (socket != null && socket!.connected) {
      print('Requesting messages for conversation ID: $conversationId'); // Print the request for messages
      socket!.emit('fetch_messages', conversationId);
    } else {
      print('Socket is not connected');
    }
  }

  void requestOldMessages(String conversationId) {
    if (socket != null && socket!.connected) {
      print('Requesting old messages for conversation ID: $conversationId'); // Print the request for old messages
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
