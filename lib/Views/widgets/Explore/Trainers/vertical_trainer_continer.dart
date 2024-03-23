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
              mainAxisSize: MainAxisSize.min, // Makes the column take minimum space
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/verticalTrainer.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8), // Adjusted the height
                Text(
                  'Moataz Ahmed',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 19,
                    color: colorDarkBlue,
                  ),
                  overflow: TextOverflow.ellipsis, // Prevents text overflow
                ),
                Text(
                  'Nutrition, CrossFit, Fitness',
                  style: TextStyle(
                    color: grey500,
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                  ),
                  overflow: TextOverflow.ellipsis, // Prevents text overflow
                ),
                _buildExperienceAndPriceRow(),
              ],
            ),
          ),
          Positioned(
            top: 125,
            right: 4,
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
           isShowSvg: true,
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
