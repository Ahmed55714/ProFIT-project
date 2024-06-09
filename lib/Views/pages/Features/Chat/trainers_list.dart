import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import 'package:profit1/Views/widgets/General/custom_loder.dart';
import 'package:profit1/utils/colors.dart';
import '../../../widgets/General/customBotton.dart';
import '../../Tabs/BottomNavigationBar/BottomNavigationBar.dart';
import '../Notifications/Notification.dart';
import 'chat.dart';
import 'controller/chat_controller.dart';

class TrainerListScreen extends StatefulWidget {
  TrainerListScreen({super.key});

  @override
  State<TrainerListScreen> createState() => _TrainerListScreenState();
}

class _TrainerListScreenState extends State<TrainerListScreen> {
  final ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
    chatController.fetchConversationsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Chat',
        showContainer: true,
      ),
      body: Obx(() {
        if (chatController.isLoading.value) {
          return Center(
            child: CustomLoder(
              color: colorBlue,
              size: 35,
            ),
          );
        } else if (chatController.errorMessage.isNotEmpty) {
          return Center(child: Text(chatController.errorMessage.value));
        } else if (chatController.conversations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 57),
                EmptyNotificationWidget(
                  imagePath: 'assets/images/Chat Illutstarion.png',
                  primaryText: "You are not subscribed to any trainer",
                  secondaryText: "Explore our Trainers and discover the perfect one\n for your fitness journey.",
                ),
                SizedBox(height: 183),
                CustomButton(
                  text: 'Go to Explore',
                  onPressed: () {
                    Get.offAll(BottomNavigation(role: 'Explore', selectedIndex: 1));
                  },
                ),
                SizedBox(height: 16),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: chatController.conversations.length,
            itemBuilder: (context, index) {
              final conversation = chatController.conversations[index];
              final lastMessageContent = conversation.lastMessage.content == "No messages yet" ? "" : conversation.lastMessage.content;
              final lastMessageTime = conversation.lastMessage.createdAt.isEmpty ? "" : chatController.formatTime(conversation.lastMessage.createdAt);
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(conversation.participant.profilePhoto),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${conversation.participant.firstName} ${conversation.participant.lastName}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: DArkBlue900,
                          ),
                        ),
                        Text(
                          lastMessageTime,
                          style: const TextStyle(
                            color: DArkBlue900,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      lastMessageContent,
                      style: const TextStyle(
                        color: grey500,
                      ),
                    ),
                    onTap: () {
                      Get.to(() => ChatScreen(conversation: conversation, ));
                    },
                  ),
                  Divider(
                    color: grey300,
                    height: 1,
                    thickness: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                ],
              );
            },
          );
        }
      }),
    );
  }
}
