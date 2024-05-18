import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:profit1/Views/widgets/General/custom_profile_textFeild.dart';
import 'package:profit1/utils/colors.dart';
import '../../../widgets/General/animatedTextField/animated_textfield.dart';
import '../../../widgets/General/customBotton.dart';
import '../../../widgets/Explore/Trainer Details/TabBar/tabBar.dart';
import '../../Tabs/BottomNavigationBar/BottomNavigationBar.dart';
import 'Meals/Breakfast.dart';

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
                const CustomLabelWidget(
                  title: 'Diet Plan Overview',
                ),
                const Spacer(),
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
                    child: const BreakFast(),
                  ),
                  // Contents for Lunch
                  Container(
                    child: const Center(
                      child: Text('Lunch Content'),
                    ),
                  ),
                  // Contents for Snack
                  Container(
                    child: const Center(
                      child: Text('Snack Content'),
                    ),
                  ),
                  // Contents for Dinner
                  Container(
                    child: const Center(
                      child: Text('Dinner Content'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child:    
                     AnimatedTextField(
                label: 'Diet Plan',
              ),
              
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
