import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../utils/colors.dart';
import '../../pages/BottomNavigationBar/Home/Map/map.dart';
import '../../pages/BottomNavigationBar/Home/Steps/steps.dart';
import '../BottomSheets/add_challenge.dart';
import '../BottomSheets/sleep_track.dart';
import '../General/customBotton.dart';
import '../timer/timer.dart';

class BannerCarousel extends StatefulWidget {
  @override
  _BannerCarouselState createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _current = 0;
  final List<String> imgList = [
    'assets/images/Component.jpg',
    'assets/images/Component2.jpg',
    'assets/images/Component3.jpg',
    // Add more image paths as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 22),
        CarouselSlider(
          items: imgList
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Image.asset(
                    item,
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            aspectRatio: 2.6,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => {}, // Optionally handle dot tap
              child: Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == entry.key
                      ? colorBlue
                      : colorBlue.withOpacity(0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}














class CustomInfoCard extends StatelessWidget {
  final String leftIconPath;
  final String rightIconPath;
  final String title;
  final double percentage;
  final Color borderColor;
  final Color titleColor;
  final Color percentageColor;
  final String Text1;
  final double width;
  final double height;
  final bool isShow;

  const CustomInfoCard({
    Key? key,
    required this.leftIconPath,
    required this.rightIconPath,
    required this.title,
    this.percentage = 0.5,
    this.borderColor = Colors.grey,
    this.titleColor = Colors.blue,
    this.percentageColor = Colors.green,
    this.Text1 = 'View Details',
    this.width = 167.5,
    this.height = 123,
    this.isShow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(leftIconPath),
                const SizedBox(width: 4),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                    fontFamily: 'BoldCairo',
                  ),
                ),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StepsScreen()));
                    },
                    child: SvgPicture.asset(rightIconPath, color: titleColor)),
              ],
            ),
            isShow
                ? const Text('176 Step | 0.009 Km',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: colorDarkBlue,
                    ))
                : Container(),
            Text(
              '${(percentage * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: percentageColor,
                fontFamily: 'BoldCairo',
              ),
            ),
            LinearPercentIndicator(
              padding: EdgeInsets.zero,
              lineHeight: 6.0,
              percent: percentage,
              barRadius: const Radius.circular(6),
              backgroundColor: borderColor,
              progressColor: percentageColor,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Spacer(),
                Text(
                  '$Text1',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: colorDarkBlue,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}















class CircularIndicatorWithIconAndText extends StatelessWidget {
  final double percentage;
  final Color backgroundColor;
  final Color progressColor;
  final String iconName;
  final String percentageText;

  const CircularIndicatorWithIconAndText({
    Key? key,
    required this.percentage,
    required this.backgroundColor,
    required this.progressColor,
    required this.iconName,
    required this.percentageText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 50.0,
      lineWidth: 8.0,
      percent: percentage,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            iconName,
          ),
          Text(
            percentageText,
            style: const TextStyle(
              color: wirdColor,
              fontWeight: FontWeight.w700,
              fontSize: 19.0,
            ),
          ),
        ],
      ),
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}



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














































