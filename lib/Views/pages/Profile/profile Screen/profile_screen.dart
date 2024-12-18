import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:profit1/Views/pages/Explore/Package/controller/subscription_details.dart';
import 'package:profit1/Views/pages/Registration/Sign%20In/SignIn.dart';
import 'package:profit1/Views/pages/Registration/Sign%20Up/SignUp.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';
import 'package:profit1/Views/widgets/General/custom_loder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Account Data/controller/profile_controller.dart';
import '../../../../utils/colors.dart';
import '../../../widgets/BottomSheets/add_challenge.dart';
import '../../../widgets/Explore/Trainer Details/Packages/title_description.dart';
import '../../../widgets/Profile/profile.dart';
import '../Account/Assessment/controller/diet_assessment_controller.dart';
import '../Account/Personal Data/controller/presonal_data_controller.dart';
import '../Account/Assessment/Old Diet Assessment/submit_new_assessments.dart';
import '../Account/My Subscription/my_subscription.dart';
import '../Account/Personal Data/personalData.dart';
import '../Account Data/accountData.dart';
import 'package:http/http.dart' as http;

import 'terms_and_policies.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final ProfileController profileController = Get.find<ProfileController>();

  Future<void> fetchImage(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final dir = await getTemporaryDirectory();
    _image = File('${dir.path}/profile.jpg');
    await _image!.writeAsBytes(bytes);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    profileController.fetchUserProfile().then((_) {
      if (profileController.profile.value?.profilePhoto != null) {
        fetchImage(profileController.profile.value!.profilePhoto);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey50,
      appBar: CustomAppBar(
        titleText: 'Profile',
        showContainer: true,
      ),
      body: Obx(() {
        var userProfile = profileController.profile.value;
        return ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountData()));
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
                      userProfile == null
                          ? CustomLoder()
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 21,
                                child: userProfile?.profilePhoto != null
                                    ? Image.network(
                                        userProfile!.profilePhoto,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                              'assets/images/profileHome.png',
                                              width: 100,
                                              height: 100);
                                        },
                                      )
                                    : Image.asset(
                                        'assets/images/profileHome.png',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                      const SizedBox(width: 16),
                      TitleDescription(
                        title: userProfile?.firstName ?? 'Name',
                        title2: userProfile?.lastName ?? '',
                        description: userProfile?.email ?? 'Email',
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
                    Get.to(() => PersonalDataScreen(),
                        binding: BindingsBuilder(() {
                      Get.put(PersonalDataController());
                    }));
                  }),
              SettingsTile(
                  svgIcon: 'assets/svgs/gift.svg',
                  title: 'My Subscription',
                  onTap: () {
                    Get.to(
                      () => const MySubscriptionScreen(),
                       binding: BindingsBuilder(() {
                      Get.put(CheckoutController());
                    })
                    );
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

                  
                  Get.put(DietAssessmentController());
                  Get.to(() => const AssessmentScreen(role: '0'));
                
                   
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
                            builder: (context) =>
                                const AssessmentScreen(role: '1')));
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
                  onTap: () {
                    Get.to(() => const TermsAndPolicies());
                  }),
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
        );
      }),
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
          height: 180,
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
                onPressed: () async {
                  await _clearToken();
                  Get.back();
                  Get.offAll(() => const SignInScreen());
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
                  Get.back();
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

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('lastResetSteps');

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
      final profileController = Get.find<
          ProfileController>();
      return SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.55,
          ),
          child: Column(
            children: <Widget>[
              CustomHeaderWithCancel(
                title: 'Delete Account',
                onCancelPressed: () => Get.back(),
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
                            fontWeight: FontWeight.w700, fontSize: 16)),
                    SizedBox(height: 8),
                    Text('You will not be able to undo this action',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 13)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              CustomButton(
                  text: 'Yes',
                  onPressed: () {
                    profileController.deleteAccount(context);
                    Get.offAll(() => const SignUp());
                  }),
              const SizedBox(height: 8),
              CustomButton(
                  text: 'No',
                  onPressed: () => Get.back(),
                  isShowDifferent: true),
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
            maxHeight: MediaQuery.of(context).size.height * 0.55,
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
              const Padding(
                padding: EdgeInsets.only(left: 16),
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
              const SelectableContainerGroup(
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
          maxHeight: MediaQuery.of(context).size.height * 0.38,
        ),
        child: Column(
          children: <Widget>[
            CustomHeaderWithCancel(
              title: 'Change Language',
              onCancelPressed: () => Navigator.pop(context),
            ),
            const SelectableContainerGroup(
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
  final bool isShow;

  const CustomSelectableContainer({
    Key? key,
    required this.text,
    required this.svgAsset,
    required this.isSelected,
    required this.onTap,
    this.imageAsset,
    this.isShow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSelected ? blue50 : Colors.white,
            border: Border.all(
              color: isSelected ? colorBlue : grey200,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              if (imageAsset != null && !isShow)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Image.asset(imageAsset!),
                ),
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? colorBlue : DArkBlue900,
                ),
              ),
              const Spacer(),
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
  final Function(int)? onSelection;
  final int initialIndex;

  const SelectableContainerGroup({
    Key? key,
    required this.texts,
    required this.svgAssets,
    this.onSelection,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _SelectableContainerGroupState createState() =>
      _SelectableContainerGroupState();
}

class _SelectableContainerGroupState extends State<SelectableContainerGroup> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.texts.length, (index) {
        String? imageAsset;
        if (widget.texts[index] == 'عربي') {
          imageAsset = 'assets/images/flag.png';
        } else if (widget.texts[index] == 'English') {
          imageAsset = 'assets/images/flag2.png';
        }

        return CustomSelectableContainer(
          text: widget.texts[index],
          svgAsset: widget.svgAssets[index],
          imageAsset: imageAsset,
          isSelected: _selectedIndex == index,
          onTap: () {
            if (_selectedIndex != index) {
              setState(() {
                _selectedIndex = index;
              });
              if (widget.onSelection != null) {
                widget.onSelection!(index);
              }
            }
          },
        );
      }),
    );
  }
}
