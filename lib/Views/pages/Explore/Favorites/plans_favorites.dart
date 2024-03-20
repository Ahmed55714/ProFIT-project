import 'package:flutter/material.dart';

import '../../../widgets/Explore/Trainers/free_diet.dart';

class PlansFavourites extends StatelessWidget {
  const PlansFavourites({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
            ...List.generate(
              2,
              (index) => Column(
                children: [
                  FreeDiet(isShowCard: true ,key: ValueKey(index)),
                  SizedBox(height: 16),
                ],
              ),
            ),
        ],
      ),
    );
  }
}