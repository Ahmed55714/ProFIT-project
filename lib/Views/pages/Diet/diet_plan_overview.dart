import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:profit1/Views/widgets/General/custom_profile_textFeild.dart';
import 'package:profit1/utils/colors.dart';
import '../../widgets/General/customBotton.dart';
import '../../widgets/Explore/Trainer Details/TabBar/tabBar.dart';
import '../BottomNavigationBar/BottomNavigationBar.dart';
import '../Explore/About/about.dart';
import '../Explore/Free Plans/free_plans.dart';
import '../Explore/Gallery/gallery.dart';
import '../Explore/Reviews/reviews.dart';
import 'Diet Plan Overview/Breakfast.dart';

class DietPlanOverview extends StatefulWidget {
  const DietPlanOverview({Key? key}) : super(key: key);

  @override
  _DietPlanOverviewState createState() => _DietPlanOverviewState();
}

class _DietPlanOverviewState extends State<DietPlanOverview>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey50,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                CustomLabelWidget(
                  title: 'Diet Plan Overview',
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset('assets/svgs/cancelDiet.svg'),
                  ),
                ),
              ],
            ),
            CustomTabBar(
              tabController: _tabController,
              isDiet: true,
              tabTexts: ['Breakfast', 'Lunch', 'Snack', 'Dinner'],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    child: BreakFast(),
                  ),
                  // Contents for Lunch
                  Container(
                    child: Center(
                      child: Text('Lunch Content'),
                    ),
                  ),
                  // Contents for Snack
                  Container(
                    child: Center(
                      child: Text('Snack Content'),
                    ),
                  ),
                  // Contents for Dinner
                  Container(
                    child: Center(
                      child: Text('Dinner Content'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MyInputTextField(
                title: "Start Date",
                focusNode: FocusNode(),
                autoCorrect: false,
              ),
            ),
            SizedBox(height: 16),
            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  BottomNavigation(
                      selectedIndex: 2,
                      role: 'Diet',
                    ),
                  ),
                );
              },
              text: 'Start Diet Plan',
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
