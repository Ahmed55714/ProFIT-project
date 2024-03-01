// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/colors.dart';
import '../Heart Rate/heart_rate.dart';

class StepsScreen extends StatefulWidget {
  const StepsScreen({super.key});

  @override
  State<StepsScreen> createState() => _StepsScreenState();
}

class _StepsScreenState extends State<StepsScreen> {
  String dropdownValue = 'Last 7 Days';

  void _handleDropdownChange(String? newValue) {
    if (newValue != null) {
      setState(() {
        dropdownValue = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Steps',
        showContainer: true,
        dropdownValue: dropdownValue,
        onDropdownChanged: _handleDropdownChange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                MaximumContainer(label: 'Maximum', value: 450, svg: 'assets/svgs/trending-up.svg',),
                MaximumContainer(label: 'Minimum', value: 150,svg: 'assets/svgs/trending-down.svg',),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MaximumContainer extends StatelessWidget {
  final int value;
  final String label;
  final String svg;

  MaximumContainer({
    Key? key,
    required this.value,
    required this.label,
    required this.svg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 163, 
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: grey200),
          ),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center, 
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: grey500,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$value', 
                    style: TextStyle(
                      color: colorBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Spacer(), 
             SvgPicture.asset(svg, width: 24, height: 24),
            ],
          ),
          alignment: Alignment.centerRight, 
          
        ),
      ),
    );
  }
}

class StepsBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 500,
              barTouchData: BarTouchData(
                enabled: false,
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  margin: 10,
                  showTitles: true,
                  getTextStyles: (context, value) => const TextStyle(
                    color: Color(0xff939393),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  getTitles: (double value) {
                    switch (value.toInt()) {
                      case 0:
                        return 'Jan 1';
                      case 1:
                        return 'Jan 2';
                      case 2:
                        return 'Jan 3';
                      case 3:
                        return 'Jan 4';
                      case 4:
                        return 'Jan 5';
                      case 5:
                        return 'Jan 6';
                      case 6:
                        return 'Jan 7';
                      default:
                        return '';
                    }
                  },
                ),
                leftTitles: SideTitles(showTitles: false),
              ),
              gridData: FlGridData(
                show: true,
                checkToShowHorizontalLine: (value) => value % 100 == 0,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: const Color(0xffe7e8ec),
                  strokeWidth: 1,
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: [
                BarChartGroupData(x: 0, barRods: [
                  BarChartRodData(y: 150, colors: [Colors.lightBlueAccent, Colors.blueAccent])
                ]),
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(y: 200, colors: [Colors.lightBlueAccent, Colors.blueAccent])
                ]),
                // Add more BarChartGroupData similarly for Jan 3 to Jan 7
              ],
            ),
          ),
        ),
      ),
    );
  }
}