import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../../utils/colors.dart';
import '../../../pages/Features/Heart Rate/heart_rate.dart';
import '../../BottomSheets/sleep_track.dart';
import '../../General/customBotton.dart';
import '../Banner/BannerCarousel.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String number;
  final String? minutes;
  final String date;
  final String imagePath;
  final String icon;
  final bool isShow;
  final String text1;
  final VoidCallback onRecordTime;
  final int? heartRate;
  final Function? onPress;

  const CustomCard({
    Key? key,
    required this.title,
    required this.number,
    this.minutes,
    required this.date,
    required this.imagePath,
    required this.onRecordTime,
    required this.icon,
    this.isShow = true,
    required this.text1,
    this.heartRate,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        width: double.infinity,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(icon),
                  const SizedBox(width: 4),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isShow ? blue500 : redColor,
                      fontFamily: 'BoldCairo',
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onRecordTime,
                    child: SvgPicture.asset('assets/svgs/right.svg',
                        color: colorBlue),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '$number ',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400,
                                  color: isShow ? blue500 : redColor,
                                  fontFamily: 'BoldCairo',
                                ),
                              ),
                              TextSpan(
                                text: '${text1} ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: isShow ? blue500 : redColor,
                                ),
                              ),
                              if (isShow) ...[
                                TextSpan(
                                  text: '$minutes ',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w400,
                                    color: isShow ? blue500 : redColor,
                                    fontFamily: 'BoldCairo',
                                  ),
                                ),
                                TextSpan(
                                  text: 'mins\n',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: isShow ? blue500 : redColor,
                                  ),
                                ),
                              ],
                              TextSpan(
                                text: date,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: isShow ? blue500 : redColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ActionButton(
                          onPressed: isShow
                              ? () {
                                onPress!();
                              }
                              : () {
                                  Get.to(() => HeartRateScreen());
                                },
                          text: isShow ? 'Record Time' : 'Record Measure',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28, bottom: 25),
                    child: Image.asset(imagePath),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
