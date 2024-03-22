import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/colors.dart';
import '../../../widgets/BottomSheets/add_challenge.dart';
import '../../../widgets/Explore/Trainer Details/Packages/package.dart';
import '../../../widgets/General/customBotton.dart';

class BreakFast extends StatefulWidget {
  final bool isShowActiveDiet;

  const BreakFast({super.key, this.isShowActiveDiet = false});
  @override
  State<BreakFast> createState() => _BreakFastState();
}

class _BreakFastState extends State<BreakFast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey50,
      body: SingleChildScrollView(
        child: Column(
          children: [
            widget.isShowActiveDiet
                ? MealInfoContainer(
                    mealIcon: 'assets/svgs/foody.svg',
                    mealName: 'Breakfast',
                    description:
                        'تذكر توازن البروتينات والكربوهيدرات، وضع خطة مُكيَّفة لاحتياجاتك الفردية. استمر في تناول وجبات الفطور بانتظام لتعزيز نشاطك اليومي والحفاظ على صحتك',
                    nutrients: [
                      {'value': '10 gm', 'icon': 'assets/svgs/ch.svg'},
                      {'value': '10 gm', 'icon': 'assets/svgs/waterdropo.svg'},
                      {'value': '20 gm', 'icon': 'assets/svgs/food.svg'},
                      {'value': '200 Kcal', 'icon': 'assets/svgs/Flamea.svg'},
                    ],
                  )
                : const CustomLabelWidget(
                    title: 'Meal Receipe',
                  ),
            ...List.generate(
              3,
              (index) => Column(
                children: [
                  CustomRecipeCard(key: ValueKey(index)),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRecipeCard extends StatelessWidget {
  const CustomRecipeCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          _showBottomSheet(context);
        },
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
                  _buildRecipeDetails(),
                  const Spacer(),
                  SvgPicture.asset('assets/svgs/refreach.svg'),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(
                color: grey200,
                thickness: 1,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CustomTextWithIcon(
                        text: '10 gm', svgPath: 'assets/svgs/ch.svg'),
                    SizedBox(width: 8),
                    CustomTextWithIcon(
                        text: '10 gm', svgPath: 'assets/svgs/waterdropo.svg'),
                    SizedBox(width: 8),
                    CustomTextWithIcon(
                        text: '20 gm', svgPath: 'assets/svgs/food.svg'),
                    Spacer(),
                    CustomTextWithIcon(
                        text: '200 Kcal', svgPath: 'assets/svgs/Flamea.svg'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageStack() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 80,
            height: 80,
            child: Image.asset(
              'assets/images/breakfast.jpeg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0.5),
                  Colors.black,
                ],
                stops: [0, 1, 1],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: '50 ',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                          ),
                        ),
                        TextSpan(
                          text: 'gm',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset('assets/images/checkbox.png'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecipeDetails() {
    return const Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'فرينش توست',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: colorDarkBlue,
              ),
            ),
            SizedBox(
              height: 20,
              width: 120,
              child: TextWithDot(
                noPadding: true,
                text: '4 slices of bread',
              ),
            ),
            SizedBox(
              height: 20,
              width: 120,
              child: TextWithDot(
                noPadding: true,
                text: '2 large eggs',
              ),
            ),
            SizedBox(
              height: 20,
              width: 120,
              child: TextWithDot(
                noPadding: true,
                text: '1/2 cup milk',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomTextWithIcon extends StatelessWidget {
  final String svgPath;
  final double spacing;
  final String text;
  final TextStyle? textStyle;

  const CustomTextWithIcon({
    Key? key,
    required this.svgPath,
    this.spacing = 4.0,
    required this.text,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          svgPath,
        ),
        SizedBox(width: spacing),
        Text(
          text,
          style: textStyle ??
              const TextStyle(
                color: colorDarkBlue,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
    builder: (BuildContext context) {
      return SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.72,
          ),
          child: Column(
            children: <Widget>[
              CustomHeaderWithCancel(
                title: 'فرينش توست',
                onCancelPressed: () => Navigator.pop(context),
              ),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 80,
                      height: 80,
                      child: Image.asset(
                        'assets/images/breakfast.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0),
                            Colors.black.withOpacity(0.5),
                            Colors.black,
                          ],
                          stops: [0, 1, 1],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                children: [
                                  TextSpan(
                                    text: '50 ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'gm',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(32.0),
                child: Row(
                  children: [
                    CustomTextWithIcon(
                        text: '10 gm', svgPath: 'assets/svgs/ch.svg'),
                    SizedBox(width: 8),
                    CustomTextWithIcon(
                        text: '10 gm', svgPath: 'assets/svgs/waterdropo.svg'),
                    SizedBox(width: 8),
                    CustomTextWithIcon(
                        text: '20 gm', svgPath: 'assets/svgs/food.svg'),
                    Spacer(),
                    CustomTextWithIcon(
                        text: '200 Kcal', svgPath: 'assets/svgs/Flamea.svg'),
                  ],
                ),
              ),
              const TextWithDot(
                text: '4 slices of bread (thick slices work well)',
              ),
              const TextWithDot(
                text: '2 large eggs',
              ),
              const TextWithDot(
                text: '1/2 cup milk',
              ),
              const TextWithDot(
                text: '1 teaspoon vanilla extract',
              ),
              const TextWithDot(
                text: '1/2 teaspoon ground cinnamon',
              ),
              const TextWithDot(
                text: 'Pinch of salt',
              ),
              const TextWithDot(
                text: 'Butter or cooking oil for greasing the pan',
              ),
              const TextWithDot(
                text:
                    'Optional toppings: maple syrup, fresh berries, powdered sugar, whipped cream',
              ),
              const SizedBox(height: 16),
              CustomButton(text: 'Mark Food as Finished ', onPressed: () {}),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    },
  );
}

class MealInfoContainer extends StatelessWidget {
  final String mealIcon;
  final String mealName;
  final String description;
  final List<Map<String, String>> nutrients;

  const MealInfoContainer({
    Key? key,
    required this.mealIcon,
    required this.mealName,
    required this.description,
    required this.nutrients,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: grey200,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(mealIcon),
                const SizedBox(width: 8),
                Text(
                  mealName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: DArkBlue900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: DArkBlue900,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < nutrients.length; i++)
                  Row(
                    children: [
                      CustomTextWithIcon(
                        text: nutrients[i]['value'] ?? '',
                        svgPath: nutrients[i]['icon'] ?? '',
                      ),
                      if (i == 2) SizedBox(width: 84),
                      if (i != nutrients.length - 1 && i != 2)
                        SizedBox(width: 8),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
