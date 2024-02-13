import 'package:flutter/material.dart';
import 'package:profit1/utils/colors.dart';

import 'custom_hight_picker.dart';

class CustomWeightPicker extends StatefulWidget {
  final double initialValue;
  final ValueChanged<double> onValueChanged;

  CustomWeightPicker({
    Key? key,
    required this.initialValue,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  _CustomWeightPickerState createState() => _CustomWeightPickerState();
}

class _CustomWeightPickerState extends State<CustomWeightPicker> {
  late double _currentValue;
  late ScrollController _scrollController;
  bool isKgSelected = true; // Flag to toggle between cm and ft

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue; // Assuming initialValue is in Kg
    _scrollController = ScrollController(
      initialScrollOffset: (_currentValue - 50) * 60.0,
    );
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      double scrollPosition = _scrollController.position.pixels;
      double newValue = scrollPosition / 60.0 + 50;
      if (!isKgSelected) {
        // If LB is selected, convert the newValue back to Kg before updating and calling back
        newValue = newValue / 2.20462; // Convert LB back to Kg
      }
      setState(() {
        _currentValue = newValue;
      });
      widget.onValueChanged(_currentValue);
    }
  }

  void _toggleUnit(bool isKg) {
    setState(() {
      isKgSelected = isKg;
      if (isKgSelected) {
        // Convert LB to Kg
        _currentValue = _currentValue / 2.20462;
      } else {
        // Convert Kg to LB
        _currentValue = _currentValue * 2.20462;
      }
      // Update the scroll offset based on the new unit
      _scrollController.jumpTo((_currentValue - 50) * 60.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    String unit = isKgSelected ? 'Kg' : 'LB';
    double displayValue = _currentValue;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: grey300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To wrap the content in the column
            children: <Widget>[
              Text(
                'Your BMI Mass Index (BMI) is:',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w400,
                  color: colorBlue,
                ),
              ),
              Divider(color: grey300),
              SizedBox(height: 8),
              Text(
                '23.4',
                style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'BoldCairo',
                    fontWeight: FontWeight.bold,
                    color: colorBlue),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: () {
                  // Your BMI Calculation or Navigation goes here
                },
                child: Container(
                  width: 51, // Specify the width of the Container
                  height: 25, // Specify the height of the Container
                  decoration: BoxDecoration(
                    color: Colors.green, // Background color
                    borderRadius: BorderRadius.circular(5.0), // Rounded corners
                    border: Border.all(
                      color: Colors.green, // Border color
                    ),
                  ),
                  child: Expanded(
                    child: Center(
                      child: Text(
                        'Normal',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white, // Text color
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
        SizedBox(height: 60),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.headline4,
            children: [
              TextSpan(
                text: '${displayValue.toStringAsFixed(1)}',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: colorBlue,
                    fontSize: 68),
              ),
              TextSpan(
                text: ' $unit',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: colorBlue,
                    fontSize: 17),
              ),
            ],
          ),
        ),
        Container(
          height: 90,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (notification is ScrollUpdateNotification) {
                _onScroll();
              }
              return true;
            },
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: 365, // Adjusted item count for the range 50 to 180
              itemBuilder: (BuildContext context, int index) {
                return CustomRulerIndicator(
                  value: index + 50, // Adjusted value to start from 50
                  isCentered: (index + 50).toInt() == _currentValue.toInt(),
                  onValueChanged: (value) {
                    setState(() {
                      _currentValue = value;
                    });
                    widget.onValueChanged(value);
                  },
                );
              },
            ),
          ),
        ),
        SizedBox(height: 112),
        RoundedContainer(
          unit1: 'Kg',
          unit2: 'LB',
          onUnitChange: _toggleUnit,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class CustomRulerIndicator extends StatelessWidget {
  final int value;
  final bool isCentered;
  final ValueChanged<double> onValueChanged;

  const CustomRulerIndicator({
    Key? key,
    required this.value,
    required this.isCentered,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height;
    if (value % 10 == 0) {
      height = 90; // Height for every tenth indicator
    } else if (value % 5 == 0) {
      height = 59; // Height for every fifth indicator
    } else {
      height = 29; // Height for all other indicators
    }

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        onValueChanged(value.toDouble());
      },
      child: Container(
        width: 15, // Width of each container
        alignment: Alignment.center,
        child: Container(
          width: 2.82, // Width of the line representing the indicator
          height: height,
          color: colorBlue, // Replace with your color variable or Color object
        ),
      ),
    );
  }
}
