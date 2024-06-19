import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/colors.dart';
import '../../../../widgets/Diet/custom_recipe_card.dart';
import '../../../../widgets/Diet/custom_text_icon_kal.dart';
import '../../../../widgets/General/customBotton.dart';
import '../../../../widgets/General/custom_loder.dart';
import '../controller/diet_plan_over.dart';

class BreakFast extends StatelessWidget {
  final PlanOverviewController _controller = Get.find();
  final bool isExpanded;

  BreakFast({Key? key, this.isExpanded = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey50,
      body: SingleChildScrollView(
        child: Obx(() {
          if (_controller.selectedPlanDetails.value == null) {
            return  Center(child: CustomLoder());
          }
          return Column(
            children: [
              isExpanded
                  ? const MealInfoContainer(
                      mealIcon: 'assets/svgs/foody.svg',
                      mealName: 'Breakfast',
                      description:
                          'تذكر توازن البروتينات والكربوهيدرات، وضع خطة مُكيَّفة لاحتياجاتك الفردية. استمر في تناول وجبات الفطور بانتظام لتعزيز نشاطك اليومي والحفاظ على صحتك',
                      nutrients: [
                        {'value': '10 gm', 'icon': 'assets/svgs/ch.svg'},
                        {'value': '10 gm', 'icon': 'assets/svgs/waterdropo.svg'},
                        {'value': '20 gm', 'icon': 'assets/svgs/food.svg'},
                        {'value': '200 Kcal', 'icon': 'assets/svgs/Flamea.svg'},
                      ],
                    )
                  : const CustomLabelWidget(
                      title: 'Meal Receipe',
                    ),
              if (!isExpanded)
                ..._controller.breakfastMeals.map((meal) => Column(
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
