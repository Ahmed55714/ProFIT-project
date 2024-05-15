import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../pages/Tabs/Explore/controller/trainer_controller.dart';
import '../../../pages/Tabs/Explore/model/trainer.dart';
import 'trainer_continer.dart';

class VerticalTrainerCard extends StatefulWidget {
  final Trainer trainer;
  final VoidCallback? onFavoriteChanged;

  const VerticalTrainerCard({Key? key, required this.trainer, this.onFavoriteChanged}) : super(key: key);

  @override
  State<VerticalTrainerCard> createState() => _VerticalTrainerCardState();
}

class _VerticalTrainerCardState extends State<VerticalTrainerCard> {
  late bool isLoved;
  late ExploreController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ExploreController>();
    isLoved = widget.trainer.isFavorite ?? false;
  }


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
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.trainer.profilePhoto!,
                    fit: BoxFit.cover,
                    height: 120, 
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                    widget.trainer.fullName.split(' ')[0],  
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                      color: colorDarkBlue,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                
                Text(
                  widget.trainer.specializations!.join(', '),
                  style: TextStyle(
                    color: grey500,
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                _buildExperienceAndPriceRow(),
              ],
            ),
          ),
          Positioned(
            top: 135,
            right: 4,
            child: IconButton(
              icon: isLoved
                  ? SvgPicture.asset('assets/svgs/love1.svg')
                  : SvgPicture.asset('assets/svgs/love.svg'),
              onPressed: () {
                try {
                  controller.toggleFavorite(widget.trainer!.id);
                  setState(() {
                    isLoved = !isLoved;
                  });
                  if (widget.onFavoriteChanged != null) {
                    widget.onFavoriteChanged!();
                  }
                } catch (e) {
                  print('Error toggling favorite: $e');
                }
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
