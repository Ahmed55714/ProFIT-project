import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:profit1/utils/colors.dart';
import '../../BottomSheets/add_challenge.dart';

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
  String selectedText = '';
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
        onSelected: (selected) {
          setState(() {
            selectedFilter = filter;
            widget.onFilterSelected(selectedFilter);
          });

          if (filter == 'Sort By') {
            _showSortByBottomSheet(context);
          }
        },
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

  void _showSortByBottomSheet(BuildContext context) {
    String selectedSvg = 'assets/svgs/PackageSelect.svg';
    String unselectedSvg = 'assets/svgs/UnPackageSelect.svg';

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 280,
          child: Column(
            children: [
              CustomHeaderWithCancel(
                title: 'Sort by',
                onCancelPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 16),
              _buildOptionRow('Text 1', selectedSvg, unselectedSvg),
              SizedBox(height: 8),
              _buildOptionRow('Text 2', selectedSvg, unselectedSvg),
              SizedBox(height: 8),
              _buildOptionRow('Text 3', selectedSvg, unselectedSvg),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionRow(String text, String selectedSvg, String unselectedSvg) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedText = text; // Set the selected text
        });
      },
      child: Row(
        children: [
          SvgPicture.asset(
            selectedText == text ? selectedSvg : unselectedSvg,
            color: selectedText == text ? Colors.blue : Colors.grey,
          ),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: selectedText == text ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
