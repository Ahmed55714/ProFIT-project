import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:profit1/Views/widgets/BottomSheets/water_needs.dart'
    as water_needs;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/utils/colors.dart';

import '../../../widgets/BottomSheets/add_challenge.dart';
import '../../../widgets/BottomSheets/water_needs.dart';
import '../../../widgets/General/customBotton.dart';
import '../../../widgets/Home/Banner/BannerCarousel.dart';
import '../../../widgets/Home/Cards/Custom_info_card.dart';
import '../../../widgets/Home/Cards/custom_card.dart';
import '../../../widgets/Home/Cards/custom_challeng_card.dart';
import '../../../widgets/Home/Rounded Continer/custom_rounded_continer.dart';
import '../../Features/Chat/chat.dart';
import '../../Features/Heart Rate/heart_rate.dart';
import '../../Features/Notifications/Notification.dart';
import '../../Profile/Account Data/controller/profile_controller.dart';
import '../../Profile/profile Screen/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final int? heartRate;

  HomeScreen({Key? key, this.heartRate}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Challenge> challenges = [
    Challenge(imagePath: 'assets/images/candy.png', title: 'No Sugar'),
    Challenge(imagePath: 'assets/images/pizza.png', title: 'No Fast Food'),
  ];

  void _showAddChallengeModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddChallengeBottomSheet(
        onChallengeAdded: (Challenge challenge) {
          setState(() {
            challenges.add(challenge);
          });
        },
      ),
    );
  }

  void _showWaterNeedsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => WaterNeedsBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBlue,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              child: Obx(() {
                var userProfile = profileController.profile.value;
                return userProfile == null
                    ? CircularProgressIndicator()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CircleAvatar(
                          radius: 21,
                          child: userProfile?.profilePhoto != null
                              ? Image.network(
                                  userProfile!.profilePhoto,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/images/profileHome.png',
                                        width: 100,
                                        height: 100);
                                  },
                                )
                              : Image.asset(
                                  'assets/images/profileHome.png', // Default placeholder image
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      );
              }),
            ),
            const SizedBox(width: 16),
            //profileHome.png'
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Hello 👋',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
                  Obx(() {
                    return RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: profileController.profile.value?.firstName ??
                                '',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: SvgPicture.asset(
                                'assets/svgs/smellLeft.svg',
                                width: 24,
                                height: 24,
                                color: Colors.white,
                              ),
                            ),
                            alignment: PlaceholderAlignment.middle,
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatSCreen()));
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  'assets/svgs/message-circle-lines.svg',
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {},
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationScreen()));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(
                    'assets/svgs/bell.svg',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerCarousel(),
            const SizedBox(height: 24),
            Row(
              children: [
                CustomLabelWidget(
                  title: 'Today’s Mission',
                ),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomInfoCard(
                      leftIconPath: 'assets/svgs/apple.svg',
                      rightIconPath: 'assets/svgs/right.svg',
                      title: 'Diet',
                      percentage: 0.5,
                      borderColor: Colors.grey[200]!,
                      titleColor: colorDarkBlue,
                      percentageColor: green500,
                      Text1: '975 / 1966 Kcal',
                      width: 167.5,
                      height: 123,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: CustomInfoCard(
                      leftIconPath: 'assets/svgs/Dumbbelll.svg',
                      rightIconPath: 'assets/svgs/right.svg',
                      title: 'Workout',
                      percentage: 0.7,
                      borderColor: Colors.grey[200]!,
                      titleColor: colorDarkBlue,
                      percentageColor: redColor,
                      Text1: '7 / 10 Exercises',
                      width: 167.5,
                      height: 123,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  Expanded(
                    child: CustomInfoCard(
                      leftIconPath: 'assets/svgs/ic_round-directions-run.svg',
                      rightIconPath: 'assets/svgs/right.svg',
                      title: 'Steps',
                      percentage: 0.7,
                      borderColor: Colors.grey[200]!,
                      titleColor: colorDarkBlue,
                      percentageColor: pinkColor,
                      Text1: '176 / 1000 Steps',
                      width: 343,
                      height: 144,
                      isShow: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 343,
                      height: 208,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!, width: 1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                    'assets/svgs/mingcute_glass-cup-fill.svg'),
                                SizedBox(width: 4),
                                Text(
                                  'Water Needs',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: colorDarkBlue,
                                    fontFamily: 'BoldCairo',
                                  ),
                                ),
                                Spacer(),
                                SvgPicture.asset('assets/svgs/right.svg',
                                    color: colorDarkBlue),
                              ],
                            ),
                            SizedBox(height: 8),
                            water_needs.WaterNeedsWidget(
                              currentIntakeML: 500,
                              goalIntakeML: 3500,
                            ),
                            Expanded(
                                child: ActionButton(
                              text: 'Add Cup (250mL)',
                              onPressed: () =>
                                  _showWaterNeedsBottomSheet(context),
                            )),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: RoundedContainerWithRow(
                text: 'Nearest Gym',
                buttonIconPath: 'assets/svgs/search.svg',
                iconPath: 'assets/svgs/Location.svg',
              ),
            ),
            const SizedBox(height: 24),
            const CustomLabelWidget(
              title: 'Health Tracking',
            ),
            const SizedBox(height: 16),
            CustomCard(
              title: "Sleep Tracking",
              number: "5",
              text1: 'hrs',
              minutes: "30",
              date: "12/5/2002",
              imagePath: 'assets/images/124.png',
              icon: 'assets/svgs/sleep1.svg',
              onRecordTime: () {},
            ),
            const SizedBox(height: 24),
            CustomCard(
              title: "Heart Rate",
              number: widget.heartRate?.toString() ?? '--',
              text1: 'BPM\n',
              date: "12/5/2002",
              imagePath: 'assets/images/heart.png',
              icon: 'assets/svgs/heart.svg',
              onRecordTime: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HeartRateScreen()));
              },
              isShow: false,
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                // Call the method when 'Add Challenge' is tapped.
                _showAddChallengeModalBottomSheet(context);
              },
              child: Row(
                children: [
                  const CustomLabelWidget(
                    title: 'Challenges',
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/svgs/plus.svg',
                    width: 24,
                    height: 24,
                    color: colorDarkBlue,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Add Challenge',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: colorDarkBlue,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 110,
                    child: ChallengesListWidget(
                      challenges: challenges,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 76),
          ],
        ),
      ),
    );
  }
}

// Callenge Card in home screen
