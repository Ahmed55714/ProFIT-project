import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:profit1/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../services/api_service.dart';
import '../../../widgets/General/animatedTextField/animated_textfield.dart';
import '../../../widgets/General/customBotton.dart';
import '../../../widgets/Explore/Trainer Details/TabBar/tabBar.dart';
import '../../Tabs/BottomNavigationBar/BottomNavigationBar.dart';
import 'Meals/Breakfast.dart';
import 'Meals/Dinner.dart';
import 'Meals/luanch.dart';
import 'Meals/snacks.dart';
import 'controller/diet_plan_over.dart';

class DietPlanOverview extends StatefulWidget {
  final String planId;

  const DietPlanOverview({Key? key, required this.planId}) : super(key: key);

  @override
  _DietPlanOverviewState createState() => _DietPlanOverviewState();
}

class _DietPlanOverviewState extends State<DietPlanOverview> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PlanOverviewController _controller = Get.put(PlanOverviewController());
  final ApiService _apiService = ApiService();
  String? _selectedDate;
  String? _token;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _controller.fetchNutritionPlanDetails(widget.planId);
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('auth_token');
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: colorBlue,
          
            colorScheme: ColorScheme.light(primary: colorBlue),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(primary: colorBlue),
            ),
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _postStartDate() async {
    if (_selectedDate != null && _token != null) {
      await _apiService.postStartDate(_token!, widget.planId, _selectedDate!);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigation(
            selectedIndex: 2,
            role: 'Diet',
          ),
        ),
      );
    } else {
      print('No date or token available');
    }
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
              isSitable: true,
              tabTexts: ['Breakfast', 'Lunch', 'Snack', 'Dinner'],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BreakFast(),
                  Lunch(),
                  Snack(),
                  Dinner(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AnimatedTextField(
                label: 'Start Date',
                controller: TextEditingController(
                  text: _selectedDate != null ? _selectedDate! : '',
                ),
                isShowCalendar: true,
                suffix: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Icon(
                      Icons.calendar_month_outlined,
                      color: colorBlue,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomButton(
              onPressed: _postStartDate,
              text: 'Start Diet Plan',
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

