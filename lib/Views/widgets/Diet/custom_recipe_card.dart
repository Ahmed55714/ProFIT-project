import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';
import '../../pages/Diet/Diet Plan Overview/Meals/Breakfast.dart';
import '../../pages/Diet/Diet Plan Overview/model/diet_over_plan.dart';
import '../BottomSheets/add_challenge.dart';
import '../Explore/Trainer Details/Packages/package.dart';
import '../Explore/Trainer Details/Packages/text_dot.dart';
import '../General/customBotton.dart';
import '../General/custom_loder.dart';
import 'custom_image_and_details.dart';
import 'custom_text_icon_kal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';
import 'custom_text_icon_kal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/colors.dart';
import '../../pages/Diet/Diet Plan Overview/model/diet_over_plan.dart';
import 'custom_text_icon_kal.dart';
import 'custom_image_and_details.dart';

class CustomRecipeCard1 extends StatelessWidget {
  final Meal meal;

  const CustomRecipeCard1({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          _showBottomSheet(context, meal);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageStack(meal),
                  const SizedBox(width: 16),
                  _buildRecipeDetails(meal),
                  const Spacer(),
                  SvgPicture.asset('assets/svgs/refreach.svg'),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(
                color: grey200,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextWithIcon(
                        text: '${meal.mealMacros.proteins.toStringAsFixed(0)} gm',
                        svgPath: 'assets/svgs/ch.svg',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomTextWithIcon(
                        text: '${meal.mealMacros.fats.toStringAsFixed(0)} gm',
                        svgPath: 'assets/svgs/waterdropo.svg',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomTextWithIcon(
                        text: '${meal.mealMacros.carbs.toStringAsFixed(0)} gm',
                        svgPath: 'assets/svgs/food.svg',
                      ),
                    ),
                   const SizedBox(width: 8),
                    Expanded(
                      child: CustomTextWithIcon(
                        text: '${meal.mealMacros.calories.toStringAsFixed(0)} Kcal',
                        svgPath: 'assets/svgs/Flamea.svg',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageStack(Meal meal) {
    return Stack(
      children: [
     ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: Container(
    width: 80,
    height: 80,
    child: Stack(
      children: [
        Center(
          child: CustomLoder(), 
        ),
        Center(
          child: Image.network(
            meal.foods.first.foodImage,
            fit: BoxFit.cover,
            width: 80,
            height: 80,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              }
            },
          ),
        ),
      ],
    ),
  ),
),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0.5),
                  Colors.black,
                ],
                stops: const [0, 1, 1],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: '${meal.foods.first.amount} ',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                          ),
                        ),
                        const TextSpan(
                          text: 'gm',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset('assets/images/checkbox.png'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecipeDetails(Meal meal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          meal.mealName,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: colorDarkBlue,
          ),
        ),
        ...meal.foods.map((food) => SizedBox(
          height: 20,
          width: 120,
          child: TextWithDot(
            noPadding: true,
            text: '${food.amount} ${food.servingUnit} ${food.foodName}',
          ),
        )).toList(),
      ],
    );
  }

  void _showBottomSheet(BuildContext context, Meal meal) {
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
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.72,
            ),
            child: Column(
              children: <Widget>[
                CustomHeaderWithCancel(
                  title: meal.mealName,
                  onCancelPressed: () => Navigator.pop(context),
                ),
                CustomStackedImage(image: meal.foods.first.foodImage),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    children: [
                      CustomTextWithIcon(
                        text: '${meal.mealMacros.proteins} gm',
                        svgPath: 'assets/svgs/ch.svg',
                      ),
                      const SizedBox(width: 8),
                      CustomTextWithIcon(
                        text: '${meal.mealMacros.fats} gm',
                        svgPath: 'assets/svgs/waterdropo.svg',
                      ),
                      const SizedBox(width: 8),
                      CustomTextWithIcon(
                        text: '${meal.mealMacros.carbs} gm',
                        svgPath: 'assets/svgs/food.svg',
                      ),
                      const Spacer(),
                      CustomTextWithIcon(
                        text: '${meal.mealMacros.calories} Kcal',
                        svgPath: 'assets/svgs/Flamea.svg',
                      ),
                    ],
                  ),
                ),
                ...meal.foods.map((food) => TextWithDot(
                  text: '${food.amount} ${food.servingUnit} ${food.foodName}',
                )).toList(),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Mark Food as Finished',
                  onPressed: () {},
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
