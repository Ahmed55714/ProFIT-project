import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import 'package:profit1/Views/widgets/Explore/Filters/custom_filter.dart';
import 'package:profit1/Views/widgets/General/customTextFeild.dart';
import 'package:profit1/Views/widgets/Explore/Trainers/trainer_continer.dart';

import '../../../../../utils/colors.dart';
import '../../../widgets/Explore/Trainers/free_diet.dart';
import '../../../widgets/Explore/Trainers/free_workout.dart';
import '../../../widgets/Explore/Trainers/vertical_trainer_continer.dart';
import '../../../widgets/General/customBotton.dart';
import 'All Trainer/all_trainers.dart';
import 'controller/trainer_controller.dart';




class ExploreScreen extends StatefulWidget {
   ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>  {
    final ExploreController exploreController = Get.put(ExploreController());
@override
  void initState() {
    super.initState();
    exploreController.fetchTrainers();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: 'Explore',
        isShowExplore: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: CustomTextField(
                labelText: 'Search Trainer Here',
                isShowSearch: true,
              ),
            ),
             const SizedBox(height: 16),
           Padding(
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
            ),
          
             SizedBox(height: 8),
          
            // ...List.generate(
            //   4,
            //   (index) => Column(
            //     children: [
            //       TrainerCard(key: ValueKey(index)),
            //       SizedBox(height: 16),
            //     ],
            //   ),
            // ),
           Obx(() {
              if (exploreController.trainers.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: exploreController.trainers.length.clamp(0, 6),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        TrainerCard(trainer: exploreController.trainers[index]),
                        
                      ],
                    );
                  },
              );
            }),


    
            Padding(
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
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 303,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.only(left: index == 0 ? 16 : 0, right: 16),
                    child: VerticalTrainerCard(),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
             Row(
               children: [
                 Expanded(
                   child: CustomLabelWidget(
                    title: 'Free Diet Plans By Our Expert Trainers',
                             ),
                 ),
               ],
             ),
             SizedBox(height: 8),
            ...List.generate(
              2,
              (index) => Column(
                children: [
                  FreeDiet(isShowCard: true ,key: ValueKey(index),),
                  SizedBox(height: 16),
                ],
              ),
            ),
          Row(
            children: [
              
               const CustomLabelWidget(
                    title: 'Free Workout Plans By Our Trainers',
                  ),
             
            ],
          ),
            SizedBox(height: 8),
           ...List.generate(
              2,
              (index) => Column(
                children: [
                  FreeWorkout(key: ValueKey(index)),
                  SizedBox(height: 16),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}
