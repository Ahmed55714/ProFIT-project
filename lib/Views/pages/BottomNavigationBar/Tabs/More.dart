import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';

import '../../../../utils/colors.dart';
import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/More/Achievements.dart';
import '../../More/achievements.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: 'ProFIT HUB',
        showContainer: true,
        isShowNormal: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AchievementsWidget(
                  text: 'My Progress',
                  svgAsset: 'assets/svgs/Activity.svg',
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Achievements(),
                    ),
                  );
                  },
                  child: AchievementsWidget(
                    text: 'My Achievements',
                    svgAsset: 'assets/svgs/Medal gold.svg',
                  ),
                ),
              ),
            ],
          ),
          CustomLabelWidget(
            title: 'Benefits',
          ),
          SizedBox(
            height: 16,
          ),
          Image.asset(
            'assets/images/pon.png',
          ),
          SizedBox(
            height: 16,
          ),
          Image.asset(
            'assets/images/pon.png',
          ),
        ],
      ),
    );
  }
}


