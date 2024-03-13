import 'package:profit1/Views/widgets/BottomSheets/water_needs.dart'
    as water_needs;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/utils/colors.dart';

import '../../../widgets/BottomSheets/add_challenge.dart';
import '../../../widgets/BottomSheets/sleep_track.dart';
import '../../../widgets/BottomSheets/water_needs.dart';
import '../../../widgets/Home/custom_home_components.dart';
import '../../../widgets/timer/timer.dart';
import 'Chat/chat.dart';
import 'Heart Rate/heart_rate.dart';
import 'Notifications/Notification.dart';

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
            const Row(
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
              onRecordTime: () {
                
              },
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
                    height: 100,
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
class ChallengeCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String iconPath;
  final Color borderColor;

  const ChallengeCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.iconPath,
    this.borderColor = Colors.grey,
  }) : super(key: key);

  @override
  _ChallengeCardState createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<ChallengeCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final isAssetImage = widget.imagePath.startsWith('assets/');
    Widget imageWidget;

    if (isAssetImage) {
      // For asset images
      imageWidget = Image.asset(widget.imagePath,
          width: 40, height: 30, fit: BoxFit.cover);
    } else {
      // For file images
      final imageFile = File(widget.imagePath);
      imageWidget = ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Image.file(imageFile, width: 40, height: 30, fit: BoxFit.cover),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        width: isExpanded ? 343 : 171,
        height: isExpanded ? 210 : 106,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: widget.borderColor.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: isExpanded
            ? ExpandedContent(
                title: widget.title,
                onGiveUpPressed: () {
                  print("User gave up on the challenge.");
                  setState(() {
                    isExpanded = false;
                  });
                },
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16),
                    child: imageWidget,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: colorBlue,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Start Challenge',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                          SvgPicture.asset(
                            widget.iconPath,
                            width: 24,
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// Expanded content widget
class ExpandedContent extends StatefulWidget {
  final String title;
  final VoidCallback onGiveUpPressed;

  const ExpandedContent({
    Key? key,
    required this.title,
    required this.onGiveUpPressed,
  }) : super(key: key);

  @override
  _ExpandedContentState createState() => _ExpandedContentState();
}

class _ExpandedContentState extends State<ExpandedContent> {
  bool showDelayedContent = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          showDelayedContent = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    fontSize: 14,
                    color: colorBlue,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          if (showDelayedContent) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    'try to stick the challenge for at least 21 days',
                    style: TextStyle(
                        fontSize: 11,
                        color: grey500,
                        fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionButton(
                  text: 'Give up!',
                  onPressed: widget.onGiveUpPressed,
                  isShowIcon: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CountUpTimer(
                    duration: Duration(days: 1000),
                    onCompleted: () {
                      print('CountUpTimer Completed');
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class ChallengesListWidget extends StatefulWidget {
  final List<Challenge> challenges;

  const ChallengesListWidget({Key? key, required this.challenges})
      : super(key: key);

  @override
  _ChallengesListWidgetState createState() => _ChallengesListWidgetState();
}

class _ChallengesListWidgetState extends State<ChallengesListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.challenges.length,
        itemBuilder: (context, index) {
          final challenge = widget.challenges[index];
          return ChallengeCard(
            imagePath: challenge.imagePath,
            title: challenge.title,
            iconPath: 'assets/svgs/right.svg',
          );
        },
      ),
    );
  }
}
