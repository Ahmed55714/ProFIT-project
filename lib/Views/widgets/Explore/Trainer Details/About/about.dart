import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';

import '../../../../../utils/colors.dart';
import '../../Trainers/free_diet.dart';

class AboutSction extends StatelessWidget {
  const AboutSction({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const CustomLabelWidget(
            title: 'About',
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: grey200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CustomTextWidget(
                      text:
                          'An internationally certified trainer has helped many people achieve the body shape they dream of, 100% natural, and be healthy in the best condition through commitment and continuity, which is my main goal in training. Let me help you achieve this and be one of the people who achieve the body shape you dream of',
                      color: gre900,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: LocationWidget(
                            locationText: 'Alexandria, Egypt',
                          ),
                        ),
                        Expanded(
                          child: LocationWidget(
                            locationText: 'ahmedtarek@gmail.com',
                            svg: 'assets/svgs/at-email.svg',
                            text: 'Email \n',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: LocationWidget(
                            locationText: '23 Years Old',
                            svg: 'assets/svgs/user-1.svg',
                            text: 'Age \n',
                          ),
                        ),
                        Expanded(
                          child: LocationWidget(
                            locationText: 'April, 2022',
                            svg: 'assets/svgs/calendarr.svg',
                            text: 'Member Since \n',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: LocationWidget(
                            locationText: '3 Years',
                            svg: 'assets/svgs/trophyy.svg',
                            text: 'Experience \n',
                          ),
                        ),
                        Expanded(
                          child: LocationWidget(
                            locationText: '119',
                            svg: 'assets/svgs/users-more.svg',
                            text: 'Subscriptions \n',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Divider(
                      color: grey200,
                      thickness: 1,
                    ),
                    CustomLabelWidget(
                      title: 'Specialization',
                      isPadding: true,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        CustomBadge(text: 'Body Building'),
                        SizedBox(width: 8),
                        CustomBadge(text: 'CrossFit'),
                        SizedBox(width: 8),
                        CustomBadge(text: 'CrossFit'),
                        SizedBox(width: 8),
                        CustomBadge(text: 'Fitness'),
                      ],
                    ),
                    SizedBox(height: 16),
                    Divider(
                      color: grey200,
                      thickness: 1,
                    ),
                    SizedBox(height: 16),
                    CustomLabelWidget(
                      title: 'Certifications and Achievements',
                      isPadding: true,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}












class LocationWidget extends StatelessWidget {
  final String locationText;
  final Color textColor;
  final double textSize;
  final String svg;
  final String text;

  const LocationWidget({
    Key? key,
    required this.locationText,
    this.textColor = colorDarkBlue,
    this.textSize = 13.0,
    this.svg = 'assets/svgs/location-12.svg',
    this.text = 'From \n',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(svg),
        const SizedBox(width: 16),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: textSize,
                color: textColor,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: text,
                  style: TextStyle(
                    fontSize: textSize,
                    color: grey400,
                  ),
                ),
                TextSpan(
                  text: locationText,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: textSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
