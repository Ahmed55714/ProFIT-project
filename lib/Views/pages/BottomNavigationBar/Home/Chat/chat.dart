import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/Views/widgets/customBotton.dart';
import 'package:profit1/Views/widgets/custom_appbar.dart';
import 'package:profit1/utils/colors.dart';

import '../Notifications/Notification.dart';

class ChatSCreen extends StatelessWidget {
  ChatSCreen({super.key});
  final List<Map<String, dynamic>> messages = [
    {
      'text': 'This is a received message',
      'isSent': false,
      'time': '11:46',
      'status': 'Delivered'
    },
    {
      'text': 'This is a sent message',
      'isSent': true,
      'time': '11:46',
      'status': 'Delivered'
    },
  ];

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Chat',
        showContainer: true,
        isShowChat: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                bool isSent = message['isSent'];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                  child: Align(
                    alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
                          children: isSent ? [
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
                                  bottomRight:  Radius.circular(20),
                                ),
                              ),
                              child: Text(
                                message['text'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ] : [
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
                                message['text'],
                                style: TextStyle(
                                  color: colorDarkBlue,
                                  fontSize: 12,
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
                                message['time'],
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
                  onPressed: () {
                    
                  },
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
      textAlign: TextAlign.left, 
      decoration: InputDecoration(
        hintText: "Write message",
        border: InputBorder.none,
        isDense: true, 
        contentPadding: EdgeInsets.symmetric(vertical: 1), 
      ),
    ),
  ),
),

                IconButton(
                  icon: SvgPicture.asset('assets/svgs/camera.svg'),
                  onPressed: () {
                    // Action for the camera button
                  },
                ),
                IconButton(
                  icon: SvgPicture.asset('assets/svgs/microphone.svg'),
                  onPressed: () {
                    // Action for the mic button
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



      //Chat Empty Screen
            // SizedBox(height: 57),
            // EmptyNotificationWidget(
            //   imagePath: 'assets/images/Chat Illutstarion.png',
            //   primaryText: "You are not subscribed to any trainer",
            //   secondaryText:
            //       "Explore our Trainers and discover the perfect one\n for your fitness journey.",
            // ),
            // SizedBox(height: 183),
            // CustomButton(text: 'Go to Explore', onPressed: () {}),
            // SizedBox(height: 16),


// AppBar(
//       backgroundColor: Colors.blue, // Set your desired color
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back, color: Colors.white), // Customize as needed
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
     
//       actions: [
//         IconButton(
//           icon: SvgPicture.asset('path_to_your_menu_icon.svg'), // Use an SVG or Icon as needed
//           onPressed: () {
//             // Action when pressing the menu button
//           },
//         ),
//         SizedBox(width: 10), // Spacing at the end of the app bar
//       ],
//     ),