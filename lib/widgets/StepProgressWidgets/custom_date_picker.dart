import 'package:flutter/material.dart';

import '../../utils/colors.dart';


class CustomDatePicker extends StatefulWidget {
  final Function(DateTime) onDateChanged;

  const CustomDatePicker({super.key, required this.onDateChanged});

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime selectedDate = DateTime.now();
  final int startYear = 2024;
  final int endYear = 1960;
  final int yearRange = 2024 - 1960 + 1;

  @override
  Widget build(BuildContext context) {
    // Define a list of month names
    final List<String> monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'

    ];
    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Day picker
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: _buildDatePickerWheel(
                      itemCount: 31,
                      initialItem: selectedDate.day - 1,
                      onSelectedItemChanged: (index) => _selectDay(index + 1),
                      // Inside the day picker builder
                      builder: (context, index) => _buildItem(
                          (index + 1).toString(), selectedDate.day.toString()),
                    ),
                  ),
                ),
              ),
              // Month picker
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: _buildDatePickerWheel(
                      itemCount: monthNames.length,
                      initialItem: selectedDate.month - 1,
                      onSelectedItemChanged: (index) => _selectMonth(index + 1),
                      builder: (context, index) => _buildItem(monthNames[index],
                          monthNames[selectedDate.month - 1]),
                    ),
                  ),
                ),
              ),
              // Year picker
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: _buildDatePickerWheel(
                      itemCount: yearRange,
                      initialItem: startYear - selectedDate.year,
                      onSelectedItemChanged: (index) =>
                          _selectYear(startYear - index),
                      builder: (context, index) {
                        int year = startYear - index;
                        return _buildItem(
                            year.toString(), selectedDate.year.toString());
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDatePickerWheel({
    required int itemCount,
    required int initialItem,
    required Function(int) onSelectedItemChanged,
    required Widget Function(BuildContext, int) builder,
  }) {
    return Stack(
      children: [
        ListWheelScrollView.useDelegate(
          itemExtent: 70,
          controller: FixedExtentScrollController(initialItem: initialItem),
          onSelectedItemChanged: onSelectedItemChanged,
          childDelegate: ListWheelChildBuilderDelegate(
            builder: builder,
            childCount: itemCount,
          ),
        ),
        Positioned(
          top: 75,
          left: 30,
          right: 30,
          child: Container(
            height: 3,
            width: 55,
            color: colorBlue,
            alignment: Alignment.center,
          ),
        ),
        Positioned(
          top: 125,
          left: 30,
          right: 30,
          child: Container(
            height: 3,
            width: 55,
            color: colorBlue,
            alignment: Alignment.center,
          ),
        ),
      ],
    );
  }

  Widget _buildItem(String value, String selectedValue) {
    final isSelected = value == selectedValue;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      child: Text(
        value,
        style: TextStyle(
          fontSize: 23,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? colorBlue : colorBlue400,
        ),
      ),
    );
  }

  void _selectDay(int day) {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month, day);
    });
    widget.onDateChanged(selectedDate);
  }

  void _selectMonth(int month) {
    setState(() {
      selectedDate = DateTime(selectedDate.year, month, selectedDate.day);
    });
    widget.onDateChanged(selectedDate);
  }

  void _selectYear(int year) {
    setState(() {
      selectedDate = DateTime(year, selectedDate.month, selectedDate.day);
    });
    widget.onDateChanged(selectedDate);
  }
}
