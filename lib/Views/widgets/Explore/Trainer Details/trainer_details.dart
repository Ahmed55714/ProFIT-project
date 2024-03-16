import 'package:flutter/material.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import 'package:profit1/Views/widgets/Explore/Trainers/trainer_continer.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';
import 'package:profit1/utils/colors.dart';

import 'About/about.dart';

class TrainerDetails extends StatelessWidget {
  const TrainerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: const CustomAppBar(
          titleText: 'Ahmed Tarek',
          showContainer: true,
          isShowProfile: true,
        ),
        body: Column(
          children: [
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/trainer.png',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLabelWidget(
                  title: 'Ahmed Tarek',
                  isPadding: true,
                ),
              ],
            ),
            const RatingWidget(),
            SizedBox(height: 16),
            CustomTabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  AboutSction(),
                  Center(child: Text('Reviews Content')),
                  Center(child: Text('Gallery Content')),
                  Center(child: Text('Free Plans Content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: double.infinity,
          child: TabBar(
            isScrollable: true,
            splashBorderRadius: BorderRadius.circular(8),
            indicatorPadding: EdgeInsets.only(left: 8, right: 8, bottom: 2),
            tabs: [
              Tab(text: 'About'),
              Tab(text: 'Reviews'),
              Tab(text: 'Gallery'),
              Tab(text: 'Free Plans'),
            ],
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 2.0,
                color: colorBlue,
                style: BorderStyle.solid,
              ),
            ),
            labelColor: colorBlue,
            unselectedLabelColor: grey400,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
