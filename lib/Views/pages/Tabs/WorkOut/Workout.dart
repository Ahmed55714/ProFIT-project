import 'package:flutter/material.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';

import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/Diet/custom_banner.dart';
import '../../../widgets/Explore/Trainers/free_workout.dart';



class WorkoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        titleText: 'Workout',
        
         showContainer: true,
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left:16,right:16, top:16),
                child: CustomBanner(
                  imagePath: 'assets/images/workout.jpeg',
                  text1: 'ProFIT Free Workout Plans',
                  text2:
                      'Unlock your journey to a healthier you with our free Workout plans crafted by expert trainers available exclusively on our platform.',
                  color1: Color(0xFF750000),
                  color2: Color(0xFF000000),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const CustomLabelWidget(
                title: 'Workout plans by our expert trainers',
              
              ),
                const SizedBox(height: 8),
             ...List.generate(
                2,
                (index) => Column(
                  children: [
                    FreeWorkout(key: ValueKey(index)),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
      ),
      
    );
  }
}
