import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'controller/chat_controller.dart';

class ImageDisplayScreen extends StatefulWidget {
  final File imageFile;
  final String conversationId;

  ImageDisplayScreen({required this.imageFile, required this.conversationId});

  @override
  _ImageDisplayScreenState createState() => _ImageDisplayScreenState();
}

class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatController chatController = Get.put(ChatController());
  bool isSending = false;

  Future<void> _sendMessage() async {
    setState(() {
      isSending = true;
    });

    try {
      await chatController.sendMessage(
          widget.conversationId, _messageController.text,
          imageFile: widget.imageFile);
    } catch (e) {
    } finally {
      setState(() {
        isSending = false;
      });
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Preview'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.file(
                  widget.imageFile,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Write message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/svgs/send.svg',
                    color: isSending ? Colors.grey : Colors.blue,
                  ),
                  onPressed: isSending ? null : _sendMessage,
                  iconSize: 24,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}







class FullScreenImage extends StatelessWidget {
  final File imageFile;
  final String? networkImageUrl;

  FullScreenImage({required this.imageFile, this.networkImageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: networkImageUrl != null
              ? Image.network(
                  networkImageUrl!,
                  fit: BoxFit.contain,
                )
              : Image.file(
                  imageFile,
                  fit: BoxFit.contain,
                ),
        ),
      ),
    );
  }
}
