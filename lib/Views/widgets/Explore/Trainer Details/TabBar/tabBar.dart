import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import '../../../../../utils/colors.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> tabTexts;
  final TabController? tabController;
  final bool isShowFavourite;
  final bool isDiet;

  CustomTabBar(
      {Key? key,
      required this.tabTexts,
      this.tabController,
      this.isShowFavourite = false,
      this.isDiet = false
      ,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [ 
              TabBar(
                labelPadding: EdgeInsets.symmetric(horizontal: 24),
                controller: tabController,
                isScrollable: isShowFavourite ? false : true,
                splashBorderRadius: BorderRadius.circular(8),
                indicatorPadding:
                    const EdgeInsets.only(left: 8, right: 8, bottom: 2),
                tabs: _buildTabs(),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 1.0,
                    color: isDiet ? green500 : blue700,
                    
                    style: BorderStyle.solid,
                  ),
                ),
                labelColor: isDiet ? green500 : blue700,
                unselectedLabelColor: grey400,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily:  'Cairo',
                  fontSize: 13,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                    fontFamily:  'Cairo',
                  fontSize: 13,
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
                color: grey200,
              ),
            ],
          ),
        ),
      
    );
  }
List<Widget> _buildTabs() {
  return tabTexts.map((text) {
    if (isDiet) {
      
      return Tab(
        child: Row(
          children: [
            Container(
              child: Image.asset(
                tabController?.index == tabTexts.indexOf(text) ? 'assets/images/checkbox.png' : 'assets/images/unCheckbox.png',
               
              ),
            ),
            SizedBox(width: 4.0),
            Text(text,),
          ],
        ),
      );
    } else {
      return Tab(text: text);
    }
  }).toList();
}


  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
