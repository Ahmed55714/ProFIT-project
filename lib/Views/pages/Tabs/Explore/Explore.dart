import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import 'package:profit1/Views/widgets/General/customTextFeild.dart';
import 'package:profit1/Views/widgets/Explore/Trainers/trainer_continer.dart';
import 'package:profit1/Views/widgets/General/custom_loder.dart';

import '../../../../../utils/colors.dart';
import '../../../widgets/Explore/Trainers/free_diet.dart';
import '../../../widgets/Explore/Trainers/free_workout.dart';
import '../../../widgets/Explore/Trainers/vertical_trainer_continer.dart';
import '../../../widgets/General/customBotton.dart';
import '../Diet/Diet.dart';
import '../WorkOut/Workout.dart';
import 'All Trainer/all_trainers.dart';
import 'controller/nutration_controller.dart';
import 'controller/trainer_controller.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final ExploreController exploreController = Get.put(ExploreController());
  final NutritionPlanController nutritionPlanController = Get.put(NutritionPlanController());

  @override
  Widget build(BuildContext context) {
    exploreController.fetchTrainersForTrainer2();
    nutritionPlanController.fetchNutritionPlans();

    return Scaffold(
      backgroundColor: grey50,
      appBar: CustomAppBar(
        titleText: 'Explore',
        isShowExplore: true,
      ),
      body: Obx(() {
        if (exploreController.trainer2.isEmpty) {
          return Center(child: CustomLoder(color: colorBlue, size: 35));
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: CustomTextField(
                  labelText: 'Search Trainer Here',
                  isShowSearch: true,
                  isShowColor: true,
                ),
              ),
              const SizedBox(height: 16),
              buildFeaturedTrainersSection(),
              const SizedBox(height: 8),
              buildTrainersList(),
              buildRecommendedTrainersSection(),
              const SizedBox(height: 8),
              buildHorizontalTrainerList(),
              const SizedBox(height: 16),
              buildNutrationSection(), 
              
              buildNutritionSection(),
              const SizedBox(height: 8),
         
              buildWorkOutSection(),
              const SizedBox(height: 8),
              buildFreeWorkoutPlansSection(),
            ],
          ),
        );
      }),
    );
  }

  Widget buildFeaturedTrainersSection() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        children: [
          const CustomLabelWidget(
            title: 'Featured Trainers',
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Get.to(AllTrainers());
            },
            child: Row(
              children: [
                const Text(
                  'See More',
                  style: TextStyle(
                    color: colorDarkBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SvgPicture.asset('assets/svgs/chevron-small-right.svg')
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTrainersList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: exploreController.trainersAtoZ.length.clamp(0, 6),
      itemBuilder: (context, index) {
        return TrainerCard(
          trainer: exploreController.trainersAtoZ[index],
          
          onFavoriteChanged: () => exploreController.toggleFavorite(exploreController.trainersAtoZ[index].id),
        );
      },
    );
  }

  Widget buildRecommendedTrainersSection() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () {
          Get.to(AllTrainers());
        },
        child: Row(
          children: [
            const CustomLabelWidget(
              title: 'Recommended Trainers',
            ),
            const Spacer(),
            const Text(
              'See More',
              style: TextStyle(
                color: colorDarkBlue,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            SvgPicture.asset('assets/svgs/chevron-small-right.svg')
          ],
        ),
      ),
    );
  }

  Widget buildHorizontalTrainerList() {
    return SizedBox(
      height: 303,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: exploreController.trainersZtoA.length.clamp(0, 6),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 16 : 0, right: 16),
            child: VerticalTrainerCard(trainer: exploreController.trainersZtoA[index]),
          );
        },
      ),
    );
  }

 Widget buildNutritionSection() {
    final plansToShow = nutritionPlanController.nutritionPlans.take(2).toList();

    return Column(
      children: plansToShow.map((plan) {
        return ExploreDiet(
          isShowCard: true,
          plan: plan,
        );
      }).toList(),
    );
  }


   Widget buildNutrationSection() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () {
          Get.to(DietScreen());
        },
        child: Row(
          children: [
            const CustomLabelWidget(
              title: 'Recommended Plans',
            ),
            const Spacer(),
            const Text(
              'See More',
              style: TextStyle(
                color: colorDarkBlue,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            SvgPicture.asset('assets/svgs/chevron-small-right.svg')
          ],
        ),
      ),
    );
  }

  Widget buildWorkOutSection() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () {
          Get.to(WorkoutScreen());
        },
        child: Row(
          children: [
            const CustomLabelWidget(
              title: 'Recommended Trainers',
            ),
            const Spacer(),
            const Text(
              'See More',
              style: TextStyle(
                color: colorDarkBlue,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            SvgPicture.asset('assets/svgs/chevron-small-right.svg')
          ],
        ),
      ),
    );
  }

  Widget buildFreeWorkoutPlansSection() {
    return Column(
      children: List.generate(
        2,
        (index) => Column(
          children: [
            FreeWorkout(key: ValueKey(index)),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
