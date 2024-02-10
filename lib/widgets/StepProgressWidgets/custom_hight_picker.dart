import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';


class CustomHeightPicker extends StatefulWidget {
  @override
  _CustomHeightPickerState createState() => _CustomHeightPickerState();
}

class _CustomHeightPickerState extends State<CustomHeightPicker> {
  int selectedHeight = 165; // Default height in cm
  bool isCmSelected = true; // Whether the unit is in cm

  @override
  Widget build(BuildContext context) {
    List<int> heightsCm = List.generate(101, (index) => index + 100); // cm
    List<double> heightsFt = List.generate(101, (index) => ((index + 100) / 30.48)); // ft

    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 250,
              child: CupertinoPicker(
                itemExtent: 75,
                diameterRatio: 3,
                selectionOverlay: Center(
                  child: Container(
                    height: 75,
                    width: 156,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: colorBlue, width: 3),
                        bottom: BorderSide(color: colorBlue, width: 3),
                      ),
                    ),
                  ),
                ),
                useMagnifier: true,
                magnification: 1.2,
                backgroundColor: Colors.transparent,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    selectedHeight = index + 100;
                  });
                },
                scrollController: FixedExtentScrollController(
                  initialItem: selectedHeight - 100,
                ),
                children: isCmSelected
                    ? heightsCm.map((cm) => Center(
                            child: Text(
                          '$cm',
                          style: TextStyle(
                            color: selectedHeight == cm ? colorBlue : colorBlue,
                            fontSize: selectedHeight == cm ? 50 : 34, // Adjust font size here
                          ),
                        )))
                        .toList()
                    : heightsFt.map((ft) => Center(
                            child: Text(
                          '${ft.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: selectedHeight == ((ft * 30.48).toInt()) ? colorBlue : Colors.grey,
                            fontSize: selectedHeight == ((ft * 30.48).toInt()) ? 50 : 34, // Adjust font size here
                          ),
                        )))
                        .toList(),
              ),
            ),
            Positioned( 
              top: 105,
              left: 260, 
              child: Text(
                isCmSelected ? 'cm' : 'ft',
                style: TextStyle(
                  fontSize: 17,
                  color: colorBlue,
                  fontWeight: FontWeight.w400,
                  
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 70),
        RoundedContainer(
          onUnitChange: (bool cmSelected) {
            setState(() {
              isCmSelected = cmSelected;
            });
          },
        ),
      ],
    );
  }
}
class RoundedContainer extends StatefulWidget {
  final Function(bool) onUnitChange;

  RoundedContainer({required this.onUnitChange});

  @override
  _RoundedContainerState createState() => _RoundedContainerState();
}

class _RoundedContainerState extends State<RoundedContainer> {
  bool isCmSelected = true;

  @override
  Widget build(BuildContext context) {
    final duration = Duration(milliseconds: 300);

    return Center(
      child: Container(
        width: 100,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: colorBlue, width: 1),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: isCmSelected ? Alignment.centerLeft : Alignment.centerRight,
              duration: duration,
              curve: Curves.easeInOut,
              child: Container(
                width: 50,
                height: 32,
                decoration: BoxDecoration(
                  color: colorBlue,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (!isCmSelected) {
                          widget.onUnitChange(true);
                          setState(() => isCmSelected = true);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('Cm', style: TextStyle(color: isCmSelected ? Colors.white : colorBlue, fontSize: 16)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (isCmSelected) {
                          widget.onUnitChange(false);
                          setState(() => isCmSelected = false);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('ft', style: TextStyle(color: isCmSelected ? colorBlue : Colors.white, fontSize: 16)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
