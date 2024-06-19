import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/colors.dart';
import '../../../../widgets/Diet/custom_recipe_card.dart';
import '../../../../widgets/General/customBotton.dart';
import '../controller/diet_plan_over.dart';

class Dinner extends StatelessWidget {
  final PlanOverviewController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey50,
      body: Obx(() {
        return ListView.builder(
          itemCount: _controller.dinnerMeals.length,
          itemBuilder: (context, index) {
            final meal = _controller.dinnerMeals[index];
            return Column(
              children: [
                const CustomLabelWidget(
                      title: 'Meal Receipe',
                    ),
                CustomRecipeCard1(
                  key: ValueKey(meal.id),
                  meal: meal,
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        );
      }),
    );
  }
}
