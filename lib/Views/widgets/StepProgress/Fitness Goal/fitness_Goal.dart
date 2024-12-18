import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/colors.dart';
class CustomSelectionStepProgress extends StatefulWidget {
  final int index;
  final bool isSelected;
  final String title;
  final String description;
  final String svgAsset;
  final Color svg;
  final VoidCallback onTap;

  CustomSelectionStepProgress({
    required this.index,
    required this.isSelected,
    required this.title,
    required this.description,
    required this.svgAsset,
    this.svg = colorBlue,
    required this.onTap,
  });

  @override
  State<CustomSelectionStepProgress> createState() => _CustomSelectionStepProgressState();
}

class _CustomSelectionStepProgressState extends State<CustomSelectionStepProgress> {
  @override
  Widget build(BuildContext context) {
    // Define the SVG assets for selected and unselected states
    String selectedSvg = 'assets/svgs/selected.svg';
    String unselectedSvg = 'assets/svgs/unselected.svg';

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
  
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: widget.isSelected ? lightBlue : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.isSelected ? colorBlue : grey300,
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SvgPicture.asset(
                widget.svgAsset,
                width: 32, 
                height: 32,
                 color: widget.svg,
              ),
            ),
             const SizedBox(width: 16),
            Expanded( 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: widget.isSelected ? colorBlue : colorBlue,
                    ),
                    
                  ),
              
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
          
            SvgPicture.asset(
              
              widget.isSelected ? selectedSvg : unselectedSvg,
              width: 20,
              height: 20,
             
            ),
          ],
        ),
      ),
    );
  }
}
