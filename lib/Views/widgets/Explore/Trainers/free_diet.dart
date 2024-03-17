import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/colors.dart';
import '../../General/customBotton.dart';
import 'trainer_continer.dart';

class FreeDiet extends StatefulWidget {
  const FreeDiet({Key? key}) : super(key: key);

  @override
  State<FreeDiet> createState() => _FreeDietState();
}

class _FreeDietState extends State<FreeDiet> {
  bool isLoved = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: grey200),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/appleDiet.svg',
                      ),
                      const CustomLabelWidget(
                        title: 'Cutting Plan',
                        isChangeColor: true,
                        isPadding: true,
                      ),
                      CustomBadge(text: 'Vegen'),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 32),
                    child: RatingWidget(),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Expanded(
                        child: CustomTextWithSvg(
                          text: '1966 Kcal',
                          svgPath: 'assets/svgs/Flamee.svg',
                        ),
                      ),
                      Expanded(
                        child: CustomTextWithSvg(
                          text: '134 gm',
                          svgPath: 'assets/svgs/k.svg',
                        ),
                      ),
                      Expanded(
                        child: CustomTextWithSvg(
                          text: '70 gm',
                          svgPath: 'assets/svgs/waterdrop.svg',
                        ),
                      ),
                      Expanded(
                        child: CustomTextWithSvg(
                          text: '20 gm',
                          svgPath: 'assets/svgs/bread.svg',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomTextWidget(
                    text:
                        'Remember the balance of proteins and carbohydrates, and create an adjusted plan based on your individual needs. Continue to have breakfast regularly to enhance your daily activity and maintain your health.',
                    color: colorDarkBlue,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: grey50,
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: ExperienceWidget(
                            isShowSvg: false,
                            text: 'Goal: ',
                            text2: 'Weight Loss',
                          ),
                        ),
                        Expanded(
                          child: ExperienceWidget(
                            isShowSvg: false,
                            text: 'Duration: ',
                            text2: '7 Days',
                          ),
                        ),
                        Expanded(
                          child: ExperienceWidget(
                            isShowSvg: false,
                            text: 'Meals: ',
                            text2: '4',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  const Divider(color: grey200, thickness: 1),
                  SizedBox(height: 8),
                  const CreatedByCard()
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: isLoved
                    ? SvgPicture.asset('assets/svgs/love1.svg')
                    : SvgPicture.asset('assets/svgs/love.svg'),
                onPressed: () {
                  setState(() {
                    isLoved = !isLoved;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextWithSvg extends StatelessWidget {
  final String text;
  final String svgPath;

  const CustomTextWithSvg({
    Key? key,
    required this.text,
    required this.svgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          svgPath,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 11,
            color: colorDarkBlue,
          ),
        ),
      ],
    );
  }
}









class CustomBadge extends StatelessWidget {
  final String text;

  const CustomBadge({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 25,
      decoration: BoxDecoration(
        border: Border.all(color: colorBlue),
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Text(
            text,
            style: TextStyle(
              color: colorBlue,
              fontWeight: FontWeight.w400,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }
}









class CreatedByCard extends StatelessWidget {
  const CreatedByCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/trainer.png'),
            radius: 25,
          ),
          const SizedBox(width: 8.0),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Created By',
                style: TextStyle(
                  color: grey500,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Ahmed Tarek',
                style: TextStyle(
                  color: colorDarkBlue,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8.0),
          SvgPicture.asset(
            'assets/svgs/chevron-small-left.svg',
          ),
        ],
      ),
    );
  }
}

class CustomTextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;

  const CustomTextWidget({
    Key? key,
    required this.text,
    required this.color,
    this.fontWeight = FontWeight.w400,
    this.fontSize = 11,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}