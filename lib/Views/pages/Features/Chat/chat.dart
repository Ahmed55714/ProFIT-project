import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import 'package:profit1/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:async'; // Add this import for Timer

import 'controller/chat_controller.dart';
import 'display_image.dart';
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
  Timer? _timer; // Add this line to define a Timer
  bool _userScroll = false; // Add this flag to detect user scroll

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchMessagesAndScroll();
    });

    chatController.messages.listen((_) {
      if (!_userScroll) {
        _scrollToBottom();
      }
    });

    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      _fetchMessagesAndScroll();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection != ScrollDirection.idle) {
        _userScroll = true;
      }
      if (_scrollController.position.atEdge && _scrollController.position.pixels != 0) {
        _userScroll = false;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchMessagesAndScroll() async {
    await chatController.fetchMessages(widget.conversation.id);
    if (!_userScroll) {
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty && _imageFile == null) return;
    await chatController.sendMessage(
        widget.conversation.id, _messageController.text,
        imageFile: _imageFile);
    _messageController.clear();
    setState(() {
      isWriting = false;
      _imageFile = null;
    });
    _scrollToBottom();
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
          isWriting = true;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageDisplayScreen(
                imageFile: _imageFile!, conversationId: widget.conversation.id),
          ),
        ).then((value) {
          if (value == true) {
            _fetchMessagesAndScroll(); // Refetch messages after sending image
          }
        });
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
        chatName:
            '${widget.conversation.participant.firstName} ${widget.conversation.participant.lastName}',
        chatImage: '${widget.conversation.participant.profilePhoto}',
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                controller: _scrollController,
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final message = chatController.messages[index];
                  bool isSent = message.userId == message.sender.id;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 14.0),
                    child: Align(
                      alignment:
                          isSent ? Alignment.centerRight : Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: isSent
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (message.images.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenImage(
                                      imageFile: File(''), // Dummy file, not used
                                      networkImageUrl: message.images.first,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                constraints: BoxConstraints(
                                  maxHeight: 200,
                                  maxWidth: 200,
                                ),
                                decoration: BoxDecoration(
                                  color: isSent ? colorBlue : Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(isSent ? 20 : 0),
                                    topRight: Radius.circular(isSent ? 0 : 20),
                                    bottomLeft: const Radius.circular(20),
                                    bottomRight: const Radius.circular(20),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: _buildImage(message.images.first),
                                ),
                              ),
                            )
                          else
                            Row(
                              mainAxisAlignment: isSent
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                if (isSent)
                                  SvgPicture.asset(
                                      'assets/svgs/dots-vertical.svg'),
                                if (isSent) const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 12.0),
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
                                      topRight:
                                          Radius.circular(isSent ? 0 : 20),
                                      bottomLeft: const Radius.circular(20),
                                      bottomRight: const Radius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    message.content,
                                    style: TextStyle(
                                      color:
                                          isSent ? Colors.white : colorDarkBlue,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                if (!isSent) const SizedBox(width: 6),
                                if (!isSent)
                                  SvgPicture.asset(
                                      'assets/svgs/dots-vertical.svg'),
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
                  icon: SvgPicture.asset(isWriting
                      ? 'assets/svgs/send.svg'
                      : 'assets/svgs/microphone.svg'),
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

  Widget _buildImage(String image) {
    try {
      if (image.startsWith('data:image')) {
        String base64String = image.split(',').last;
        Uint8List decodedBytes = base64Decode(base64String);
        return Image.memory(
          decodedBytes,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error);
          },
        );
      } else if (Uri.tryParse(image)?.isAbsolute ?? false) {
        return Image.network(
          image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error);
          },
        );
      } else {
        return Icon(Icons.error);
      }
    } catch (e) {
      print('Error decoding image: $e');
      return Icon(Icons.error);
    }
  }
}
