import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profit1/utils/colors.dart';
import '../../../pages/Profile/profile Screen/profile_screen.dart';
import '../../../pages/Tabs/Explore/controller/trainer_controller.dart';
import '../../BottomSheets/add_challenge.dart';
import '../../General/customBotton.dart';

class FilterBar extends StatefulWidget {
  final Function(String, [String?]) onFilterSelected;
  final List<String>? filters;

  const FilterBar({
    required this.onFilterSelected,
    this.filters,
    Key? key,
  }) : super(key: key);

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  Function? pendingAction;
  List<String> get filtersList => widget.filters ?? defaultFilters;
  final List<String> defaultFilters = [
    'All',
    'Sort By',
    'Specialization',
    'Rating 4.0+',
    'Nearby',
  ];

  final Map<String, String> leftIcons = {
    'All': 'assets/svgs/sap-icon-accept.svg',
    'Sort By': 'assets/svgs/Arrow-up-down.svg',
    'Specialization': 'assets/svgs/grid-8.svg',
  };

  final Map<String, String> rightIcons = {
    'Sort By': 'assets/svgs/chevron-down.svg',
    'Specialization': 'assets/svgs/chevron-down.svg',
  };

  String selectedFilter = 'All';
  int? lastSelectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0),
      color: grey50,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...filtersList.map((filter) => _buildFilterChip(filter)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String filter) {
    final bool isSelected = selectedFilter == filter;
    return Container(
      color: grey50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leftIcons.containsKey(filter))
                SvgPicture.asset(
                  leftIcons[filter]!,
                  color: isSelected ? colorBlue : grey500,
                ),
              const SizedBox(width: 4.0),
              Text(
                filter,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  color: isSelected ? colorBlue : grey500,
                  fontSize: 13.0,
                ),
              ),
              if (rightIcons.containsKey(filter)) const SizedBox(width: 8.0),
              if (rightIcons.containsKey(filter))
                SvgPicture.asset(
                  rightIcons[filter]!,
                  color: isSelected ? colorBlue : grey500,
                ),
            ],
          ),
          selected: isSelected,
          onSelected: (bool selected) {
            setState(() {
              selectedFilter = filter;
            });
            handleFilterSelection(filter);
          },
          backgroundColor: isSelected ? blueFilter : Colors.white,
          selectedColor: isSelected ? blueFilter : Colors.white,
          shape: StadiumBorder(
            side: BorderSide(
              color: isSelected ? colorBlue : grey200,
            ),
          ),
        ),
      ),
    );
  }

  void handleFilterSelection(String filter) {
    if (filter == 'Sort By') {
      showCustomizableBottomSheet(
        context: context,
        title: 'Sort by',
        options: ['Price: low to high', 'Price: high to low', 'New Arrival'],
        svgAssets: [
          'assets/svgs/Frame 52676.svg',
          'assets/svgs/Frame 52676.svg',
          'assets/svgs/Frame 52676.svg'
        ],
        actions: [
          () => Get.find<ExploreController>().sortTrainersLowToHigh(),
          () => Get.find<ExploreController>().sortTrainersHighToLow(),
          () => Get.find<ExploreController>().sortTrainersHighToLow(),
        ],
      );
    } else if (filter == 'All') {
      widget.onFilterSelected('All');
    } else if (filter == 'Specialization') {
      showCustomizableBottomSheet(
        context: context,
        title: 'Filter by Specialization',
        options: ['Muscle Gain', 'Body Building', 'Crossfit'],
        svgAssets: [
          'assets/svgs/Frame 52676.svg',
          'assets/svgs/Frame 52676.svg',
          'assets/svgs/Frame 52676.svg'
        ],
        actions: [
          () => Get.find<ExploreController>()
              .filterBySpecialization('Muscle Gain'),
          () => Get.find<ExploreController>()
              .filterBySpecialization('Body Building'),
          () =>
              Get.find<ExploreController>().filterBySpecialization('Crossfit'),
        ],
      );
    }
  }

  void showCustomizableBottomSheet({
    required BuildContext context,
    required String title,
    required List<String> options,
    required List<String> svgAssets,
    required List<Function> actions,
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomHeaderWithCancel(
                title: title,
                onCancelPressed: () => Navigator.pop(context),
              ),
              SelectableContainerGroup(
                texts: options,
                svgAssets: svgAssets,
                initialIndex: lastSelectedIndex ?? 0,
                onSelection: (index) {
                  lastSelectedIndex = index;
                  pendingAction = actions[index];
                },
              ),
              const SizedBox(height: 18.0),
              CustomButton(
                text: 'Show Results',
                onPressed: () {
                  pendingAction!();
                  Navigator.pop(context);
                },
               
              ),
              const SizedBox(height: 8.0),
              CustomButton(
                text: 'Reset',
                onPressed: () {
                  actions[0]();
                  Navigator.pop(context);
                },
                isShowDifferent: true,
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        );
      },
    );
  }
}
