import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profit1/utils/colors.dart';
import '../../../widgets/AppBar/custom_appbar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<bool> tappedNotifications = [];

  @override
  void initState() {
    super.initState();
    tappedNotifications = List.filled(notifications.length, false);
  }

  final notifications = [
    {
      'title': 'Assessment Request',
      'time': '03:56 AM, Mon',
      'description':
          'Complete your assessment and receive your program within 24hr',
    },
    {
      'title': 'New Updates Available!',
      'time': 'Sep 15, 2023',
      'description': 'Update now to get access the latest features.',
    },
    {
      'title': 'Account Setup Successful !',
      'time': 'Sep 15, 2023',
      'description': 'Your account creation is successful.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(titleText: 'Notifications', showContainer: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 8),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            child: GestureDetector(
              onTap: () {
                if (!tappedNotifications[index]) {
                  setState(() {
                    tappedNotifications[index] = true;
                  });
                }
              },
              child:
                Container(
                  width: double.infinity, 
                  decoration: BoxDecoration(
                    color: tappedNotifications[index] ? Colors.white : Colors.grey[50],
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 24.0,
                          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                          child: Image.asset(
                            'assets/images/Notifications.png',
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                notification['title'] as String,
                                style: const TextStyle(
                                  color: colorBlue,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                notification['time'] as String,
                                style: const TextStyle(
                                  color: grey500,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                notification['description'] as String,
                                style: const TextStyle(
                                    color: colorDarkBlue,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            
          );
        },
      ),
    );
  }
}


// Empty Notification Widget
class EmptyNotificationWidget extends StatelessWidget {
  final String imagePath;
  final String primaryText;
  final String secondaryText;

  const EmptyNotificationWidget({
    Key? key,
    required this.imagePath,
    required this.primaryText,
    required this.secondaryText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(imagePath),
          const SizedBox(height: 16),
          Text(
            primaryText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: colorBlue,
            ),
          ),
        
          Text(
            secondaryText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: colorDarkBlue,
            ),
          ),
        ],
      ),
    );
  }
}


// EmptyNotificationWidget(
//   imagePath: 'assets/images/your_image.png', // Replace with your image path
//   primaryText: "You're all caught up",
//   secondaryText: "Enable notifications to receive real-time updates",
// )
