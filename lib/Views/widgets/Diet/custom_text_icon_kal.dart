import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';

class CustomTextWithIcon extends StatelessWidget {
  final String svgPath;
  final double spacing;
  final String text;
  final TextStyle? textStyle;

  const CustomTextWithIcon({
    Key? key,
    required this.svgPath,
    this.spacing = 4.0,
    required this.text,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          svgPath,
        ),
        SizedBox(width: spacing),
        Text(
          text,
          style: textStyle ??
              const TextStyle(
                color: colorDarkBlue,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}












class MealInfoContainer extends StatelessWidget {
  final String mealIcon;
  final String mealName;
  final String description;
  final List<Map<String, String>> nutrients;

  const MealInfoContainer({
    Key? key,
    required this.mealIcon,
    required this.mealName,
    required this.description,
    required this.nutrients,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: grey200,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(mealIcon),
                const SizedBox(width: 8),
                Text(
                  mealName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: DArkBlue900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: DArkBlue900,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < nutrients.length; i++)
                  Row(
                    children: [
                      CustomTextWithIcon(
                        text: nutrients[i]['value'] ?? '',
                        svgPath: nutrients[i]['icon'] ?? '',
                      ),
                      if (i == 2) const SizedBox(width: 84),
                      if (i != nutrients.length - 1 && i != 2)
                        const SizedBox(width: 8),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}