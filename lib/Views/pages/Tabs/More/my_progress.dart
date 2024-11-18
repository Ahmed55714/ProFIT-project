import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import 'package:profit1/utils/colors.dart';

import '../../../widgets/Explore/Trainer Details/TabBar/tabBar.dart';
import '../../Tabs/Explore/controller/trainer_controller.dart';
import 'My Progress/Measurements/measurements.dart';
import 'My Progress/Photo/photos.dart';

class MyProgress extends StatefulWidget {
  const MyProgress({Key? key}) : super(key: key);

  @override
  _MyProgressState createState() => _MyProgressState();
}

class _MyProgressState extends State<MyProgress>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    exploreController.fetchTrainers();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final ExploreController exploreController = Get.put(ExploreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      appBar: CustomAppBar(
        titleText: 'My Progress',
        isShowFavourite: true,
        isShowProfile: true,
      
      ),
      body:
        Column(
          children: [
            CustomTabBar(
              tabController: _tabController,
              isSitable :true,
              tabTexts: ['Measurements', 'Photo'],
              isShowFavourite: true,
            ),
            Expanded(
              child: Container(
                 color: grey50,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Align(
                      alignment: Alignment.topCenter, 
                      child: Measurements(),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Photos(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      
    );
  }
}
