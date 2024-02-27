
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class ActivityLevell extends StatefulWidget {
  final Function(String) onActivityLevelChanged;

   ActivityLevell({Key? key, required this.onActivityLevelChanged}) : super(key: key);


  @override
  State<ActivityLevell> createState() => _ActivityLevellState();
}

class _ActivityLevellState extends State<ActivityLevell> {
   int _currentSliderValue = 0;

  // This method maps the slider value to a corresponding activity level string.
  String getActivityLevelFromValue(int value) {
    List<String> activityLevels = [
      'Inactive',
      'Lightly Active',
      'Moderately Active',
      'Very Active',
      'Extremely Active'
    ];
    // Ensure that the slider value does not exceed the list range.
    if (value >= 0 && value < activityLevels.length) {
      return activityLevels[value];
    } else {
      return 'Unknown'; // You can decide how to handle out-of-range values.
    }
  }

  void _updateActivityLevel(int value) {
    String activityLevel = getActivityLevelFromValue(value);
    widget.onActivityLevelChanged(activityLevel); // Use the obtained activity level string.
  }

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
        Container(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: grey300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: <Widget>[
              SizedBox(height: 8),
          _buildActivitySlider(labels),
              Divider(color: grey300),
              SizedBox(height: 8),
              
        _buildActivityDescription(),
              SizedBox(height: 16),
                          
            ],
          ),
        ),
          SizedBox(height: 48),
        _buildActivityLabels(labels, labelFontSize),
        
      
      ],
    );
  }

  Widget _buildActivityLabels(List<String> labels, double fontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: labels.reversed
              .map((label) => _buildLabel(label, labels.indexOf(label)))
              .toList(),
        ),
        SizedBox(width: 52),
         _buildVerticalSlider(labels)
      ],
    );
  }

  Widget _buildLabel(String label, int index,) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 34.0),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: index == _currentSliderValue ? Colors.green : colorBlue,
        ),
      ),
    );
  }

 Widget _buildVerticalSlider(List<String> labels) {
  double sliderHeight = 310.0;

  return RotatedBox(
    quarterTurns: 3,
    child: Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        width: sliderHeight,
        child: Slider(
          activeColor: colorBlue,
  value: _currentSliderValue.toDouble(),
  min: 0,
  max: labels.length - 1.0,
  divisions: labels.length - 1,
  onChanged: (double value) {
    setState(() {
      _currentSliderValue = value.round(); // Round the value to the nearest whole number.
    });
    _updateActivityLevel(_currentSliderValue); // Update the activity level based on the new slider value.
  },
)
      ),
    ),
  );
}


  Widget _buildActivitySlider(List<String> labels) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            labels[_currentSliderValue],
            style:  TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityDescription() {
    return Text(
      'Intense physical activity or athletic training for more than 7 hours per week',
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: colorBlue,
        
      ),
      textAlign: TextAlign.center,
    );
  }
}
