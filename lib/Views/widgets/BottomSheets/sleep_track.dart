import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/Views/widgets/customBotton.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../../../utils/colors.dart'; // Ensure this path is correct for your color definitions

class SleepTrackBottomSheet extends StatefulWidget {
  const SleepTrackBottomSheet({Key? key}) : super(key: key);

  @override
  _SleepTrackBottomSheetState createState() => _SleepTrackBottomSheetState();
}

class _SleepTrackBottomSheetState extends State<SleepTrackBottomSheet> {
  final Color baseColor = Color.fromRGBO(255, 255, 255, 0.3);
  late int initTime;
  late int endTime;
  int _hours = 0;
  int _minutes = 0;

  @override
  void initState() {
    super.initState();
    initTime = _generateRandomTime();
    endTime = _generateRandomTime();
    _updateLabelsBasedOnSlider(initTime, endTime);
  }

  void _updateLabelsBasedOnSlider(int init, int end) {
    setState(() {
      _hours = (end - init) ~/ 12;
      _minutes = ((end - init) % 12) * 5;
    });
  }

  int _generateRandomTime() => math.Random().nextInt(288);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.63,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Sleep Track",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset('assets/images/Group124.png'),
                      SleekCircularSlider(
                        appearance: CircularSliderAppearance(
                          customWidths:
                              CustomSliderWidths(progressBarWidth: 12),
                          customColors: CustomSliderColors(
                            progressBarColor: colorBlue, // Adjust to your color
                            trackColor: Colors.grey[300]!,
                            dotColor: Colors.white,
                          ),
                          size: 200.0,
                          infoProperties: InfoProperties(
                              mainLabelStyle: TextStyle(
                                  color: Colors.white, fontSize: 24.0),
                              modifier: (percentage) {
                                final hours = ((_hours + (_minutes / 60)) *
                                        (percentage / 100))
                                    .toStringAsFixed(0);
                                final minutes = (((_hours + (_minutes / 60)) *
                                            (percentage / 100)) %
                                        1 *
                                        60)
                                    .toStringAsFixed(0);
                                return "";
                              }),
                        ),
                        initialValue: 50, // Starting point of the slider
                        onChange: (double value) {
                          final totalMinutes = (value / 100 * 288 * 5).round();
                          setState(() {
                            _hours = totalMinutes ~/ 60;
                            _minutes = totalMinutes % 60;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$_hours ',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color:
                                blue500, // Ensure this matches your color scheme
                            fontFamily: 'BoldCairo',
                          ),
                        ),
                        TextSpan(
                          text: 'hrs ',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color:
                                blue500, // Ensure this matches your color scheme
                          ),
                        ),
                        TextSpan(
                          text: '$_minutes ',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color:
                                blue500, // Ensure this matches your color scheme
                            fontFamily: 'BoldCairo',
                          ),
                        ),
                        TextSpan(
                          text: 'mins',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color:
                                blue500, // Ensure this matches your color scheme
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Row(
                    children: [
                      CustomSleepTimeContainer(
                        label: 'Fall asleep time',
                        time: '11:03 PM',
                        svgIconPath: 'assets/svgs/moon.svg',
                      ),
                      SizedBox(width: 16),
                      CustomSleepTimeContainer(
                        label: 'Woke up',
                        time: '03 : 51 AM',
                        svgIconPath: 'assets/svgs/sun.svg',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                CustomButton(text: 'Add Sleep Time', onPressed: () {}),
                SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomSleepTimeContainer extends StatelessWidget {
  final String label;
  final String time;
  final String svgIconPath;

  const CustomSleepTimeContainer({
    Key? key,
    required this.label,
    required this.time,
    required this.svgIconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 167.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: grey200),
        color: grey50,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              color: grey500,
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: colorBlue,
                ),
              ),
              SvgPicture.asset(svgIconPath),
            ],
          ),
        ],
      ),
    );
  }
}
