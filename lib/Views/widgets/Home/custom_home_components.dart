import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../utils/colors.dart';
import '../../pages/BottomNavigationBar/Home/Map/map.dart';
import '../../pages/BottomNavigationBar/Home/Steps/steps.dart';
import '../BottomSheets/sleep_track.dart';

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

class WaterNeedsWidget extends StatelessWidget {
  final bool isShowSvg;
  final String headerText;
  final String progressText;
  final String goalText;
  final String buttonText;
  final String? Svg;

  const WaterNeedsWidget({
    Key? key,
    required this.isShowSvg,
    required this.headerText,
    required this.progressText,
    required this.goalText,
    required this.buttonText,
    this.Svg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
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
                    headerRow(),
                    const SizedBox(height: 8),
                    progressRow(),
                    actionButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget headerRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset('assets/svgs/mingcute_glass-cup-fill.svg'),
        const SizedBox(width: 4),
        Text(
          headerText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: colorDarkBlue,
            fontFamily: 'BoldCairo',
          ),
        ),
        const Spacer(),
        SvgPicture.asset('assets/svgs/right.svg', color: colorDarkBlue),
      ],
    );
  }

  Widget progressRow() {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$progressText \n',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: wirdColor,
                  fontFamily: 'BoldCairo',
                ),
              ),
              TextSpan(
                text: '$goalText',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: wirdColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 90),
        isShowSvg
            ? Image.asset(Svg!)
            : CircularIndicatorWithIconAndText(
                percentage: 0.15,
                backgroundColor: Colors.grey[200]!,
                progressColor: wirdColor,
                iconName: 'assets/svgs/droplet water.svg',
                percentageText: '15%',
              ),
      ],
    );
  }

  Widget actionButton() {
    return Container(
      width: 138,
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF5FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SvgPicture.asset(
            'assets/svgs/plus.svg',
            color: colorBlue,
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              buttonText,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: colorBlue,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomLabelWidget extends StatelessWidget {
  final String title;

  const CustomLabelWidget({
    Key? key,
    this.title = 'Today’s Mission',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: colorDarkBlue,
              fontFamily: 'BoldCairo',
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String text;
  final bool isShowIcon;
  final VoidCallback onPressed;

  ActionButton({
    Key? key,
    required this.text,
    this.isShowIcon = true,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: backgroundBlue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: IntrinsicWidth(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (isShowIcon)
                SvgPicture.asset(
                  'assets/svgs/plus.svg',
                  color: colorBlue,
                  width: 16,
                  height: 16,
                ),
              if (isShowIcon) const SizedBox(width: 4),
              Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: colorBlue,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedContainerWithRow extends StatelessWidget {
  final String text;
  final String buttonIconPath;
  final String iconPath;

  const RoundedContainerWithRow({
    Key? key,
    required this.text,
    required this.buttonIconPath,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 121,
          decoration: BoxDecoration(
            color: blue600,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const GymMapScreen()));
                        },
                        icon: SvgPicture.asset(
                          buttonIconPath,
                          color: colorBlue,
                          width: 16,
                          height: 16,
                        ),
                        label: const Text(
                          'Search',
                          style: TextStyle(
                            color: colorBlue,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: colorBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 260,
          child: Container(
            width: 135,
            height: 135,
            decoration: const BoxDecoration(
              color: blue500,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SvgPicture.asset(
                iconPath,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String number;
  final String? minutes;
  final String date;
  final String imagePath;
  final String icon;
  final bool isShow;
  final String text1;
  final VoidCallback onRecordTime;
  final int? heartRate;

  const CustomCard({
    Key? key,
    required this.title,
    required this.number,
    this.minutes,
    required this.date,
    required this.imagePath,
    required this.onRecordTime,
    required this.icon,
    this.isShow = true,
    required this.text1,
    this.heartRate,
  }) : super(key: key);
  void _showSleepTrackBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SleepTrackBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    String displayHeartRate = heartRate?.toString() ?? '--';
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        width: double.infinity,
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
                  SvgPicture.asset(icon),
                  const SizedBox(width: 4),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isShow ? blue500 : redColor,
                      fontFamily: 'BoldCairo',
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onRecordTime,
                    child: SvgPicture.asset('assets/svgs/right.svg',
                        color: colorBlue),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '$number ',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400,
                                  color: isShow ? blue500 : redColor,
                                  fontFamily: 'BoldCairo',
                                ),
                              ),
                              TextSpan(
                                text: '${text1} ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: isShow
                                      ? blue500
                                      : redColor, // Adjust according to your color scheme
                                ),
                              ),
                              if (isShow) ...[
                                TextSpan(
                                  text: '$minutes ',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w400,
                                    color: isShow ? blue500 : redColor,
                                    fontFamily: 'BoldCairo',
                                  ),
                                ),
                                TextSpan(
                                  text: 'mins\n',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: isShow ? blue500 : redColor,
                                  ),
                                ),
                              ],
                              TextSpan(
                                text: date,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: isShow ? blue500 : redColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ActionButton(
                          onPressed: isShow
                              ? () {
                                  _showSleepTrackBottomSheet(context);
                                }
                              : () {
                                },
                          text: isShow ? 'Record Time' : 'Record Measure',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28, bottom: 25),
                    child: Image.asset(imagePath),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
