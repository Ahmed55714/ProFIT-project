import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import 'package:profit1/utils/colors.dart';
import 'package:profit1/services/api_service.dart';
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
  bool isWriting = false;

  @override
  void initState() {
    super.initState();
    chatController.fetchMessages(widget.conversation.id);
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty) return;
    await chatController.sendMessage(widget.conversation.id, _messageController.text);
    setState(() {
      _messageController.clear();
      isWriting = false;
    });
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
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final message = chatController.messages[index];
                  bool isSent = message.userId == message.sender.id; // Check if the message is sent by the current user
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                    child: Align(
                      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
                            children: [
                              if (isSent)
                                SvgPicture.asset('assets/svgs/dots-vertical.svg'),
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
                              if (!isSent)
                                SvgPicture.asset('assets/svgs/dots-vertical.svg'),
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
                  onPressed: () {},
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
                          isWriting = value.isNotEmpty;
                        });
                      },
                    ),
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset('assets/svgs/camera.svg'),
                  onPressed: () {},
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
