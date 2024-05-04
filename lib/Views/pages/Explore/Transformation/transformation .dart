import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../widgets/Explore/Trainer Details/Transformations/transformation.dart';
import 'controller/transformation_controller.dart';

class Gallery extends StatelessWidget {
  final String title;
  final String description;
  final String beforeImage;
  final String afterImage;

  Gallery({super.key, required this.title, required this.description, required this.beforeImage, required this.afterImage});

  final TransformController controller = Get.put(TransformController());

  @override
  Widget build(BuildContext context) {
 

    return Container(
      color: grey50,
      child: Obx(() {
        if (controller.transformationDetails.value == null) {
          return Center(child: CircularProgressIndicator());
        }

       
        return Column(
          children: [
            SizedBox(height: 16),
            TransformationCard(
        
              Name: title,
              Description: description,
              ImagePath: beforeImage,
              ImagePath2: afterImage,
            ),
            SizedBox(height: 16),
            SizedBox(height: 224),
          ],
        );
      }),
    );
  }
}
