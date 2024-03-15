import 'package:flutter/widgets.dart';

import '../../../utils/colors.dart';

class TermsAndPrivacyText extends StatelessWidget {
  const TermsAndPrivacyText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextStyle(
      fontSize: 11,
      color: colorDarkBlue,
    );

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "By using Our services agreeing to ",
            style: baseStyle.copyWith(fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: "Terms ",
            style: baseStyle.copyWith(
              fontFamily: 'BoldCairo',
              fontWeight: FontWeight.w700,
              color: colorBlue,
            ),
          ),
          TextSpan(
            text: "and ",
            style: baseStyle.copyWith(fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: "Privacy Policy",
            style: baseStyle.copyWith(
              fontFamily: 'BoldCairo',
              fontWeight: FontWeight.w700,
              color: colorBlue,
            ),
          ),
        ],
      ),
    );
  }
}
