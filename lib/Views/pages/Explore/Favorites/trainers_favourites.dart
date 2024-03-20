import 'package:flutter/material.dart';

import '../../../widgets/Explore/Trainers/trainer_continer.dart';

class TrainerFavourites extends StatelessWidget {
  const TrainerFavourites({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
            ...List.generate(
                4,
                (index) => Column(
                  children: [
                    TrainerCard(key: ValueKey(index)),
                    SizedBox(height: 16),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}