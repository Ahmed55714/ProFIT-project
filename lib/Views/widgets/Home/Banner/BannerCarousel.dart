

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';


class BannerCarousel extends StatefulWidget {
  @override
  _BannerCarouselState createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _current = 0;
  final List<String> imgList = [
    'assets/images/Component.jpg',
    'assets/images/Component2.jpg',
    'assets/images/Component3.jpg',
    // Add more image paths as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 22),
        CarouselSlider(
          items: imgList
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Image.asset(
                    item,
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            aspectRatio: 2.6,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => {},
              child: Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == entry.key
                      ? colorBlue
                      : colorBlue.withOpacity(0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}





// Expanded content widget













































