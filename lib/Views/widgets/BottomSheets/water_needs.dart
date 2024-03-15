import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:profit1/utils/colors.dart';

import '../General/customBotton.dart';
import '../Home/custom_home.dart';
import 'add_challenge.dart';

class WaterNeedsBottomSheet extends StatefulWidget {
  const WaterNeedsBottomSheet({Key? key}) : super(key: key);

  @override
  State<WaterNeedsBottomSheet> createState() => _WaterNeedsBottomSheetState();
}

class _WaterNeedsBottomSheetState extends State<WaterNeedsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      expand: false,
      builder: (_, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: _buildSheetContent(),
      ),
    );
  }

  Widget _buildSheetContent() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomHeaderWithCancel(
            title: "Water Needs",
            onCancelPressed: () => Navigator.pop(context),
          ),
          const SizedBox(height: 16),
          WaterNeedsWidget(currentIntakeML: 500, goalIntakeML: 3500),
          const SizedBox(height: 16),
          _buildActionButtons(),
          const SizedBox(height: 3),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildResetButton(),
        _buildFillAllAddCupButtons(),
      ],
    );
  }

  Widget _buildResetButton() {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Text('Reset', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: colorBlue)),
          const SizedBox(width: 10),
          SvgPicture.asset('assets/svgs/refresh-small.svg'),
        ],
      ),
    );
  }

  Widget _buildFillAllAddCupButtons() {
    return Row(
      children: [
        CustomButton(text: 'Fill All', onPressed: () {}, isShowSmall: true, isShowDifferent: true),
        CustomButton(text: 'Add Cup', onPressed: () {}, isShowSmall: true),
      ],
    );
  }
}

class WaterNeedsWidget extends StatelessWidget {
  final double currentIntakeML;
  final double goalIntakeML;

  const WaterNeedsWidget({Key? key, required this.currentIntakeML, required this.goalIntakeML}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percentage = (currentIntakeML / goalIntakeML).clamp(0.0, 1.0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${currentIntakeML.toInt()} ML \n',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: wirdColor, fontFamily: 'BoldCairo'),
              ),
              TextSpan(
                text: '/ ${goalIntakeML.toInt()} ML',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: wirdColor),
              ),
            ],
          ),
        ),
        CircularIndicatorWithIconAndText(
          percentage: percentage,
          backgroundColor: Colors.grey[200]!,
          progressColor: wirdColor,
          iconName: 'assets/svgs/droplet.svg',
          percentageText: '${(percentage * 100).toInt()}%',
        ),
      ],
    );
  }
}
