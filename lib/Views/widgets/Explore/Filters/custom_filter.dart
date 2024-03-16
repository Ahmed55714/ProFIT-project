import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/colors.dart';

class FilterBar extends StatefulWidget {
  final Function(String) onFilterSelected;

  const FilterBar({
    required this.onFilterSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  final List<String> filters = [
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0),
      color: Colors.white,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((filter) => _buildFilterChip(filter)).toList(),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String filter) {
    final bool isSelected = selectedFilter == filter;

    return Padding(
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
            if (leftIcons.containsKey(filter)) const SizedBox(width: 4.0),
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
        onSelected: (selected) => setState(() {
          selectedFilter = filter;
          widget.onFilterSelected(selectedFilter);
        }),
        backgroundColor: isSelected ? blueFilter : Colors.white,
        selectedColor: blueFilter,
        shape: StadiumBorder(
          side: BorderSide(
            color: isSelected ? colorBlue : grey200,
          ),
        ),
      ),
    );
  }
}
