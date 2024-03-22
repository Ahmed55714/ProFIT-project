import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';
import 'custom_image_and_details.dart';

class FoodAlternateSelector extends StatefulWidget {
  final int index;
  final bool isSelected;
  final String title;
  final String description;
  final String price;
  final String price2;
  final String svgAsset;
  final VoidCallback onTap;

  const FoodAlternateSelector({
    Key? key,
    required this.index,
    required this.isSelected,
    required this.title,
    required this.description,
    required this.price,
    required this.price2,
    required this.svgAsset,
    required this.onTap,
  }) : super(key: key);

  @override
  _FoodAlternateSelectorState createState() => _FoodAlternateSelectorState();
}

class _FoodAlternateSelectorState extends State<FoodAlternateSelector> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    String selectedSvg = 'assets/svgs/PackageSelect.svg';
    String unselectedSvg = 'assets/svgs/UnPackageSelect.svg';

    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? backgroundBlue : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? blue700 : grey200,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                isSelected ? selectedSvg : unselectedSvg,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomStackedImage(
                          image: 'assets/images/meat.jpeg',
                          text: '150 ',
                          unit: 'gm',
                        ),
                        SizedBox(width: 16),
                        CustomDetalies(),
                      ],
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
