import 'package:flutter/material.dart';
import 'package:profit1/Views/widgets/Explore/Trainer Details/about/custom_list.dart';

import '../../../../utils/colors.dart';
import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/Explore/Trainer Details/Reviews/graph.dart';
import '../../../widgets/Explore/Trainer Details/TabBar/tabBar.dart';
import '../../../widgets/Explore/Trainers/trainer_continer.dart';
import '../../../widgets/General/customBotton.dart';
import '../About/about.dart';
import '../Free Plans/free_plans.dart';
import '../Gallery/gallery.dart';
import '../Package/package.dart';
import '../Reviews/reviews.dart';

class TrainerDetails extends StatelessWidget {
  const TrainerDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: const CustomAppBar(
          titleText: 'Ahmed Tarek',
          showContainer: true,
          isShowProfile: true,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
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
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
                  CustomTabBar(),
                  Container(
                    height: 600,
                    child: TabBarView(
                      children: [
                        AboutSection(
                          awardsList: [
                            AwardData(
                              imagePath: 'assets/images/cer.png',
                            ),
                            AwardData(
                              imagePath: 'assets/images/cer2.png',
                            ),
                            AwardData(
                              imagePath: 'assets/images/cer.png',
                            ),
                            AwardData(
                              imagePath: 'assets/images/cer2.png',
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 16),
                             
                              ReviewSection(),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 16),
                              Gallery(),
                            ],
                          ),
                        ),
                         SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 16),
                               FreePlans(),
                            ],
                          ),
                        ),
                      
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: CustomButton(
                      text: 'Choose Your Package', onPressed: () {
  Navigator.of(context).push(_createRoute());
},),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => PackageScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 800), 
  );
}
