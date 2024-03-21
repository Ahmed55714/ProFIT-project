import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';

import '../../../utils/colors.dart';
import '../../widgets/BottomSheets/add_challenge.dart';
import '../../widgets/Explore/Trainer Details/Packages/package.dart';
import '../../widgets/Profile/profile.dart';
import 'Account/assessments.dart';
import 'Account/my_subscription.dart';
import 'Account/personalData.dart';
import 'accountData.dart';

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AccountData()));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PersonalDataScreen()));
                }),
            // SettingsTile(
            //     svgIcon: 'assets/svgs/lock-off.svg',
            //     title: 'Change Password',
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => EditUserNameScreen(
            //             userName: 'Darku',
            //           ),
            //         ),
            //       );
            //     }),
            SettingsTile(
                svgIcon: 'assets/svgs/gift.svg',
                title: 'My Subscription',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MySubscriptionScreen()));
                }),
            SettingsTile(
              svgIcon: 'assets/svgs/trash-2.svg',
              title: 'Delete Account',
              onTap: () => _showDeleteAccountConfirmation(context),
            ),
          ]),
          ProfileSection(title: 'Periodic Follow-up', tiles: [
            SettingsTile(
                svgIcon: 'assets/svgs/applee.svg',
                title: 'Diet Assessments',
                subtitle: const CustomBadge(
                  text: 'Premium',
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AssessmentScreen(role: '0')));
                }),
            SettingsTile(
                svgIcon: 'assets/svgs/Dumbbell1.svg',
                title: 'Workout Assessments',
                subtitle: const CustomBadge(
                  text: 'Premium',
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AssessmentScreen(role: '1')));
                }),
          ]),
          ProfileSection(title: 'Settings', tiles: [
            SettingsTile(
                svgIcon: 'assets/svgs/belll.svg',
                title: 'Notifications',
                isShowIcon: true,
                isShowLogOut: true,
                onTap: () {}),
            SettingsTile(
                svgIcon: 'assets/svgs/waterdropp.svg',
                title: 'Water Reminder',
                onTap: () {
                  _showWaterSettingsConfirmation(context);
                }),
            SettingsTile(
                svgIcon: 'assets/svgs/globe-1.svg',
                title: 'Language',
                subtitle: const CustomBadge(
                  text: 'English',
                  textColor: blue700,
                  borderColor: blue700,
                  backgroundColor: Colors.white,
                ),
                onTap: () {
                  _showLanguageConfirmation(context);
                }),
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

void _showDeleteAccountConfirmation(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    builder: (BuildContext context) {
      return SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          child: Column(
            children: <Widget>[
              CustomHeaderWithCancel(
                title: 'Delete Account',
                onCancelPressed: () => Navigator.pop(context),
              ),
              SvgPicture.asset(
                'assets/svgs/trash1.svg',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    Text(
                      'Active subscription will be canceled and cannot be refunded',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: DArkBlue900,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'You will not be able to undo this action',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: DArkBlue900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              CustomButton(text: 'Yes', onPressed: () {}),
              const SizedBox(height: 8),
              CustomButton(text: 'No', onPressed: () {}, isShowDifferent: true),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    },
  );
}




void _showWaterSettingsConfirmation(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    builder: (BuildContext context) {
      return SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.65,
          ),
          child: Column(
            children: <Widget>[
              CustomHeaderWithCancel(
                title: 'Water Settings',
                onCancelPressed: () => Navigator.pop(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: grey200),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SettingsTile(
                                svgIcon: 'assets/svgs/belll.svg',
                                title: 'Reminder to Drink Water',
                                isShowIcon: true,
                                isShowLogOut: true,
                                onTap: () {}),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Text('How many times',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: DArkBlue900,
                        )),
                  ],
                ),
              ),
              SelectableContainerGroup(
                texts: ['1 time', '2 times', '3 times'],
                svgAssets: [
                  'assets/svgs/Frame 52676.svg',
                  'assets/svgs/Frame 52676.svg',
                  'assets/svgs/Frame 52676.svg',
                ],
              ),
              const SizedBox(height: 8),
              CustomButton(text: 'Save Change', onPressed: () {}),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    },
  );
}


void _showLanguageConfirmation(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.44,
          ),
          child: Column(
            children: <Widget>[
              CustomHeaderWithCancel(
                title: 'Change Language',
                onCancelPressed: () => Navigator.pop(context),
              ),
             
              
              SelectableContainerGroup(
                texts: ['English', 'عربي'],
                svgAssets: [
                  'assets/svgs/Frame 52676.svg',
                  'assets/svgs/Frame 52676.svg',
                  'assets/svgs/Frame 52676.svg',
                ],
              ),
              const SizedBox(height: 8),
              CustomButton(text: 'Save Change', onPressed: () {}),
              const SizedBox(height: 16),
            ],
          ),
        
      );
    },
  );
}
class CustomSelectableContainer extends StatelessWidget {
  final String text;
  final String svgAsset;
  final bool isSelected;
  final VoidCallback onTap;
  final String? imageAsset; 

  const CustomSelectableContainer({
    Key? key,
    required this.text,
    required this.svgAsset,
    required this.isSelected,
    required this.onTap,
    this.imageAsset, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(
              color: grey200,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              if (imageAsset != null) 
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Image.asset(imageAsset!),
                ),
              Text(text),
              Spacer(),
              SvgPicture.asset(
                isSelected
                    ? 'assets/svgs/selected.svg'
                    : 'assets/svgs/Frame 52676.svg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}


















class SelectableContainerGroup extends StatefulWidget {
  final List<String> texts;
  final List<String> svgAssets;
  

  const SelectableContainerGroup({
    Key? key,
    required this.texts,
    required this.svgAssets,
  }) : super(key: key);

  @override
  _SelectableContainerGroupState createState() =>
      _SelectableContainerGroupState();
}

class _SelectableContainerGroupState extends State<SelectableContainerGroup> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.texts.length, (index) {
        return CustomSelectableContainer(
          text: widget.texts[index],
          svgAsset: widget.svgAssets[index],
          imageAsset: widget.texts[index] == 'عربي' ? 'assets/images/flag.png' : 'assets/images/flag2.png',
          isSelected: _selectedIndex == index,
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
          },
        );
      }),
    );
  }
}