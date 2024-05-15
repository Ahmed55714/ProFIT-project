import 'package:flutter/material.dart';

import '../../../../../utils/colors.dart';

class TitleDescription extends StatelessWidget {
  final String title;
  final String? title2;
  final String description;
  final Color color;

  const TitleDescription({
    required this.title,
    required this.description,
     this.title2,
    this.color = DArkBlue900,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: color == DArkBlue900
                        ? FontWeight.w400
                        : FontWeight.w700,
                    color: color,
                    fontFamily: 'BoldCairo',
                  ),
                ),
                  const TextSpan(text: ' '),
                          TextSpan(
                            text: title2 ?? ''
                                '',
                          style: TextStyle(
                    fontSize: 16,
                    fontWeight: color == DArkBlue900
                        ? FontWeight.w400
                        : FontWeight.w700,
                    color: color,
                  ), ),
                const TextSpan(
                  text: '\n',
                  style: TextStyle(height: 1.2),
                ),
                TextSpan(
                  text: description,
                  style: TextStyle(
                    fontSize: color == DArkBlue900 ? 13 : 11,
                    fontWeight: FontWeight.w400,
                    color: grey500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}