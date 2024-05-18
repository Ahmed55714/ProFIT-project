// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../utils/colors.dart';
import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/Home/Graph/custom_graph.dart';

class StepsScreen extends StatefulWidget {
  String title;
  String asset;
  StepsScreen({
    Key? key,
    this.title = 'Steps',
    this.asset = 'assets/svgs/ic_round-directions-run.svg',
  }) : super(key: key);

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
        titleText: widget.title,
        dropdownValue: dropdownValue,
        onDropdownChanged: _handleDropdownChange,
        isShowDropdown: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                MaximumContainer(
                  label: 'Maximum',
                  value: 450,
                  svg: 'assets/svgs/trending-up.svg',
                ),
                MaximumContainer(
                  label: 'Minimum',
                  value: 150,
                  svg: 'assets/svgs/trending-down.svg',
                ),
              ],
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(widget.asset,
                      width: 24, height: 24),
                  const SizedBox(width: 4),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: colorDarkBlue,
                      fontFamily: 'BoldCairo',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            BarChartSample2(),
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
          alignment: Alignment.centerRight,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: grey500,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$value',
                    style: const TextStyle(
                      color: colorBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'BoldCairo',
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SvgPicture.asset(svg, width: 24, height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
