import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/colors.dart';

class CustomSleepTimeContainer extends StatelessWidget {
  final String label;
  final String time;
  final String svgIconPath;

  const CustomSleepTimeContainer({
    Key? key,
    required this.label,
    required this.time,
    required this.svgIconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 167.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: grey200),
        color: grey50,
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              color: grey500,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: colorBlue,
                  fontFamily: 'BoldCairo'
                ),
              ),
              SvgPicture.asset(svgIconPath),
            ],
          ),
        ],
      ),
    );
  }
}
