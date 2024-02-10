import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';


class CustomDatePicker extends StatefulWidget {
  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: _buildDatePickerWheel(
                      itemCount: 31,
                      initialItem: selectedDate.day - 1,
                      onSelectedItemChanged: (index) => _selectDay(index + 1),
                      builder: (context, index) => _buildItem(index + 1, selectedDate.day),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: _buildDatePickerWheel(
                      itemCount: 12,
                      initialItem: selectedDate.month - 1,
                      onSelectedItemChanged: (index) => _selectMonth(index + 1),
                      builder: (context, index) => _buildItem(index + 1, selectedDate.month),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: _buildDatePickerWheel(
                      itemCount: 100, // Adjust if you need more years
                      initialItem: selectedDate.year - 2020,
                      onSelectedItemChanged: (index) => _selectYear(2020 + index),
                      builder: (context, index) => _buildItem(2020 + index, selectedDate.year),
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

  Widget _buildItem(int value, int selectedValue) {
    final isSelected = value == selectedValue;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      child: Text(
        value.toString(),
        style: TextStyle(
          fontSize: 23,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? colorBlue : Colors.grey[600],
        ),
      ),
    );
  }

  void _selectDay(int day) {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month, day);
    });
  }

  void _selectMonth(int month) {
    setState(() {
      selectedDate = DateTime(selectedDate.year, month, selectedDate.day);
    });
  }

  void _selectYear(int year) {
    setState(() {
      selectedDate = DateTime(year, selectedDate.month, selectedDate.day);
    });
  }
}
