import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';

class CustomWorkoutCard extends StatelessWidget {
  final String exerciseName;
  final String exerciseImage;

  const CustomWorkoutCard({
    Key? key,
    required this.exerciseName,
    required this.exerciseImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageStack(),
                  const SizedBox(width: 16),
                  _buildExerciseDetails(),
                  const Spacer(),
                  SvgPicture.asset('assets/svgs/info-circle.svg'),
                ],
              ),
              const SizedBox(height: 24),
              const Row(
                children: [
                  IconTextButton(
                    svgPath: 'assets/svgs/plus-small.svg',
                    text: 'Record performance',
                  ),
                  Spacer(),
                  IconTextButton(
                    svgPath: 'assets/svgs/refresh-small.svg',
                    text: 'Alternative',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageStack() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        exerciseImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildExerciseDetails() {
    return Column(
      
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          exerciseName,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: blue700,
          ),
        ),
            const Text(
              '4 X 10',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: DArkBlue900,
              ),
            ),
            const Text(
              '9 RPE',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 11,
                color: blue700,
              ),
            ),
      ],
    );
  }
}

class IconTextButton extends StatelessWidget {
  final String svgPath;
  final String text;

  const IconTextButton({
    Key? key,
    required this.svgPath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(svgPath),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: Colors.blue.shade900,
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}