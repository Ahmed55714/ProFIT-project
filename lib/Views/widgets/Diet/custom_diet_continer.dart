import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';

class CustomDietContainer extends StatelessWidget {
  final String quantity;
  final String label;
  final String svgAsset;

  const CustomDietContainer({
    Key? key,
    required this.quantity,
    required this.label,
    required this.svgAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 98,
        decoration: BoxDecoration(
          color: grey50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quantity,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: blue700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: DArkBlue900,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SvgPicture.asset(svgAsset),
          ],
        ),
      ),
    );
  }
}
