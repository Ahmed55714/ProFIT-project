import 'package:flutter/material.dart';

import 'package:profit1/utils/colors.dart'; 

class CustomHeightPicker extends StatefulWidget {
      
      final Function(int) onSelectHeight;
       CustomHeightPicker({ required this.onSelectHeight});
  @override
  _CustomHeightPickerState createState() => _CustomHeightPickerState();
}

class _CustomHeightPickerState extends State<CustomHeightPicker> {
  int selectedHeight = 180;
  bool isCmSelected = true;

  

  @override
  Widget build(BuildContext context) {
    List<int> heightsCm = List.generate(101, (index) => 100 + index);
    List<String> heightsFt = List.generate(
        101, (index) => (((100 + index) / 30.48)).toStringAsFixed(2));

    return Column(
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
               onSelectedItemChanged: (index) => setState(() {
      selectedHeight = 100 + index;
      widget.onSelectHeight(selectedHeight);
    }),
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) => _buildItem(
                      isCmSelected
                          ? heightsCm[index].toString()
                          : heightsFt[index],
                      isCmSelected
                          ? selectedHeight.toString()
                          : (selectedHeight / 30.48).toStringAsFixed(2),
                    ),
                    childCount: 101,
                  ),
                ),
                Positioned(
                  top: 170,
                  bottom: 140,
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120),
                        child: Container(height: 3, color: colorBlue),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120),
                        child: Container(height: 3, color: colorBlue),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 190,
                  right: 85,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isCmSelected ? 'cm' : 'ft',
                      style: TextStyle(color: colorBlue, fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 88),
        RoundedContainer(
          unit1: 'Cm',
          unit2: 'Ft',
          onUnitChange: (bool isCm) {
            setState(() {
              isCmSelected = isCm;
            });
          },
        ),
      ],
    );
  }

  Widget _buildItem(String value, String selectedValue) {
    final isSelected = value == selectedValue;
    return Container(
      padding: EdgeInsets.only(bottom: 0),
      alignment: Alignment.center,
      child: Text(
        value,
        style: TextStyle(
          fontSize: isSelected ? 46: 40,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w200,
          color: isSelected ? colorBlue : colorBlue400,
        ),
      ),
    );
  }
}

class RoundedContainer extends StatefulWidget {
  final Function(bool) onUnitChange;
String unit1;
  String unit2;
  RoundedContainer({
    Key? key,
    required this.onUnitChange,
    required this.unit1,
    required this.unit2,
  }) : super(key: key);

  @override
  _RoundedContainerState createState() => _RoundedContainerState();
}

class _RoundedContainerState extends State<RoundedContainer> {
  bool isCmSelected = true;
  
 

  @override
  Widget build(BuildContext context) {
    final duration = Duration(milliseconds: 300);

    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isCmSelected = !isCmSelected;
          });
          widget.onUnitChange(isCmSelected);
        },
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
                alignment:
                    isCmSelected ? Alignment.centerLeft : Alignment.centerRight,
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
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.unit1}',
                          style: TextStyle(
                            color: isCmSelected ? Colors.white : colorBlue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.unit2}',
                          style: TextStyle(
                            color: !isCmSelected ? Colors.white : colorBlue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
