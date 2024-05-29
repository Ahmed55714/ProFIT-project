
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/colors.dart';
import '../../../pages/Features/Water Need/controller/water_controller.dart';
import '../../General/customBotton.dart';
import '../add_challenge.dart';
import 'water_needs.dart';

void showWaterNeedsBottomSheet(BuildContext context) {
  final WaterController controller = Get.put(WaterController());

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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeaderWithCancel(
                title: "Water Needs",
                onCancelPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 16),
              Obx(() => WaterNeedsWidget(
                    currentIntakeML: controller.waterIntake.value.toDouble(),
                    goalIntakeML: controller.waterGoal.value.toDouble(),
                  )),
              const SizedBox(height: 16),
              _buildActionButtons(context, controller),
              const SizedBox(height: 3),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildActionButtons(BuildContext context, WaterController controller) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildResetButton(controller),
          _buildFillAllAddCupButtons(controller),
        ],
      ),
      const SizedBox(height: 16),
      SetGoalText(
        onTap: () => controller.setWaterGoal(),
      ),
    ],
  );
}

Widget _buildResetButton(WaterController controller) {
  return GestureDetector(
    onTap: () => controller.resetWaterIntake(),
    child: Row(
      children: [
        Text('Reset',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: colorBlue)),
        const SizedBox(width: 10),
        SvgPicture.asset('assets/svgs/refresh-small.svg'),
        const SizedBox(width: 10),
      ],
    ),
  );
}

Widget _buildFillAllAddCupButtons(WaterController controller) {
  return Wrap(
    children: [
      CustomButton(
          text: 'Fill All',
          onPressed: () => controller.fillAll(),
          isShowSmall: true,
          isShowDifferent: true),
      CustomButton(
          text: 'Add Cup',
          onPressed: () => controller.addCup(),
          isShowSmall: true,
          isPadding: true),
    ],
  );
}

