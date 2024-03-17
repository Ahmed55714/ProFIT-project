import 'package:flutter/material.dart';

import '../../../widgets/Explore/Trainer Details/Gallery/gallery.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransformationCard(),
      ],
    );
  }
}