import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:profit1/utils/colors.dart';
import '../../../widgets/Explore/Trainer Details/Transformations/transformation.dart';
import 'controller/transformation_controller.dart';

class Gallery extends StatelessWidget {
  final TransformController controller = Get.put(TransformController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: grey50,
      child: Obx(() {
        if (controller.transformations.isEmpty) {
          return _buildShimmerLoading();
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

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          SizedBox(height: 16),
          ...List.generate(3, (index) => _buildShimmerTransformationCard()).toList(),
          SizedBox(height: 224),
        ],
      ),
    );
  }

  Widget _buildShimmerTransformationCard() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 20,
                color: Colors.white,
              ),
              SizedBox(height: 8),
              Container(
                width: 200,
                height: 20,
                color: Colors.white,
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.white,
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.white,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
