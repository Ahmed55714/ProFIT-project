import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class DayContainer extends StatelessWidget {
  final String day;
  final String date;
  final Color backgroundColorNumber;
  final Color BackGroundContiner;
  final Color NumberColorBackGround;
  final Color colorDay;

  const DayContainer({
    Key? key,
    required this.day,
    required this.date,
    required this.backgroundColorNumber,
    this.BackGroundContiner = colorBlue,
    this.NumberColorBackGround = green400,
    this.colorDay = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 69,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        color: BackGroundContiner,
      ),
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
      ),
      child: Column(
        children: [
          Text(
            day,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: NumberColorBackGround,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                date,
                style: TextStyle(
                  color: colorDay,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

