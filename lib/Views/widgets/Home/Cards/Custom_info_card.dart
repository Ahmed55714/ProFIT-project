import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../utils/colors.dart';
import '../../../pages/BottomNavigationBar/Home/Steps/steps.dart';

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