import 'package:flutter/material.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';

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
        isShowProfile: true,
      ),
      body: Column(
        children: [
            CustomTabBar( 
            tabController: _tabController,
            tabTexts: ['Trainers', 'Plans'],
            isShowFavourite: true,
          ),
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

