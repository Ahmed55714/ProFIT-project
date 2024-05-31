import 'package:flutter/material.dart';

import '../../../../../utils/colors.dart';

class TitleDescription extends StatelessWidget {
  final String title;
  final String? title2;
  final String description;
  final Color color;
  final Color color2;

  const TitleDescription({
    required this.title,
    required this.description,
     this.title2,
    this.color = colorBlue,
    this.color2 = colorBlue,
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
                    fontWeight: FontWeight.w700,
                          
                    
                  ), ),
                const TextSpan(
                  text: '\n',
                  style: TextStyle(height: 1.2),
                ),
                TextSpan(
                  text: description,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: color2,
                     fontFamily: 'Cairo',
                     height: 1.3,
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