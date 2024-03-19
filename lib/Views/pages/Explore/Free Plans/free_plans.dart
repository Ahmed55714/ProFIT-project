import 'package:flutter/material.dart';

import '../../../widgets/Explore/Trainers/free_diet.dart';
import '../../../widgets/General/customBotton.dart';

class FreePlans extends StatelessWidget {
  const FreePlans({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        ...List.generate(
          4,
          (index) => Column(
            children: [
              const CustomLabelWidget(title: 'Free Diet Plans'),
              FreeDiet(isShowCard: false, key: ValueKey(index)),
              const SizedBox(height: 16),
            ],
          ),
        ),
        const SizedBox(height: 224),
      ],
    );
  }
}
