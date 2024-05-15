import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import 'package:profit1/Views/widgets/Explore/Filters/custom_filter.dart';
import 'package:profit1/Views/widgets/General/customTextFeild.dart';
import 'package:profit1/Views/widgets/Explore/Trainers/trainer_continer.dart';
import 'package:profit1/Views/widgets/General/custom_loder.dart';

import '../../../../../utils/colors.dart';
import '../../../widgets/Explore/Trainers/free_diet.dart';
import '../../../widgets/Explore/Trainers/free_workout.dart';
import '../../../widgets/Explore/Trainers/vertical_trainer_continer.dart';
import '../../../widgets/General/customBotton.dart';
import 'All Trainer/all_trainers.dart';
import 'controller/trainer_controller.dart';
import 'model/trainer.dart';

class ExploreScreen extends StatefulWidget {
   ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
    final ExploreController exploreController = Get.put(ExploreController());

    // @override
    // void initState() {
    //   super.initState();
    //   exploreController.fetchTrainersForTrainer2();
    // }

   @override
Widget build(BuildContext context) {
  // Call fetchTrainersForTrainer2 when the controller is initialized
  exploreController.fetchTrainersForTrainer2();

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
            // Optionally include diet/workout sections
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
    itemCount: exploreController.trainer2.length.clamp(0, 10),
    itemBuilder: (context, index) {
      return TrainerCard(
        trainer: exploreController.trainer2[index],
        onFavoriteChanged: () => exploreController.toggleFavorite(exploreController.trainer2[index].id),
      );
    },
  );
}


    Widget buildRecommendedTrainersSection() {
      return Padding(
        padding: const EdgeInsets.only(right: 16),
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
      );
    }

   Widget buildHorizontalTrainerList() {
  return SizedBox(
    height: 303,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: exploreController.trainer2.length.clamp(0, 6),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(left: index == 0 ? 16 : 0, right: 16),
          child: VerticalTrainerCard(trainer: exploreController.trainer2[index]),
        );
      },
    ),
  );
}

    Widget buildFreeDietPlansSection() {
      return Column(
        children: List.generate(
          2,
          (index) => Column(
            children: [
              FreeDiet(isShowCard: true, key: ValueKey(index)),
              SizedBox(height: 16),
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
