// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/colors.dart';
import '../../../../pages/Explore/Package/package.dart';

class PackageSelector extends StatefulWidget {
  final int index;
  final bool isSelected;
  final String title;
  final String description;
  final String price;
  final String price2;
  final String svgAsset;
  final VoidCallback onTap;
  const PackageSelector({
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
          height: 81,
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
              ),
              SizedBox(width: 60),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.price,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: blue700,
                      ),
                    ),
                    TextSpan(
                      text: ' ${widget.price2}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: blue700,
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

class TitleDescription extends StatelessWidget {
  final String title;
  final String description;
  final Color color;

  const TitleDescription({
    required this.title,
    required this.description,
    this.color = DArkBlue900,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: color == DArkBlue900
                        ? FontWeight.w400
                        : FontWeight.w700,
                    color: color,
                  ),
                ),
                const TextSpan(
                  text: '\n',
                  style: TextStyle(height: 1.2),
                ),
                TextSpan(
                  text: description,
                  style: TextStyle(
                    fontSize: color == DArkBlue900 ? 13 : 11,
                    fontWeight: FontWeight.w400,
                    color: grey500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextWithDot extends StatelessWidget {
  final String text;
  final bool isSvg;
  final bool noPadding;
  const TextWithDot({
    Key? key,
    required this.text,
    this.isSvg = false,
    this.noPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isSvg
          ? const EdgeInsets.only(left: 16.0)
          :  EdgeInsets.only(left: noPadding? 0.0 : 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isSvg
              ? Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: SvgPicture.asset('assets/svgs/Check.svg'),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Container(
                    width: 4,
                    height: 4,
                    color: colorDarkBlue,
                    margin: const EdgeInsets.only(top: 6),
                  ),
                ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: blueDot,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
