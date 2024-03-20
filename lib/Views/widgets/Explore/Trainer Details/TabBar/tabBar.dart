import 'package:flutter/material.dart';

import '../../../../../utils/colors.dart';

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
            indicatorPadding:
                const EdgeInsets.only(left: 8, right: 8, bottom: 2),
            tabs: [
              const Tab(text: 'About'),
              const Tab(text: 'Reviews'),
              const Tab(text: 'Gallery'),
              const Tab(text: 'Free Plans'),
            ],
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 2.0,
                color: blue700,
                style: BorderStyle.solid,
              ),
            ),
            labelColor: blue700,
            unselectedLabelColor: grey400,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
            unselectedLabelStyle: const TextStyle(
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

// class CustomTabBarFavorites extends StatefulWidget
//     implements PreferredSizeWidget {
//   const CustomTabBarFavorites({Key? key}) : super(key: key);

//   @override
//   _CustomTabBarFavoritesState createState() => _CustomTabBarFavoritesState();

//   @override
//   Size get preferredSize =>
//       const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
// }

// class _CustomTabBarFavoritesState extends State<CustomTabBarFavorites>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: Theme.of(context).copyWith(
//         splashColor: Colors.transparent,
//         highlightColor: Colors.transparent,
//         hoverColor: Colors.transparent,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Row(
//           children: [
//             TabBar(
//                 controller: _tabController,
//                 isScrollable: true,
//                 tabs: [
//                   const Tab(text: 'Trainers'),
//                   const Tab(text: 'Plans'),
//                 ],
//                 indicator: const UnderlineTabIndicator(
//                   borderSide: BorderSide(
//                     width: 2.0,
//                     color: blue700,
//                     style: BorderStyle.solid,
//                   ),
//                 ),
//                 labelColor: blue700,
//                 unselectedLabelColor: Colors.grey,
//                 labelStyle: const TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 16,
//                 ),
//                 unselectedLabelStyle: const TextStyle(
//                   fontWeight: FontWeight.w400,
//                   fontSize: 16,
//                 ),
//               ),
            
//           ],
//         ),
//       ),
//     );
//   }
// }
