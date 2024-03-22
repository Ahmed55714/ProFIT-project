import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';
import 'package:profit1/utils/colors.dart';
import '../../../pages/Profile/profile_screen.dart';
import '../../BottomSheets/add_challenge.dart';

class FilterBar extends StatefulWidget {
  final Function(String) onFilterSelected;
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
  List<String> get filtersList =>
      widget.filters ??
      defaultFilters; // Use custom list if provided, otherwise use default list

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
          children:
              filtersList.map((filter) => _buildFilterChip(filter)).toList(),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String filter) {
    final bool isSelected = selectedFilter == filter;
    final bool isCustomList = widget.filters != null;

    Color backgroundColor = isSelected ? blue700 : Colors.white;
    Color borderColor = isSelected ? colorBlue : grey200;
    Color textColor = isSelected ? Colors.white : grey500;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isCustomList || filter != 'All')
              if (leftIcons.containsKey(filter))
                SvgPicture.asset(
                  leftIcons[filter]!,
                  color: isSelected ? colorBlue : grey500,
                ),
            if (!isCustomList || filter != 'All') const SizedBox(width: 4.0),
            Text(
              filter,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isCustomList
                    ? textColor
                    : isSelected
                        ? colorBlue
                        : grey500,
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
        backgroundColor: isCustomList
            ? backgroundColor
            : isSelected
                ? blueFilter
                : Colors.white,
        selectedColor: isCustomList
            ? backgroundColor
            : isSelected
                ? blueFilter
                : Colors.white,
        shape: StadiumBorder(
          side: BorderSide(
            color: isCustomList
                ? borderColor
                : isSelected
                    ? colorBlue
                    : grey200,
          ),
        ),
      ),
    );
  }

  void _showSortByBottomSheet(BuildContext context) {
  showModalBottomSheet(
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
              title: 'Sort by',
              onCancelPressed: () {
                Navigator.pop(context);
              },
            ),
          
            SelectableContainerGroup(
              texts: ['Price: low to high', 'Price: high to low', 'New Arrival'],
              svgAssets: [
                'assets/svgs/Frame 52676.svg',
                'assets/svgs/Frame 52676.svg',
                'assets/svgs/Frame 52676.svg',
              ],
            ),
           
            CustomButton(text: 'Show Results', onPressed: (){}),
             SizedBox(height: 8.0),
             CustomButton(text: 'Reset', onPressed: (){}, isShowDifferent: true,),
           SizedBox(height: 8.0),
          ],
        ),
      );
    },
  );
}

}
