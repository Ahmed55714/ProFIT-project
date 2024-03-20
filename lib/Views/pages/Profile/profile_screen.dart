import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';

import '../../../utils/colors.dart';
import '../../widgets/Explore/Trainer Details/Packages/package.dart';
import '../../widgets/Profile/profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey50,
      appBar: const CustomAppBar(
        titleText: 'Profile',
        showContainer: true,
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const ChangePhoto()));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: grey200),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      child: Image.asset('assets/images/profileHome.png'),
                      backgroundColor: colorBlue,
                    ),
                    const SizedBox(width: 16),
                    const TitleDescription(
                      title: 'Marwan Magdy',
                      description: 'marwanmagdy200@gmail.com',
                      color: blue700,
                    ),
                    SvgPicture.asset('assets/svgs/profile.svg'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 43),
          ProfileSection(title: 'Account', tiles: [
            SettingsTile(
                svgIcon: 'assets/svgs/user-2.svg',
                title: 'Personal Data',
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => NameScreen(
                  //               name: 'Nasser ⛅ SKY!',
                  //             )));
                }),
            SettingsTile(
                svgIcon: 'assets/svgs/lock-off.svg',
                title: 'Change Password',
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => EditUserNameScreen(
                  //       userName: 'Darku',
                  //     ),
                  //   ),
                  // );
                }),
            SettingsTile(
                svgIcon: 'assets/svgs/gift.svg',
                title: 'My Subscription',
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => EditEmailScreen(
                  //               email: 'Darku@gmail.com',
                  //             )));
                }),
            SettingsTile(
                svgIcon: 'assets/svgs/trash-2.svg',
                title: 'Delete Account',
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => EditBirthdayScreen(
                  //               birthday: '3/9/1988',
                  //             )));
                }),
          ]),
          ProfileSection(title: 'Periodic Follow-up', tiles: [
            SettingsTile(
                svgIcon: 'assets/svgs/applee.svg',
                title: 'Diet Assessments',
                subtitle: const CustomBadge(
                  text: 'Premium',
                ),
                onTap: () {}),
            SettingsTile(
                svgIcon: 'assets/svgs/Dumbbell1.svg',
                title: 'Workout Assessments',
                subtitle: const CustomBadge(
                  text: 'Premium',
                ),
                onTap: () {}),
          ]),
          ProfileSection(title: 'Settings', tiles: [
            SettingsTile(
                svgIcon: 'assets/svgs/belll.svg',
                title: 'Notifications',
                isShowIcon: true,
                isShowLogOut:true,
                onTap: () {
                }),
            SettingsTile(
                svgIcon: 'assets/svgs/waterdropp.svg',
                title: 'Water Reminder',
                onTap: () {}),
            SettingsTile(
                svgIcon: 'assets/svgs/globe-1.svg',
                title: 'Language',
                subtitle: const CustomBadge(
                  text: 'English',
                  textColor: blue700,
                  borderColor: blue700,
                  backgroundColor: Colors.white,
                ),
                onTap: () {}),
          ]),
          ProfileSection(title: 'About', tiles: [
            SettingsTile(
                svgIcon: 'assets/svgs/document-filled.svg',
                title: 'Terms and Conditions',
                onTap: () {}),
            SettingsTile(
                svgIcon: 'assets/svgs/star-11.svg',
                title: 'Rate the app',
                onTap: () {}),
            SettingsTile(
                svgIcon: 'assets/svgs/phone-call.svg',
                title: 'Contact us',
                onTap: () {}),
            SettingsTile(
                svgIcon: 'assets/svgs/question-circle.svg',
                title: 'About us',
                onTap: () {}),
            SettingsTile(
                svgIcon: 'assets/svgs/log-out.svg',
                title: 'Log out',
                isShowIcon: true,
                text: red600,
                onTap: () {
                  _showLogoutBottomSheet(context);
                }),
          ]),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showLogoutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 175,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 31),
              const Text(
                'Are you sure you want to log out?',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: grey400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 22),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'LogOut',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: grey400,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomBadge extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;
  final double borderRadius;

  const CustomBadge({
    Key? key,
    this.backgroundColor = green100,
    this.borderColor = Colors.white,
    required this.text,
    this.textColor = green600,
    this.borderRadius = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w400,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
