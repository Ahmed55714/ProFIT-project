import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:profit1/Views/widgets/General/custom_loder.dart';

import '../../../../../utils/colors.dart';
import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/Home/Graph/custom_graph.dart';
import 'controller/step_controller.dart';

class StepsScreen extends StatelessWidget {
  final String title;
  final String asset;

  StepsScreen({required this.title, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: title,
        dropdownValue: 'Last 7 Days',
        onDropdownChanged: (String? newValue) {},
        isShowDropdown: true,
      ),
      body: GetX<StepsControllergraph>(
        init: StepsControllergraph(),
        builder: (controller) {
          if (controller.isLoading.value) {
            return Center(child: CustomLoder());
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      MaximumContainer(
                        label: 'Maximum',
                        value: controller.weeklySteps.map((e) => e.steps).reduce((a, b) => a > b ? a : b),
                        svg: 'assets/svgs/trending-up.svg',
                      ),
                      MaximumContainer(
                        label: 'Minimum',
                        value: 500,
                        //controller.weeklySteps.map((e) => e.steps).reduce((a, b) => a < b ? a : b),
                        svg: 'assets/svgs/trending-down.svg',
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(asset, width: 24, height: 24),
                        const SizedBox(width: 4),
                        Text(
                          title,
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
                  BarChartSample2(data: controller.weeklySteps),
                ],
              ),
            );
          }
        },
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
