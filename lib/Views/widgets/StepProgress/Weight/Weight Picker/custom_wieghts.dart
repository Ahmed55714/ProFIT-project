import 'package:flutter/material.dart';
import 'package:profit1/utils/colors.dart';

import '../../Height/custom_hight_picker.dart';
import '../Ruler/custom_ruler_indicator.dart';

class CustomWeightPicker extends StatefulWidget {
  final double initialValue;
  final ValueChanged<double> onValueChanged;
  final int currentHeight;

  CustomWeightPicker({
    Key? key,
    required this.initialValue,
    required this.onValueChanged,
    required this.currentHeight,
  }) : super(key: key);

  @override
  _CustomWeightPickerState createState() => _CustomWeightPickerState();
}

class _CustomWeightPickerState extends State<CustomWeightPicker> {
  late double _currentValue;
  late double _currentBMI;
  late ScrollController _scrollController;
  bool isKgSelected = true;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _currentBMI = calculateBMI(widget.currentHeight, _currentValue);
    _scrollController = ScrollController(
      initialScrollOffset: (_currentValue - 50) * 60.0,
    );
  }

  double calculateBMI(int height, double weight) {
    double heightInMeters = height / 100.0;
    return weight / (heightInMeters * heightInMeters);
  }

  Map<String, dynamic> getBMICategory(double bmi) {
    String category;
    Color color;

    if (bmi < 18.5) {
      category = 'Underweight';
      color = blue600;
    } else if (bmi < 25) {
      category = 'Normal';
      color = green400;
    } else if (bmi < 30) {
      category = 'Overweight';
      color = Colors.orangeAccent;
    } else {
      category = 'Obese';
      color = red600;
    }

    return {'category': category, 'color': color};
  }

  void _updateWeight(double newWeight) {
    setState(() {
      _currentValue = newWeight;
      _currentBMI = calculateBMI(widget.currentHeight, _currentValue);
    });
    widget.onValueChanged(_currentValue);
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      double scrollPosition = _scrollController.position.pixels;
      double newValue = scrollPosition / 60.0 + 50;
      if (!isKgSelected) {
        newValue = newValue / 2.20462;
      }
      _updateWeight(newValue);
    }
  }

  void _toggleUnit(bool isKg) {
    setState(() {
      isKgSelected = isKg;
      double weightConversion = _currentValue;
      if (isKgSelected) {
        weightConversion /= 2.20462;
      } else {
        weightConversion *= 2.20462;
      }
      _updateWeight(weightConversion);
      _scrollController.jumpTo((_currentValue - 50) * 60.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    var bmiCategory = getBMICategory(_currentBMI);
    String unit = isKgSelected ? 'Kg' : 'LB';
    double displayValue = _currentValue;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: grey300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 16),
              const Text(
                'Your BMI Mass Index (BMI) is:',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w400,
                  color: colorBlue,
                ),
              ),
              const Divider(color: grey300),
              const SizedBox(height: 8),
              Text(
                '${_currentBMI.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 23,
                  fontFamily: 'BoldCairo',
                  fontWeight: FontWeight.bold,
                  color: colorBlue,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6),
                decoration: BoxDecoration(
                  color: bmiCategory[
                      'color'], 
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: bmiCategory['color']),
                ),
                child: IntrinsicWidth(
                  child: Center(
                    child: Text(
                      bmiCategory['category'],
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        const SizedBox(height: 50),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.headlineMedium,
            children: [
              TextSpan(
                text: '${displayValue.toStringAsFixed(1)}',
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: colorBlue,
                    fontSize: 68),
              ),
              TextSpan(
                text: ' $unit',
                style: const TextStyle(
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
              itemCount: 365,
              itemBuilder: (BuildContext context, int index) {
                return CustomRulerIndicator(
                  value: index + 50,
                  isCentered: (index + 50).toInt() == _currentValue.toInt(),
                  onValueChanged: _updateWeight,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 100),
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

