import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';

class CustomSelection extends StatelessWidget {
  final int index;
  final bool isSelected;
  final String title;
  final String description;
  final VoidCallback onTap;

  CustomSelection({
    required this.index,
    required this.isSelected,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          width: double.infinity,
          height: 102,
          decoration: BoxDecoration(
            color: isSelected ? colorBlue : colorBlue,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? colorBlue : colorBlue,
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, top: 9),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: isSelected ? colorBlue : colorBlue,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.fastOutSlowIn,
                          child: Visibility(
                            visible: isSelected,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: AnimatedContainer(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.fastOutSlowIn,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 23),
                          child: Text(
                            title,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: isSelected ? colorBlue : colorBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 55, top: 9),
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: isSelected ? colorBlue : colorBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Ensure you have this import

class CustomSelectionStepProgress extends StatefulWidget {
  final int index;
  final bool isSelected;
  final String title;
  final String description;
  final String svgAsset; // Path to your SVG file in the assets
  final VoidCallback onTap;

  CustomSelectionStepProgress({
    required this.index,
    required this.isSelected,
    required this.title,
    required this.description,
    required this.svgAsset,
    required this.onTap,
  });

  @override
  State<CustomSelectionStepProgress> createState() => _CustomSelectionStepProgressState();
}

class _CustomSelectionStepProgressState extends State<CustomSelectionStepProgress> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: widget.isSelected ? colorBlue : colorBlue,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.isSelected ? colorBlue : colorBlue,
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SvgPicture.asset(
                  widget.svgAsset,
                  width: 40, // Adjust the size as needed
                  height: 40,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: widget.isSelected ? colorBlue : colorBlue,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: widget.isSelected ? colorBlue : colorBlue,
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
