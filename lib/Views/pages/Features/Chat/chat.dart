import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import 'package:profit1/utils/colors.dart';
import 'package:profit1/services/api_service.dart';
import 'model/chat_list.dart';

class ChatScreen extends StatefulWidget {
  final Conversation conversation;

  ChatScreen({super.key, required this.conversation});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> messages = [];
  final TextEditingController _messageController = TextEditingController();
  final ApiService apiService = ApiService();
  bool isWriting = false;

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

  Future<void> _fetchMessages() async {
    try {
      final fetchedMessages = await apiService.fetchMessages(widget.conversation.id);
      setState(() {
        messages.addAll(fetchedMessages);
      });
    } catch (e) {
      print('Failed to fetch messages: $e');
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty) return;
    try {
      await apiService.sendMessage(widget.conversation.id, _messageController.text);
      setState(() {
        messages.add(Message(
          id: '', 
          content: _messageController.text,
          images: [],
          sender: Sender(
            id: 'currentUserId', 
            firstName: 'You',
            lastName: '',
            email: '',
            profilePhoto: '',
          ),
          userId: 'currentUserId',
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        ));
        _messageController.clear();
        isWriting = false;
      });
    } catch (e) {
      print('Failed to send message: $e');
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
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                bool isSent = message.sender.id == 'currentUserId'; // Check if the message is sent by the current user
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                  child: Align(
                    alignment: !isSent ? Alignment.centerRight : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: !isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: !isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
                          children: !isSent
                              ? [
                                  SvgPicture.asset(
                                    'assets/svgs/dots-vertical.svg',
                                  ),
                                  SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                      color: colorBlue,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.zero,
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      message.content,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ]
                              : [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.zero,
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      message.content,
                                      style: TextStyle(
                                        color: colorDarkBlue,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  SvgPicture.asset(
                                    'assets/svgs/dots-vertical.svg',
                                  ),
                                ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                message.createdAt.substring(11, 16),
                                style: TextStyle(
                                  color: grey500,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              if (isSent) ...[
                                SizedBox(width: 8),
                                Text(
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
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: SvgPicture.asset('assets/svgs/plusss.svg'),
                  onPressed: () {},
                ),
                Expanded(
                  child: Container(
                    height: 36,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: grey300, width: 1),
                      color: grey50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      controller: _messageController,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
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
