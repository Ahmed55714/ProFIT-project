import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/colors.dart';
import '../../../pages/Diet/Diet Plan Overview/diet_plan_overview.dart';
import '../../../pages/Explore/Free Plans/model/free_plan.dart';
import '../../../pages/Explore/Trainer Details/trainer_details.dart';
import '../../../pages/Tabs/Explore/controller/nutration_controller.dart';
import '../../../pages/Tabs/Explore/model/nutration.dart';
import '../../../pages/Tabs/Explore/model/trainer.dart';
import '../../Animation/AnimationPage.dart';
import '../../General/customBotton.dart';
import 'trainer_continer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../pages/Diet/Diet Plan Overview/diet_plan_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../utils/colors.dart';
import '../../../pages/Diet/Diet Plan Overview/diet_plan_overview.dart';
import '../../../pages/Explore/Free Plans/model/free_plan.dart';

class FreeDiet extends StatefulWidget {
  final bool isShowCard;
  final DietPlan? plan;

  const FreeDiet({Key? key, required this.isShowCard, this.plan})
      : super(key: key);

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
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context)
                      //     .push(createRoute(DietPlanOverview()));
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/appleDiet.svg',
                            ),
                            CustomLabelWidget(
                              title: widget.plan?.planName ?? 'Badawy',
                              isChangeColor: true,
                              isPadding: true,
                            ),
                            CustomBadge(text: widget.plan?.dietType ?? 'Vegan'),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 32),
                          child: RatingWidget(
                            rate: widget.plan?.rating ?? 0,
                            rate2: widget.plan?.rating ?? 0,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextWithSvg(
                                text:
                                    '${widget.plan?.calories.toStringAsFixed(0) ?? 0} Kcal',
                                svgPath: 'assets/svgs/Flamee.svg',
                              ),
                            ),
                            Expanded(
                              child: CustomTextWithSvg(
                                text:
                                    '${widget.plan?.proteins.toStringAsFixed(0) ?? 0} gm',
                                svgPath: 'assets/svgs/k.svg',
                              ),
                            ),
                            Expanded(
                              child: CustomTextWithSvg(
                                text:
                                    '${widget.plan?.carbs.toStringAsFixed(0) ?? 0} gm',
                                svgPath: 'assets/svgs/waterdrop.svg',
                              ),
                            ),
                            Expanded(
                              child: CustomTextWithSvg(
                                text:
                                    '${widget.plan?.fats.toStringAsFixed(0) ?? 0} gm',
                                svgPath: 'assets/svgs/bread.svg',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomTextWidget(
                          text: widget.plan?.description ?? 'No Description',
                          color: colorDarkBlue,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: grey50,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: ExperienceWidget(
                                  isShowSvg: false,
                                  text: 'Goal: ',
                                  text2: widget.plan?.goal ?? 'No Goal',
                                ),
                              ),
                              Expanded(
                                child: ExperienceWidget(
                                  isShowSvg: false,
                                  text: 'Duration: ',
                                  text2: widget.plan?.duration ?? 'No Duration',
                                ),
                              ),
                              Expanded(
                                child: ExperienceWidget(
                                  isShowSvg: false,
                                  text: 'Meals: ',
                                  text2: widget.plan?.meals.toString() ?? '0',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.isShowCard) SizedBox(height: 8),
                  if (widget.isShowCard)
                    const Divider(color: grey200, thickness: 1),
                  SizedBox(height: 8),
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

class ExploreDiet extends StatefulWidget {
  final bool isShowCard;
  final NutritionPlan? plan;

  const ExploreDiet({Key? key, required this.isShowCard, this.plan}) : super(key: key);

  @override
  State<ExploreDiet> createState() => _ExploreDietState();
}

class _ExploreDietState extends State<ExploreDiet> {
  late NutritionPlanController nutritionPlanController;
  late bool isLoved;

  @override
  void initState() {
    super.initState();
    nutritionPlanController = Get.find<NutritionPlanController>();
    isLoved = widget.plan?.isFavorite ?? false;
  }

  void toggleFavorite() {
    setState(() {
      isLoved = !isLoved;
    });
    nutritionPlanController.toggleFavoriteDiet(widget.plan!.id);
  }

  @override
  Widget build(BuildContext context) {
    final plan = widget.plan;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(createRoute(DietPlanOverview(
                        planId: plan!.id,
                      )));
                    },
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/svgs/appleDiet.svg'),
                            CustomLabelWidget(
                              title: plan?.planName ?? 'Diet Plan',
                              isChangeColor: true,
                              isPadding: true,
                            ),
                            CustomBadge(text: plan?.dietType ?? 'Diet Type'),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 32),
                          child: RatingWidget(
                            rate: plan?.rating ?? 0,
                            rate2: plan?.rating ?? 0,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextWithSvg(
                                text: '${plan?.calories.toStringAsFixed(0) ?? 0} Kcal',
                                svgPath: 'assets/svgs/Flamee.svg',
                              ),
                            ),
                            Expanded(
                              child: CustomTextWithSvg(
                                text: '${plan?.proteins.toStringAsFixed(0) ?? 0} gm',
                                svgPath: 'assets/svgs/k.svg',
                              ),
                            ),
                            Expanded(
                              child: CustomTextWithSvg(
                                text: '${plan?.carbs.toStringAsFixed(0) ?? 0} gm',
                                svgPath: 'assets/svgs/waterdrop.svg',
                              ),
                            ),
                            Expanded(
                              child: CustomTextWithSvg(
                                text: '${plan?.fats.toStringAsFixed(0) ?? 0} gm',
                                svgPath: 'assets/svgs/bread.svg',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomTextWidget(
                          text: plan?.description ?? 'No Description',
                          color: colorDarkBlue,
                        ),
                        // const SizedBox(height: 16),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(8),
                        //     color: grey50,
                        //   ),
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //         child: ExperienceWidget(
                        //           isShowSvg: false,
                        //           text: 'Goal: ',
                        //           text2: plan?.goal ?? 'No Goal',
                        //         ),
                        //       ),
                        //       Expanded(
                        //         child: ExperienceWidget(
                        //           isShowSvg: false,
                        //           text: 'Duration: ',
                        //           text2: plan?.duration ?? 'No Duration',
                        //         ),
                        //       ),
                        //       Expanded(
                        //         child: ExperienceWidget(
                        //           isShowSvg: false,
                        //           text: 'Meals: ',
                        //           text2: plan?.mealsCount.toString() ?? '0',
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  if (widget.isShowCard) SizedBox(height: 8),
                  if (widget.isShowCard) const Divider(color: grey200, thickness: 1),
                  SizedBox(height: 8),
                  CreatedByCard(
                    fullName: plan?.name,
                    Image: plan?.profilePhoto,
                  ),
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
                onPressed: toggleFavorite,
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
      height: 25,
      decoration: BoxDecoration(
        border: Border.all(color: colorBlue),
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 4),
          child: Text(
            text,
            style: TextStyle(
              color: colorBlue,
              fontWeight: FontWeight.w400,
              fontSize: 69,
            ),
          ),
        ),
      ),
    );
  }
}

class CreatedByCard extends StatelessWidget {
  final String? fullName;
  final String? Image;

  const CreatedByCard({Key? key, this.Image, this.fullName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage('${Image!}'),
              radius: 25,
            ),
            const SizedBox(width: 8.0),
            Column(
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
                  fullName ?? "",
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
