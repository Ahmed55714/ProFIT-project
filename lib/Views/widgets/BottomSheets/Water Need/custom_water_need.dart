import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/utils/colors.dart';

import '../../CircularIndicator/circular_indicator.dart';
import '../../Home/Banner/BannerCarousel.dart';

class WaterNeedsWidget extends StatelessWidget {
  final bool isShowSvg;
  final String headerText;
  final String progressText;
  final String goalText;
  final String buttonText;
  final String? Svg;

  const WaterNeedsWidget({
    Key? key,
    required this.isShowSvg,
    required this.headerText,
    required this.progressText,
    required this.goalText,
    required this.buttonText,
    this.Svg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: 343,
              height: 194,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headerRow(),
                    const SizedBox(height: 8),
                    progressRow(),
                    actionButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget headerRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset('assets/svgs/mingcute_glass-cup-fill.svg'),
        const SizedBox(width: 4),
        Text(
          headerText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: colorDarkBlue,
            fontFamily: 'BoldCairo',
          ),
        ),
        const Spacer(),
        SvgPicture.asset('assets/svgs/right.svg', color: colorDarkBlue),
      ],
    );
  }

  Widget progressRow() {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$progressText \n',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: wirdColor,
                  fontFamily: 'BoldCairo',
                ),
              ),
              TextSpan(
                text: '$goalText',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: wirdColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 90),
        isShowSvg
            ? Image.asset(Svg!)
            : CircularIndicatorWithIconAndText(
                percentage: 0.15,
                backgroundColor: Colors.grey[200]!,
                progressColor: wirdColor,
                iconName: 'assets/svgs/droplet water.svg',
                percentageText: '15%',
              ),
      ],
    );
  }

  Widget actionButton() {
    return Container(
      width: 138,
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF5FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SvgPicture.asset(
            'assets/svgs/plus.svg',
            color: colorBlue,
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              buttonText,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: colorBlue,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

