import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../utils/colors.dart';
import '../../../../widgets/BottomSheets/add_challenge.dart';
import '../../../../widgets/Diet/custom_text_icon_kal.dart';
import '../../../../widgets/Explore/Trainer Details/Packages/package.dart';
import '../../../../widgets/General/customBotton.dart';
import '../../shoppin_list.dart';

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
                ? const MealInfoContainer(
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
                  CustomRecipeCard(key: ValueKey(index), showFoodAlternateConfirmation: () {  },),
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




 