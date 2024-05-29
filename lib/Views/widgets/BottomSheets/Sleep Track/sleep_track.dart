import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'dart:math' as math;

import '../../General/customBotton.dart';
import 'sleep_track_continer.dart';

void showSleepTrackBottomSheet(BuildContext context) {
  final Color baseColor = const Color.fromRGBO(255, 255, 255, 0.3);
  late int initTime;
  late int endTime;
  int _hours = 0;
  int _minutes = 0;

  void _updateLabelsBasedOnSlider(int init, int end) {
    _hours = (end - init) ~/ 12;
    _minutes = ((end - init) % 12) * 5;
  }

  int _generateRandomTime() => math.Random().nextInt(288);

  // Initialize the state variables
  initTime = _generateRandomTime();
  endTime = _generateRandomTime();
  _updateLabelsBasedOnSlider(initTime, endTime);

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    builder: (BuildContext context) {
      return SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.58,
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
                        customWidths: CustomSliderWidths(progressBarWidth: 12),
                        customColors: CustomSliderColors(
                          progressBarColor: Colors.blue,
                          trackColor: Colors.grey[300]!,
                          dotColor: Colors.white,
                        ),
                        size: 200.0,
                        infoProperties: InfoProperties(
                          mainLabelStyle: const TextStyle(
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
                          },
                        ),
                      ),
                      initialValue: 50, // Starting point of the slider
                      onChange: (double value) {
                        final totalMinutes = (value / 100 * 288 * 5).round();
                        _hours = totalMinutes ~/ 60;
                        _minutes = totalMinutes % 60;
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
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                          fontFamily: 'BoldCairo',
                        ),
                      ),
                      const TextSpan(
                        text: 'hrs ',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(
                        text: '$_minutes ',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                          fontFamily: 'BoldCairo',
                        ),
                      ),
                      const TextSpan(
                        text: 'mins',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.only(left: 16),
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
              const SizedBox(height: 16),
              CustomButton(text: 'Add Sleep Time', onPressed: () {}),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    },
  );
}

