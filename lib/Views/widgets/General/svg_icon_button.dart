import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';

class SvgIconButton extends StatefulWidget {
  final String svgIcon;
  final VoidCallback onSelect;
  final String text;
  final bool isClicked;

  SvgIconButton({
    required this.svgIcon,
    required this.onSelect,
    required this.text,
    required this.isClicked,
  });

  @override
  _SvgIconButtonState createState() => _SvgIconButtonState();
}

class _SvgIconButtonState extends State<SvgIconButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelect();
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: widget.isClicked ? backGround : Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              widget.svgIcon,
              color: widget.isClicked ? colorBlue : colorBlue,
              width: 56,
              height: 56,
            ),
            Text(
              widget.text,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'BoldCairo',
                  color: widget.isClicked ? colorBlue : colorBlue),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
