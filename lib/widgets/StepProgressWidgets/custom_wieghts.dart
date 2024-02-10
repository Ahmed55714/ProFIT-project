import 'package:flutter/material.dart';
import 'package:animated_weight_picker/animated_weight_picker.dart';

import '../../utils/colors.dart';

class BmiCalculator extends StatefulWidget {
  @override
  _BmiCalculatorState createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  double bmiValue = 22.5; // Example BMI value, this should be dynamically calculated

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildWeightPicker(),
            const SizedBox(height: 34),
            _buildBmiText(),
            _buildBmiValue(),
            _buildBmiCategory(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightPicker() {
    return AnimatedWeightPicker(
      min: 30,
      max: 250,
      division: 0.1,
      dialColor: colorBlue,
      suffixTextColor: colorBlue,
      selectedValueColor: colorBlue,
      squeeze: 2,
      dialHeight: 55,
      dialThickness: 3,
      subIntervalHeight: 35,
      subIntervalThickness: 3,
      subIntervalTextSize: 20,
      minorIntervalHeight: 20,
      minorIntervalThickness: 3,
      selectedValueStyle: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        // color: colorBlue,
      ),
      suffixText: 'kg',
      majorIntervalTextSize: 1,
      showSubIntervalText: false,
      onChange: (_) {}, 
    );
  }

  Widget _buildBmiText() {
    return  Text(
      'Your Body Mass Index (BMI) is',
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        fontFamily: 'Cairo',
        color: colorBlue,
      ),
    );
  }

  Widget _buildBmiValue() {
    return Text(
      '$bmiValue', 
      style:  TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        fontFamily: 'Cairo',
        color: colorBlue,
      ),
    );
  }

  Widget _buildBmiCategory() {
    
    String category = 'Normal'; 
    Color categoryColor = Colors.green; 

    return Text(
      category,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        fontFamily: 'Cairo',
        color: categoryColor,
      ),
    );
  }
}

