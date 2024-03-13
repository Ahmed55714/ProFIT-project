import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isShowIcon;
  final String? icon;
  final bool isShowSmall;
  final bool isShowDifferent; 

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isShowIcon = false,
    this.icon,
    this.isShowSmall = false,
    this.isShowDifferent = false, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Adjust padding based on isShowDifferent
    final padding = !isShowIcon && !isShowDifferent
        ? const EdgeInsets.only(left: 16, right: 16)
        : const EdgeInsets.only(left: 16);

    return Padding(
      padding: padding,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: isShowDifferent ? Colors.white : isShowIcon ? backgroundBlue : colorBlue, // Button color
          onPrimary: isShowDifferent ? colorBlue : Colors.white, // Text color
          minimumSize: isShowSmall ? const Size(111, 48) : const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: isShowDifferent ? const BorderSide(color: colorBlue) : BorderSide.none, // Border color
          ),
        ),
        child: isShowIcon && icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.26,
                      fontFamily: 'BoldCairo',
                      color: isShowDifferent ? colorBlue : Colors.white, // Adjust text color
                    ),
                  ),
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    icon!,
                  ),
                ],
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.26,
                  fontFamily: 'BoldCairo',
                  color: isShowDifferent ? colorBlue : Colors.white, // Adjust text color
                ),
              ),
      ),
    );
  }
}


class TermsAndPrivacyText extends StatelessWidget {
  const TermsAndPrivacyText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: "By using Our services agreeing to ",
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: colorDarkBlue,
            ),
          ),
          TextSpan(
            text: "Terms ",
            style: TextStyle(
              fontFamily: 'BoldCairo',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: colorBlue,
            ),
          ),
          TextSpan(
            text: "and ",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: colorDarkBlue,
            ),
          ),
          TextSpan(
            text: "Privacy Policy",
            style: TextStyle(
              fontFamily: 'BoldCairo',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: colorBlue,
            ),
          ),
        ],
      ),
    );
  }
}
