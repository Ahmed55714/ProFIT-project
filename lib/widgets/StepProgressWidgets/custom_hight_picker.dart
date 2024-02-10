import 'package:flutter/material.dart';
import '../../utils/colors.dart';


class CustomHeightPicker extends StatefulWidget {
  @override
  _CustomHeightPickerState createState() => _CustomHeightPickerState();
}

class _CustomHeightPickerState extends State<CustomHeightPicker> {
  int selectedHeight = 220;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Stack(
                    children: [
                      ListWheelScrollView.useDelegate(
                        itemExtent: 70,
                        controller: FixedExtentScrollController(
                          initialItem: selectedHeight - 100,
                        ),
                        onSelectedItemChanged: (index) => _selectHeight(index + 100),
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) => _buildItem(index + 100, selectedHeight),
                          childCount: 101,
                        ),
                      ),
                      Positioned(
                        top: 120,
                        left: 220,
                        right: 30,
                        child: Text(
                          'cm',
                          style: TextStyle(color: colorBlue),
                        ),
                      ),
                      Positioned(
                        top: 65,
                        left: 30,
                        right: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 100, right: 100),
                          child: Container(
                            height: 3,
                            width: 55,
                            color: colorBlue,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 140,
                        left: 30,
                        right: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 100, right: 100),
                          child: Container(
                            height: 3,
                            width: 55,
                            color: colorBlue,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItem(int value, int selectedValue) {
    final isSelected = value == selectedValue;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Text(
        value.toString(),
        style: TextStyle(
          fontSize: 43,
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.w300,
          color: isSelected ? colorBlue : Colors.grey[400],
        ),
      ),
    );
  }

  void _selectHeight(int height) {
    setState(() {
      selectedHeight = height;
    });
  }
}
