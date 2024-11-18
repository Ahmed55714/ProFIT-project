import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import 'package:profit1/Views/widgets/Explore/Filters/custom_filter.dart';
import 'package:profit1/Views/widgets/General/customTextFeild.dart';
import 'package:profit1/Views/widgets/Explore/Trainers/trainer_continer.dart';
import 'package:profit1/utils/colors.dart';

import '../../../../widgets/General/customBotton.dart';
import '../../../../widgets/General/custom_loder.dart';
import '../../BottomNavigationBar/BottomNavigationBar.dart';
import '../controller/trainer_controller.dart';

class AllTrainers extends StatelessWidget {
  AllTrainers({Key? key}) : super(key: key);
  final ExploreController exploreController = Get.put(ExploreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey50,
      appBar: CustomAppBar(
        titleText: 'All Trainers',
        showContainer: true,
        onBack: () {
          Get.offAll(() => BottomNavigation(
                role: 'Explore',
                selectedIndex: 1,
              ));
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: CustomTextField(
                labelText: 'Search Trainer Here',
                isShowSearch: true,
                isShowColor: true,
              ),
            ),
            const SizedBox(height: 16),
            const CustomLabelWidget(title: 'Featured Trainers'),
            FilterBar(
              onFilterSelected: (String filter, [String? specialization]) {
                if (filter == 'All') {
                  exploreController.fetchTrainers();
                } else if (filter == 'Specialization' &&
                    specialization != null) {
                  exploreController.filterBySpecialization(specialization);
                }
              },
            ),
            const SizedBox(height: 8),
            Obx(() {
              print('Trainers List in Widget: ${exploreController.trainers.map((t) => t.fullName).toList()}');
              if (exploreController.trainers.isEmpty) {
                return Center(child: CustomLoder(color: colorBlue, size: 35));
              }
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: exploreController.trainers.length,
                itemBuilder: (context, index) {
                  return TrainerCard(
                      trainer: exploreController.trainers[index]);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
