import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';
import '../../pages/Diet/Diet Plan Overview/model/diet_over_plan.dart';
import '../../pages/Diet/Plan Active/controller/plan_active.dart';
import '../BottomSheets/add_challenge.dart';
import '../Explore/Trainer Details/Packages/text_dot.dart';
import '../General/customBotton.dart';
import '../General/custom_loder.dart';
import 'package:http/http.dart' as http;

import 'custom_text_icon_kal.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';


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
                        text:
                            '${meal.mealMacros.proteins.toStringAsFixed(0)} gm',
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
                        text:
                            '${meal.mealMacros.calories.toStringAsFixed(0)} Kcal',
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
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
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
        ...meal.foods
            .map((food) => SizedBox(
                  height: 20,
                  width: 120,
                  child: TextWithDot(
                    noPadding: true,
                    text: '${food.amount} ${food.servingUnit} ${food.foodName}',
                  ),
                ))
            .toList(),
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
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: Column(
              children: <Widget>[
                CustomHeaderWithCancel(
                  title: meal.mealName,
                  onCancelPressed: () => Navigator.pop(context),
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        meal.foods.first.foodImage,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Center(
                            child: Icon(Icons.error, color: Colors.red),
                          );
                        },
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
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
                ...meal.foods
                    .map((food) => TextWithDot(
                          text:
                              '${food.amount} ${food.servingUnit} ${food.foodName}',
                        ))
                    .toList(),
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






class CustomRecipeCard2 extends StatelessWidget {
  final Meal meal;
  final String planId;
  final String token;
  final int dayIndex;
  final int mealIndex;

  CustomRecipeCard2({
    Key? key,
    required this.meal,
    required this.planId,
    required this.token,
    required this.dayIndex,
    required this.mealIndex,
  }) : super(key: key);

  Future<void> updateFoodConsumedStatus({
    required String planId,
    required int dayIndex,
    required int mealIndex,
    required List<Map<String, dynamic>> foods,
    required bool markMeal,
  }) async {
    final url = 'https://pro-fit.onrender.com/api/v1/trainees/Diet/updateFoodConsumedStatus/$planId';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = json.encode({
      'dayIndex': dayIndex,
      'mealIndex': mealIndex,
      'foods': foods,
      'markMeal': markMeal,
    });

    final response = await http.patch(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      print('Food consumed status updated successfully');
      // Fetch updated plan details to refresh the UI
      final dietController = Get.find<DietPlanActiveController>();
      await dietController.fetchActivePlanDetails(planId);
    } else {
      throw Exception('Failed to update food consumed status');
    }
  }

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
            child: Image.network(
              meal.foods.first.foodImage,
              fit: BoxFit.cover,
              width: 80,
              height: 80,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return const Center(
                  child: Icon(Icons.error, color: Colors.red),
                );
              },
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
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
        ...meal.foods
            .map((food) => SizedBox(
                  height: 20,
                  width: 120,
                  child: TextWithDot(
                    noPadding: true,
                    text: '${food.amount} ${food.servingUnit} ${food.foodName}',
                  ),
                ))
            .toList(),
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
              maxHeight: MediaQuery.of(context).size.height * 0.64,
            ),
            child: Column(
              children: <Widget>[
                CustomHeaderWithCancel(
                  title: meal.mealName,
                  onCancelPressed: () => Navigator.pop(context),
                ),
                Container(
                  width: double.infinity,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        meal.foods.first.foodImage,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Center(
                            child: Icon(Icons.error, color: Colors.red),
                          );
                        },
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    children: [
                      CustomTextWithIcon(
                        text: '${meal.mealMacros.proteins.toStringAsFixed(0)} gm',
                        svgPath: 'assets/svgs/ch.svg',
                      ),
                      const SizedBox(width: 8),
                      CustomTextWithIcon(
                        text: '${meal.mealMacros.fats.toStringAsFixed(0)} gm',
                        svgPath: 'assets/svgs/waterdropo.svg',
                      ),
                      const SizedBox(width: 8),
                      CustomTextWithIcon(
                        text: '${meal.mealMacros.carbs.toStringAsFixed(0)} gm',
                        svgPath: 'assets/svgs/food.svg',
                      ),
                      const Spacer(),
                      CustomTextWithIcon(
                        text: '${meal.mealMacros.calories.toStringAsFixed(0)} Kcal',
                        svgPath: 'assets/svgs/Flamea.svg',
                      ),
                    ],
                  ),
                ),
                ...meal.foods
                    .map((food) => TextWithDot(
                          text: '${food.amount} ${food.servingUnit} ${food.foodName}',
                        ))
                    .toList(),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Mark Food as Finished',
                  onPressed: () async {
                    try {
                      final List<Map<String, dynamic>> foods = meal.foods
                          .asMap()
                          .entries
                          .map((entry) => {
                                'foodIndex': entry.key,
                                'consumed': true,
                              })
                          .toList();

                      await updateFoodConsumedStatus(
                        planId: planId,
                        dayIndex: dayIndex,
                        mealIndex: mealIndex,
                        foods: foods,
                        markMeal: false,
                      );
                      Navigator.pop(context);

                      // Update daily macros with real data
                      final dietController = Get.find<DietPlanActiveController>();
                      await dietController.fetchActivePlanDetails(planId);
                      Get.snackbar('Success', 'Food marked as finished');
                    } catch (e) {
                      Get.snackbar('Error', 'Failed to mark food as finished');
                    }
                  },
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
