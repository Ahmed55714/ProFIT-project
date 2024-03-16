import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/colors.dart';
import 'trainer_continer.dart';

class VerticalTrainerCard extends StatefulWidget {
  const VerticalTrainerCard({Key? key}) : super(key: key);

  @override
  State<VerticalTrainerCard> createState() => _VerticalTrainerCardState();
}

class _VerticalTrainerCardState extends State<VerticalTrainerCard> {
  bool isLoved = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 164,
      height: 303,
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/verticalTrainer.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const RatingWidget(),
                      const Text(
                        'Moataz Ahmed',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 19,
                          color: colorDarkBlue,
                        ),
                      ),
                      const Text(
                        'Nutrition, CrossFit, Fitness',
                        style: TextStyle(
                          color: grey500,
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                        ),
                      ),
                      _buildExperienceAndPriceRow(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 128,
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
    );
  }

  Widget _buildExperienceAndPriceRow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 4),
        ExperienceWidget(
           isShowSvg:true,
        ),
        SizedBox(height: 4),
        const Divider(color: grey200, thickness: 1),
        Row(
          children: [
            PriceWidget(),
            const Spacer(),
            SvgPicture.asset('assets/svgs/chevron-right.svg'),
          ],
        ),
      ],
    );
  }
}
