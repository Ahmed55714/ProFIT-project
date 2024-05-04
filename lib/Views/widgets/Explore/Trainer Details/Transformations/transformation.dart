// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:profit1/utils/colors.dart';

const nameTextStyle =
    TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: blue700);
const descriptionTextStyle =
    TextStyle(fontWeight: FontWeight.w400, fontSize: 11, color: DArkBlue900);
const commonPadding = EdgeInsets.symmetric(horizontal: 16);

class TransformationCard extends StatelessWidget {
  String Name;
  String Description;
  String ImagePath;
  String ImagePath2;
   TransformationCard({
    Key? key,
    required this.Name,
    required this.Description,
    required this.ImagePath,
    required this.ImagePath2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: commonPadding,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: grey200),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child:
                          RoundedImage(imagePath: ImagePath)),
                  Expanded(
                      child:
                          RoundedImage(imagePath: ImagePath2)),
                ],
              ),
               Text(Name, style: nameTextStyle),
              const SizedBox(height: 8),
              const Divider(
                  color: grey200, thickness: 1, indent: 16, endIndent: 16),
               Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                 Description,
                  textAlign: TextAlign.center,
                  style: descriptionTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedImage extends StatelessWidget {
  final String imagePath;

  RoundedImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 160,
        height: 199,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
