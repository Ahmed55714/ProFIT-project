import 'package:flutter/material.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import '../../../../utils/colors.dart';
import '../../../widgets/Explore/Trainer Details/TabBar/tabBar.dart';
import 'plans_favorites.dart';
import 'trainers_favourites.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Favorites',
        isShowFavourite: true,
      ),
      body: Column(
        children: [
          CustomTabBarFavorites(tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
              
               TrainerFavourites(),
          
               PlansFavourites(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTabBarFavorites extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;

  const CustomTabBarFavorites({Key? key, required this.tabController}) : super(key: key);

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
        child: TabBar(
          controller: tabController,
        
          tabs: const [
            Tab(text: 'Trainers'),
            
            Tab(text: 'Plans'),
          ],
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(
              width: 2.0,
              color: blue700,
              style: BorderStyle.solid,
            ),
          ),
          labelColor: blue700,
          unselectedLabelColor: Colors.grey,
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
