import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/colors.dart';

class InformationWidget extends StatelessWidget {
  final String locationText;
  final Color textColor;
  final double textSize;
  final String svg;
  final String text;

  const InformationWidget({
    Key? key,
    required this.locationText,
    this.textColor = colorDarkBlue,
    this.textSize = 13.0,
    this.svg = 'assets/svgs/location-12.svg',
    this.text = 'From \n',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

            SvgPicture.asset(svg),

        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: textSize,
                fontFamily: 'Cairo',
                color: textColor,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: text,
                  style: TextStyle(
                    fontSize: textSize,
                    color: grey3,
                    fontFamily: 'Cairo'
                  ),
                ),
               
                TextSpan(
                  text: locationText,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: textSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
