import 'package:flutter/material.dart';
import 'package:profit1/utils/colors.dart';

import '../../../widgets/Explore/Trainer Details/Gallery/gallery.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: grey50,
      child: Column(
        children: [
          
              SizedBox(height: 16),
        ...List.generate(
          4,
          (index) => Column(
            children: [
              TransformationCard(key: ValueKey(index)),
              SizedBox(height: 16),
            ],
          ),
        ),
        SizedBox(height: 224),
        ],
      ),
    );
  }
}