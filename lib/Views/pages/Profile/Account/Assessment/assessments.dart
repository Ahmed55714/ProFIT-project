import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profit1/utils/colors.dart';

import '../../../../widgets/AppBar/custom_appbar.dart';
import '../../../../widgets/General/customBotton.dart';
import 'assessment_details.dart';
import 'new_assessment.dart';

class AssessmentScreen extends StatefulWidget {
  final String role;
  const AssessmentScreen({Key? key, required this.role}) : super(key: key);

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  List<bool> DietAssessment = [];

  @override
  void initState() {
    super.initState();
    DietAssessment = List.filled(notifications.length, false);
  }

  final notifications = [
    {
      'title': 'Tuesday, 15 Sep 2023',
      'description': 'Personal Data - Body Measurement - Preferences',
    },
    {
      'title': 'Wednesday, 1 Sep 2023',
      'description': 'Personal Data - Body Measurement - Preferences',
    },
    {
      'title': 'Monday, 15 Aug 2023',
      'description': 'Personal Data - Body Measurement - Preferences',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey50,
      appBar: CustomAppBar(
        titleText:
            widget.role == '0' ? 'Diet Assessments' : 'Workout Assessments',
        isShowFavourite: true,
        
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AssessmentDetails(
                          role2: widget.role,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: grey200,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          widget.role == '0'
                              ? SvgPicture.asset(
                                  'assets/svgs/greenApple.svg',
                                )
                              : SvgPicture.asset(
                                  'assets/svgs/redDumbell.svg',
                                ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  notification['title'] as String,
                                  style: const TextStyle(
                                    color: DArkBlue900,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  notification['description'] as String,
                                  style: const TextStyle(
                                    color: grey500,
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SvgPicture.asset(
                              'assets/svgs/chevron-small-left.svg',
                              color: grey300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Center(
              child: CustomButton(
                text: widget.role == '0'
                    ? 'Submit New Assessment'
                    : 'Submit New Assessment',
                onPressed: () {
                 
                 widget.role == '0'
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewAssessmentsScreen(
                            role2: widget.role,
                          ),
                        ),
                      )
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewAssessmentsScreen(
                            role2: widget.role,
                          ),
                        ),
                      );
                },
              ),
              
            ),
          ),
        
        ],
      ),
    );
  }
}
