import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profit1/services/api_service.dart';
import '../../../../../utils/colors.dart';
import '../../../../widgets/Diet/custom_recipe_card.dart';
import '../../../../widgets/Diet/custom_text_icon_kal.dart';
import '../../../../widgets/General/customBotton.dart';
import '../../../../widgets/General/custom_loder.dart';
import '../../Plan Active/controller/plan_active.dart';
import '../controller/diet_plan_over.dart';

class Dinner extends StatefulWidget {
  final bool isExpanded;
  final String? planId;

  Dinner({Key? key, this.isExpanded = false, this.planId}) : super(key: key);

  @override
  _DinnerState createState() => _DinnerState();
}

class _DinnerState extends State<Dinner> {
  final DietPlanActiveController _activePlanController = Get.put(DietPlanActiveController());
  final ApiService _apiService = ApiService();
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    if (widget.isExpanded) {
      _fetchDataOnce();
    }
  }

  Future<void> _fetchDataOnce() async {
    if (!_isDataLoaded && widget.planId != null) {
      String? token = await _apiService.getToken();
      if (token != null && token.isNotEmpty) {
        await _activePlanController.fetchActivePlanDetails(widget.planId!);
        setState(() {
          _isDataLoaded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey50,
      body: FutureBuilder(
        future: _fetchDataOnce(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CustomLoder());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Obx(() {
              if (_activePlanController.isLoading.value) {
                return Center(child: CustomLoder());
              }

              final data = _activePlanController.activePlanDetails.value?.days ?? [];
              final meals = data.isNotEmpty
                  ? data[0].meals.where((meal) => meal.mealType == 'Dinner').toList()
                  : [];

              return ListView.builder(
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  final meal = meals[index];
                  return Column(
                    children: [
                      const MealInfoContainer(
                        mealIcon: 'assets/svgs/foody.svg',
                        mealName: 'Dinner',
                        description: 'A light dinner to end your day.',
                        nutrients: [
                          {'value': '15 gm', 'icon': 'assets/svgs/ch.svg'},
                          {'value': '10 gm', 'icon': 'assets/svgs/waterdropo.svg'},
                          {'value': '25 gm', 'icon': 'assets/svgs/food.svg'},
                          {'value': '300 Kcal', 'icon': 'assets/svgs/Flamea.svg'},
                        ],
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
            });
          }
        },
      ),
    );
  }
}






class Dinner2 extends StatelessWidget {
  final bool isExpanded;
  final String? planId;
  final PlanOverviewController _planOverviewController = Get.put(PlanOverviewController());
  final DietPlanActiveController _activePlanController = Get.put(DietPlanActiveController());
  final ApiService _apiService = ApiService();

  Dinner2({Key? key, this.isExpanded = false, this.planId}) : super(key: key);

  Future<void> _fetchData() async {
    if (isExpanded) {
      String? token = await _apiService.getToken();
      if (token != null) {
        await _planOverviewController.fetchNutritionPlanDetails(planId!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey50,
      body: FutureBuilder(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CustomLoder());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return FutureBuilder<String?>(
              future: _apiService.getToken(),
              builder: (context, tokenSnapshot) {
                if (tokenSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CustomLoder());
                } else if (tokenSnapshot.hasError || !tokenSnapshot.hasData || tokenSnapshot.data == null) {
                  return Center(child: Text('Error fetching token'));
                }

                final String token = tokenSnapshot.data!;
                
                return SingleChildScrollView(
                  child: Obx(() {
                    if (_planOverviewController.selectedPlanDetails.value == null) {
                      return Center(child: CustomLoder());
                    }

                    final data = _planOverviewController.selectedPlanDetails.value!.days;
                    final meals = data.isNotEmpty
                        ? data[0].meals.where((meal) => meal.mealType == 'Dinner').toList()
                        : [];

                    return Column(
                      children: [
                        isExpanded
                            ? const MealInfoContainer(
                                mealIcon: 'assets/svgs/foody.svg',
                                mealName: 'Dinner',
                                description: 'A light dinner to end your day.',
                                nutrients: [
                                  {'value': '15 gm', 'icon': 'assets/svgs/ch.svg'},
                                  {'value': '10 gm', 'icon': 'assets/svgs/waterdropo.svg'},
                                  {'value': '25 gm', 'icon': 'assets/svgs/food.svg'},
                                  {'value': '300 Kcal', 'icon': 'assets/svgs/Flamea.svg'},
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
                );
              },
            );
          }
        },
      ),
    );
  }
}