
import 'package:flutter/material.dart';
import 'package:profit1/Views/widgets/Explore/Trainer Details/about/custom_list.dart';

import '../../../../utils/colors.dart';
import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/Explore/Trainer Details/Reviews/graph.dart';
import '../../../widgets/Explore/Trainers/trainer_continer.dart';
import '../../../widgets/General/customBotton.dart';
import '../About/about.dart';
import '../Gallery/gallery.dart';
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
            children:[ Column(
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
                  height:600,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            Expanded(
              child: Container(
                
                child: RatingBar(),
              ),
            ),
            
                   
            Container(
              width: MediaQuery.of(context).size.width * 0.8, 
              child: RatingGraph(),
            ),
                   
                  ],
                ),
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
                      const Center(child: Text('Free Plans Content')),
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
            child: CustomButton(text: 'Choose Your Package', onPressed: () {}),
          ),
        ),],
          ),
        ),
      ),
    );
  }
}


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
            indicatorPadding: const EdgeInsets.only(left: 8, right: 8, bottom: 2),
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
              fontWeight: FontWeight.w500,
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
