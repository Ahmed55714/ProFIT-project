// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/colors.dart';
import '../../../../pages/Explore/Package/package.dart';
import 'title_description.dart';

class PackageSelector extends StatefulWidget {
  final int index;
  final bool isSelected;
  final String title;
  final String description;
  final String price;
  final String price2;
  final String price3;
  final String svgAsset;
  final Color color;
  final Color color2;
  final VoidCallback onTap;
  const PackageSelector({
    Key? key,
    required this.index,
    required this.isSelected,
    required this.title,
    required this.description,
    required this.price,
    required this.price2,
    required this.price3,
    required this.svgAsset,
    required this.color,
    required this.color2,
    required this.onTap,
  }) : super(key: key);

  @override
  State<PackageSelector> createState() => _PackageSelectorState();
}

class _PackageSelectorState extends State<PackageSelector> {
  @override
  Widget build(BuildContext context) {
    String selectedSvg = 'assets/svgs/PackageSelect.svg';
    String unselectedSvg = 'assets/svgs/UnPackageSelect.svg';

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: double.infinity,
          height: 88,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.isSelected ? backgroundBlue : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: widget.isSelected ? blue700 : grey200, width: 1),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                widget.isSelected ? selectedSvg : unselectedSvg,
              ),
              SizedBox(width: 24),
              TitleDescription(
                title: widget.title,
                description: widget.description,
                color:  widget.color,
                color2:  widget.isSelected ? colorDarkBlue : grey500, 
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${widget.price3}',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                             color: widget.color2,
                          height: 1,
                          fontFamily: 'BoldCairo'),
                    ),
                     TextSpan(
                      text: ' Month\n',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                             color: widget.color2,
                          height: 1,
                          fontFamily: 'Cairo'),
                    ),
                    TextSpan(
                      text: widget.price,
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                             color: widget.color,
                          height: 1.3,
                          fontFamily: 'BoldCairo'),
                    ),
                    TextSpan(
                      text: ' ${widget.price2}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: widget.color,
                        fontFamily: 'Cairo',
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
