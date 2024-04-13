import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/colors.dart';

class TextWithDot extends StatelessWidget {
  final String text;
  final bool isSvg;
  final bool noPadding;
  const TextWithDot({
    Key? key,
    required this.text,
    this.isSvg = false,
    this.noPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isSvg
          ? const EdgeInsets.only(left: 16.0)
          :  EdgeInsets.only(left: noPadding? 0.0 : 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isSvg
              ? Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: SvgPicture.asset('assets/svgs/Check.svg'),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Container(
                    width: 4,
                    height: 4,
                    color: colorDarkBlue,
                    margin: const EdgeInsets.only(top: 6),
                  ),
                ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: blueDot,
              ),
            ),
          ),
        ],
      ),
    );
  }
}