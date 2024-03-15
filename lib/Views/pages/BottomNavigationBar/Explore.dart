import 'package:flutter/material.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';


import '../../widgets/Filters/custom_filter.dart';
import '../../widgets/General/customBotton.dart';
import '../../widgets/General/customTextFeild.dart';
import '../../widgets/Trainers/trainer_continer.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: 'Explore',
        isShowExplore: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: CustomTextField(
              labelText: 'Search Trainer Here',
              isShowSearch: true,
            ),
          ),
          const SizedBox(height: 16),
          const CustomLabelWidget(
            title: 'Feratured Trainers',
          ),
          FilterBar(
            onFilterSelected: (String selectedFilter) {},
          ),
          SizedBox(height: 16),
          TrainerCard(),
        ],
      ),
    );
  }
}
