import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/Explore/Trainers/free_diet.dart';
import '../../Tabs/Explore/controller/nutration_controller.dart';

class PlansFavourites extends StatelessWidget {
  const PlansFavourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NutritionPlanController nutritionPlanController = Get.put(NutritionPlanController());

    nutritionPlanController.fetchFavoriteNutritionPlans();

    return Obx(() {
      if (nutritionPlanController.favoriteNutritionPlans.isEmpty) {
        return Center(
          child: Text("No favorite plans found",
          style: TextStyle(
            
          
            color: Colors.black,
            fontFamily: 'Cairo'
            )
          ),
        );
      }

      return SingleChildScrollView(
        child: Column(
          children: List.generate(
            nutritionPlanController.favoriteNutritionPlans.length,
            (index) {
              final plan = nutritionPlanController.favoriteNutritionPlans[index];
              return Column(
                children: [
                  ExploreDiet(
                    isShowCard: true,
                    key: ValueKey(plan.id),
                    plan: plan,
                  ),
                  SizedBox(height: 16),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}
