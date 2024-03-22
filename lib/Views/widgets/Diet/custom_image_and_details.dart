import 'package:flutter/material.dart';

import '../Explore/Trainer Details/Packages/package.dart';

class CustomStackedImage extends StatelessWidget {
  final String image;
  final String text;
  final String unit;

  const CustomStackedImage({
    super.key,
    this.image = 'assets/images/breakfast.jpeg',
    this.text = '50 ',
    this.unit = 'gm',
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 80,
            height: 80,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0.5),
                  Colors.black,
                ],
                stops: [0, 1, 1],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text:  TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: text,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                          ),
                        ),
                        TextSpan(
                          text: unit,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class CustomDetalies extends StatelessWidget {
  final String title;
  final String text;
  final String unit;

  const CustomDetalies({
    super.key,
    this.title = 'فرينش توست',
    this.text = '4 slices of bread',
    this.unit = '1/2 cup milk',
  });
  
  get colorDarkBlue => null;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: colorDarkBlue,
              ),
            ),
            SizedBox(
              height: 20,
              width: 120,
              child: TextWithDot(
                noPadding: true,
                text: text,
              ),
            ),
            SizedBox(
              height: 20,
              width: 120,
              child: TextWithDot(
                noPadding: true,
                text: '2 large eggs',
              ),
            ),
            SizedBox(
              height: 20,
              width: 120,
              child: TextWithDot(
                noPadding: true,
                text: unit,
              ),
            ),
          ],
        ),
      ],
    );
  }
}