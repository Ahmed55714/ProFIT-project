
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class ActivityLevell extends StatefulWidget {
  const ActivityLevell({Key? key}) : super(key: key);

  @override
  State<ActivityLevell> createState() => _ActivityLevellState();
}

class _ActivityLevellState extends State<ActivityLevell> {
  int _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    final labels = [
      'Inactive',
      'Lightly Active',
      'Moderately Active',
      'Very Active',
      'Extremely Active'
    ];

    // Responsive design
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = screenSize.width > screenSize.height;
    final labelFontSize = isLandscape ? screenSize.width * 0.015 : 15.0;
    final descriptionFontSize = isLandscape ? screenSize.width * 0.012 : 13.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildActivityLabels(labels, labelFontSize),
        const SizedBox(height: 20),
        _buildActivitySlider(labels),
        const SizedBox(height: 8),
        _buildActivityDescription(descriptionFontSize),
      ],
    );
  }

  Widget _buildActivityLabels(List<String> labels, double fontSize) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: labels.reversed
              .map((label) => _buildLabel(label, labels.indexOf(label), fontSize))
              .toList(),
        ),
        const SizedBox(width: 20),
        Expanded(child: _buildVerticalSlider(labels)),
      ],
    );
  }

  Widget _buildLabel(String label, int index, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 34.0),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
          color: index == _currentSliderValue ? Colors.green : colorBlue,
        ),
      ),
    );
  }

  Widget _buildVerticalSlider(List<String> labels) {
    return RotatedBox(
      quarterTurns: 3,
      child: Slider(
        value: _currentSliderValue.toDouble(),
        min: 0,
        max: labels.length - 1.0,
        divisions: labels.length - 1,
        onChanged: (value) {
          setState(() {
            _currentSliderValue = value.toInt();
          });
        },
        activeColor: colorBlue,
        inactiveColor: colorBlue.withOpacity(0.3),
      ),
    );
  }

  Widget _buildActivitySlider(List<String> labels) {
    return Row(
      children: [
        Center(
          child: Text(
            labels[_currentSliderValue],
            style:  TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: colorBlue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityDescription(double fontSize) {
    return Text(
      'Intense physical activity or athletic training for more than 7 hours per week',
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: colorBlue,
      ),
    );
  }
}
