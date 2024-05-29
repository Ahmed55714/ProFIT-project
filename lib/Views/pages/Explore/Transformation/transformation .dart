import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profit1/utils/colors.dart';
import '../../../widgets/Explore/Trainer Details/Transformations/transformation.dart';
import '../../../widgets/General/custom_loder.dart';
import 'controller/transformation_controller.dart';

class Gallery extends StatelessWidget {
  final TransformController controller = Get.put(TransformController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: grey50,
      child: Obx(() {
        if (controller.transformations.isEmpty) {
          return SizedBox(
            height: 400,
            child: CustomLoder(
              color: colorBlue,
              size: 35,
            ),
          );
        }

        // Normal content layout
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16),
              ...controller.transformations.map((transformation) {
                return Column(
                  children: [
                    TransformationCard(
                      Name: transformation.title,
                      Description: transformation.description,
                      ImagePath: transformation.beforeImage,
                      ImagePath2: transformation.afterImage,
                    ),
                    SizedBox(height: 16),
                  ],
                );
              }).toList(),
              SizedBox(height: 224),
            ],
          ),
        );
      }),
    );
  }
}
