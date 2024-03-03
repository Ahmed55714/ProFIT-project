import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/utils/colors.dart';

import '../../../widgets/custom_home_components.dart';
import 'Chat/chat.dart';
import 'Heart Rate/heart_rate.dart';
import 'Notifications/Notification.dart';

class HomeScreen extends StatelessWidget {
  final int? heartRate;

  HomeScreen({Key? key, this.heartRate}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBlue,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: Image.asset('assets/images/profileHome.png'),
              backgroundColor: colorBlue,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Hello 👋',
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Ahmed Badawy ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      WidgetSpan(
                        child: SvgPicture.asset(
                          'assets/svgs/smellLeft.svg',
                        ),
                        alignment: PlaceholderAlignment.middle,
                      ),
                    ],
                  ),
                ),
              ],
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
              onTap: () {
                
              },
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationScreen()));
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
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  CustomLabelWidget(
                    title: 'Today’s Mission',
                  ),
                ],
              ),
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
              padding: const EdgeInsets.only(left: 16, right: 16),
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
                        padding:
                            const EdgeInsets.only(left: 16, top: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                    'assets/svgs/mingcute_glass-cup-fill.svg'),
                                const SizedBox(width: 4),
                                const Text(
                                  'Water Needs',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: colorDarkBlue,
                                    fontFamily: 'BoldCairo',
                                  ),
                                ),
                                const Spacer(),
                                SvgPicture.asset('assets/svgs/right.svg',
                                    color: colorDarkBlue),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '500 ML \n',
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w400,
                                          color: wirdColor,
                                          fontFamily: 'BoldCairo',
                                        ),
                                      ),
                                      TextSpan(
                                        text: '/ 3500 ML',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color: wirdColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 120),
                                CircularIndicatorWithIconAndText(
                                  percentage: 0.15,
                                  backgroundColor: Colors.grey[200]!,
                                  progressColor: wirdColor,
                                  iconName: 'assets/svgs/droplet water.svg',
                                  percentageText: '15%',
                                ),
                              ],
                            ),
                            Expanded(
                                child: ActionButton(text: 'Add Cup (250mL)')),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            RoundedContainerWithRow(
              text: 'Nearest Gym',
              buttonIconPath: 'assets/svgs/search.svg',
              iconPath: 'assets/svgs/Location.svg',
            ),
            const SizedBox(height: 24),
            CustomLabelWidget(
              title: 'Health Tracking',
            ),
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
            SizedBox(height: 24),
            CustomCard(
              title: "Heart Rate",
              number: heartRate?.toString() ?? '--',
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
            SizedBox(height: 24),
            Row(
              children: [
                CustomLabelWidget(
                  title: 'Challenges',
                ),
                Spacer(),
                SvgPicture.asset(
                  'assets/svgs/plus.svg',
                  width: 24,
                  height: 24,
                  color: colorDarkBlue,
                ),
                SizedBox(width: 8),
                Text(
                  'Add Challenge',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: colorDarkBlue,
                      fontSize: 13),
                ),
                SizedBox(width: 16),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ChallengeCard(
                    imagePath: 'assets/images/candy.png',
                    title: 'No Sugar',
                    iconPath: 'assets/svgs/right.svg',
                  ),
                ),
                Expanded(
                  child: ChallengeCard(
                    imagePath: 'assets/images/pizza.png',
                    title: 'No Fast Food',
                    iconPath: 'assets/svgs/right.svg',
                  ),
                ),
              ],
            ),
            SizedBox(height: 76),
          ],
        ),
      ),
    );
  }
}
