import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:profit1/utils/colors.dart';

class HomeScreen extends StatelessWidget {
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
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                'assets/svgs/message-circle-lines.svg',
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                'assets/svgs/bell.svg',
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
                  Text(
                    'Today’s Mission',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: colorDarkBlue,
                      fontFamily: 'BoldCairo',
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomInfoCard(
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
                const SizedBox(width: 8),
                CustomInfoCard(
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
              ],
            ),
            const SizedBox(height: 8),
            CustomInfoCard(
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
            const SizedBox(height: 8),
            Container(
              width: 343,
              height: 194,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
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
                        const SizedBox(width: 90),
                        CircularIndicatorWithIconAndText(
                          percentage: 0.15,
                          backgroundColor: Colors.grey[200]!,
                          progressColor: wirdColor,
                          iconName: 'assets/svgs/droplet water.svg',
                          percentageText: '15%',
                        ),
                      ],
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
                SvgPicture.asset(rightIconPath, color: titleColor),
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
