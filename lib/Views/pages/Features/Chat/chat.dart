import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import 'package:profit1/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../widgets/General/custom_loder.dart';
import 'controller/chat_controller.dart';
import 'model/chat_list.dart';

class ChatScreen extends StatefulWidget {
  final Conversation conversation;

  ChatScreen({super.key, required this.conversation});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatController chatController = Get.put(ChatController());
  final ImagePicker _picker = ImagePicker();
  final ScrollController _scrollController = ScrollController();
  File? _imageFile;
  bool isWriting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatController.fetchMessages(widget.conversation.id).then((_) {
        _scrollToBottom();
      });
      chatController.apiService.socketService.fetchMessages(widget.conversation.id);
    });

    chatController.messages.listen((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty && _imageFile == null) return;
    chatController.sendMessage(widget.conversation.id, _messageController.text, imageFile: _imageFile);
    _messageController.clear();
    setState(() {
      isWriting = false;
      _imageFile = null;
    });
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
          isWriting = true;
        });
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ImageDisplayScreen(imageFile: _imageFile!, conversationId: widget.conversation.id),
        //   ),
        // );
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Chat',
        showContainer: true,
        isShowChat: true,
        chatName: '${widget.conversation.participant.firstName} ${widget.conversation.participant.lastName}',
        chatImage: '${widget.conversation.participant.profilePhoto}',
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (chatController.isLoading.value) {
                return Center(
                  child: CustomLoder(
                    color: colorBlue,
                    size: 35,
                  ),
                );
              }
              return ListView.builder(
                controller: _scrollController,
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final message = chatController.messages[index];
                  bool isSent = message.userId == message.sender.id;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                    child: Align(
                      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          if (message.images.isNotEmpty)
                            Image.network(message.images.first),
                          Row(
                            mainAxisAlignment: isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
                            children: [
                              if (isSent) SvgPicture.asset('assets/svgs/dots-vertical.svg'),
                              if (isSent) const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                  color: isSent ? colorBlue : Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(isSent ? 20 : 0),
                                    topRight: Radius.circular(isSent ? 0 : 20),
                                    bottomLeft: const Radius.circular(20),
                                    bottomRight: const Radius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  message.content,
                                  style: TextStyle(
                                    color: isSent ? Colors.white : colorDarkBlue,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              if (!isSent) const SizedBox(width: 6),
                              if (!isSent) SvgPicture.asset('assets/svgs/dots-vertical.svg'),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  chatController.formatTime(message.createdAt),
                                  style: const TextStyle(
                                    color: grey500,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                if (isSent) ...[
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Delivered',
                                    style: TextStyle(
                                      color: blue500,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: SvgPicture.asset('assets/svgs/plusss.svg'),
                  onPressed: _pickImage,
                ),
                Expanded(
                  child: Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: grey300, width: 1),
                      color: grey50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      controller: _messageController,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        hintText: "Write message",
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 1),
                      ),
                      onChanged: (value) {
                        setState(() {
                          isWriting = value.isNotEmpty || _imageFile != null;
                        });
                      },
                    ),
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset('assets/svgs/camera.svg'),
                  onPressed: _pickImage,
                ),
                IconButton(
                  icon: SvgPicture.asset(isWriting ? 'assets/svgs/send.svg' : 'assets/svgs/microphone.svg'),
                  color: isWriting ? colorBlue : null,
                  onPressed: isWriting ? _sendMessage : null,
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
















// class ImageDisplayScreen extends StatefulWidget {
//   final File imageFile;
//   final String conversationId;

//   ImageDisplayScreen({required this.imageFile, required this.conversationId});

//   @override
//   _ImageDisplayScreenState createState() => _ImageDisplayScreenState();
// }

// class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final ChatController chatController = Get.put(ChatController());
//   bool isSending = false;

//   Future<void> _sendMessage() async {
//     setState(() {
//       isSending = true;
//     });

//     try {
//       await chatController.sendMessage(widget.conversationId, _messageController.text, imageFile: widget.imageFile);
//     } catch (e) {
//       print('Error sending message: $e');
//     } finally {
//       setState(() {
//         isSending = false;
//       });
//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Preview'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Center(
//               child: AspectRatio(
//                 aspectRatio: 16 / 9,
//                 child: Image.file(
//                   widget.imageFile,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: "Write message",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       isDense: true,
//                       contentPadding: EdgeInsets.all(10),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: SvgPicture.asset(
//                     'assets/svgs/send.svg',
//                     color: isSending ? Colors.grey : Colors.blue,
//                   ),
//                   onPressed: isSending ? null : _sendMessage,
//                   iconSize: 24,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
