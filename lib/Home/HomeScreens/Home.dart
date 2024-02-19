import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:profit1/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBlue,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: Image.asset('assets/images/profileHome.png'),
              backgroundColor: colorBlue,
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello 👋',
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Ahmed Badawy ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      WidgetSpan(
                        child: SvgPicture.asset(
                          'assets/svgs/smellLeft.svg',
                        ),
                        alignment: PlaceholderAlignment.middle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                'assets/svgs/message-circle-lines.svg',
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                'assets/svgs/bell.svg',
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          BannerCarousel(),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Text(
                  'Today’s Mission',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: colorDarkBlue,
                    fontFamily: 'BoldCairo',
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Container(
                  width: 167.5,
                  height: 123,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: grey200,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/apple.svg',
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Diet',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: colorDarkBlue,
                                fontFamily: 'BoldCairo',
                              ),
                            ),
                            SizedBox(width: 54.5),
                            SvgPicture.asset(
                              'assets/svgs/right.svg',
                              color: colorDarkBlue,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '50%',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: green500,
                                fontFamily: 'BoldCairo',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            LinearPercentIndicator(
                              width: double.infinity,
                              lineHeight: 6.0,
                              padding: EdgeInsets.zero,
                              percent: 0.5,
                              barRadius: const Radius.circular(6),
                              backgroundColor: grey200,
                              progressColor: green500,
                            ),
                          ],
                        ),
                      ],
                    ),
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
        SizedBox(height: 22),
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
              onTap: () => {}, // Optionally handle dot tap
              child: Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
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
