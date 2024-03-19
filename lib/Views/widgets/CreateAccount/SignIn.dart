// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:profit1/utils/colors.dart';

class GoogleLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  final String svg;

  const GoogleLoginButton({
    Key? key,
    required this.onTap,
    required this.svg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: grey50,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(svg
            ,width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
