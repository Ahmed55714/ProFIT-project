import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SocketService {
  IO.Socket? socket;

  Future<void> connect() async {
    final token = await getToken();

    if (token != null) {
      socket = IO.io('https://pro-fit.onrender.com', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'auth': {
          'token': token,
        },
      });

      socket!.connect();

      socket!.on('connect', (_) {});

      socket!.on('newMessage', (data) {});

      socket!.on('old_messages', (data) {});

      socket!.on('disconnect', (_) {});
    } else {}
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
      socket!.emit('message', message);
    } else {
    }
  }

  void requestOldMessages(String conversationId) {
    if (isConnected()) {
      print('Requesting old messages for conversation ID: $conversationId');
      socket!.emit('fetch_messages', conversationId);
    } else {
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
