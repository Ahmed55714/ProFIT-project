import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/api_service.dart';
import '../../../widgets/Explore/Trainers/free_diet.dart';
import '../../../widgets/General/customBotton.dart';
import '../../../widgets/General/custom_loder.dart';
import 'controller/free_plan_controller.dart';


class FreePlans extends StatelessWidget {
  final DietPlanController controller = Get.put(DietPlanController(ApiService()));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Obx(() {
          if (controller.isLoading.value) {
            return CustomLoder();
          }
          return Column(
            children: controller.dietPlans.map((plan) {
              return Column(
                children: [
                  const CustomLabelWidget(title: 'Free Diet Plans'),
                  FreeDiet(
                    isShowCard: false,
                    plan: plan,
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }).toList(),
          );
        }),
        const SizedBox(height: 224),
      ],
    );
  }
}
