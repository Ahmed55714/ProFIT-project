import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../utils/colors.dart';

class CircularIndicatorWithIconAndText extends StatelessWidget {
  final double percentage;
  final Color backgroundColor;
  final Color progressColor;
  final String iconName;
  final String percentageText;
  final String total;
  final String kal;
  final bool isShowDiet;

  const CircularIndicatorWithIconAndText({
    Key? key,
    required this.percentage,
    required this.backgroundColor,
    required this.progressColor,
    required this.iconName,
     this.percentageText= '50%',
     this.total = '975',
     this.kal = '/1966 Kcal',
    this.isShowDiet = false,
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
          isShowDiet
              ? Column(
                  children: [
                    Text(
                      total,
                      style: TextStyle(
                        color: blue700,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                    SvgPicture.asset('assets/svgs/FlameRed.svg'),
                    Text(
                      kal,
                      style: TextStyle(
                        color: blue700,
                        fontWeight: FontWeight.w400,
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                )
              : Text(
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
