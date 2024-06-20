import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../services/api_service.dart';
import '../../../../../utils/colors.dart';
import '../../../../widgets/Diet/custom_recipe_card.dart';
import '../../../../widgets/Diet/custom_text_icon_kal.dart';
import '../../../../widgets/General/customBotton.dart';
import '../../../../widgets/General/custom_loder.dart';
import '../../Plan Active/controller/plan_active.dart';
import '../controller/diet_plan_over.dart';

class BreakFast extends StatelessWidget {
  final bool isExpanded;
  final PlanOverviewController _planOverviewController = Get.find();
  final ActivePlanController _activePlanController = Get.put(ActivePlanController());
  final ApiService _apiService = ApiService();

  BreakFast({Key? key, this.isExpanded = false}) : super(key: key);

  void _fetchData() {
    if (isExpanded) {
      _apiService.getToken().then((token) {
        if (token != null) {
         // _activePlanController.fetchDietPlans(token); 
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isExpanded) {
      _fetchData(); // Fetch data when isExpanded is true
    }

    return Scaffold(
      backgroundColor: grey50,
      body: SingleChildScrollView(
        child: Obx(() {
          if (isExpanded) {
            if (_activePlanController.selectedPlanDetails.value.id!.isEmpty) {
              return Center(child: CustomLoder());
            }
          } else {
            if (_planOverviewController.selectedPlanDetails.value == null) {
              return Center(child: CustomLoder());
            }
          }

          final meals = isExpanded
              ? _activePlanController.selectedPlanDetails.value.days.isNotEmpty 
                ? _activePlanController.selectedPlanDetails.value.days[0].meals.where((meal) => meal.mealType == 'Breakfast').toList()
                : []
              : _planOverviewController.breakfastMeals;

          return Column(
            children: [
              isExpanded
                  ? const MealInfoContainer(
                      mealIcon: 'assets/svgs/foody.svg',
                      mealName: 'Breakfast',
                      description:
                          'Balanced breakfast to start your day.',
                      nutrients: [
                        {'value': '10 gm', 'icon': 'assets/svgs/ch.svg'},
                        {'value': '10 gm', 'icon': 'assets/svgs/waterdropo.svg'},
                        {'value': '20 gm', 'icon': 'assets/svgs/food.svg'},
                        {'value': '200 Kcal', 'icon': 'assets/svgs/Flamea.svg'},
                      ],
                    )
                  : const CustomLabelWidget(
                      title: 'Meal Recipe',
                    ),
              ...meals.map((meal) => Column(
                    children: [
                      CustomRecipeCard1(
                        key: ValueKey(meal.id),
                        meal: meal,
                      ),
                      const SizedBox(height: 16),
                    ],
                  )),
            ],
          );
        }),
      ),
    );
  }
}
