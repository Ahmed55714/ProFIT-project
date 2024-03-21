import 'package:flutter/material.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import '../../../../../utils/colors.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> tabTexts;
  final TabController? tabController;
  final bool isShowFavourite;

   CustomTabBar({Key? key, required this.tabTexts, this.tabController,  this.isShowFavourite = false}) : super(key: key);

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
            controller: tabController, 
            isScrollable: isShowFavourite? false: true,
            splashBorderRadius: BorderRadius.circular(8),
            indicatorPadding: const EdgeInsets.only(left: 8, right: 8, bottom: 2),
            tabs: _buildTabs(),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 1.0,
                color: blue700,
                style: BorderStyle.solid,
              ),
            ),
            labelColor: blue700,
            unselectedLabelColor: grey400,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabs() {
    return tabTexts.map((text) => Tab(text: text)).toList();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}