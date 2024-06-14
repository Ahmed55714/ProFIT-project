import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profit1/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../services/api_service.dart';
import '../../../../../widgets/AppBar/custom_appbar.dart';
import '../../../../../widgets/General/customBotton.dart';
import '../../../../../widgets/General/custom_loder.dart';
import 'assessment_details.dart';
import '../new_assessment.dart';
import 'controller/list_odl_diet.dart';


class AssessmentScreen extends StatefulWidget {
  final String role;
  const AssessmentScreen({Key? key, required this.role}) : super(key: key);

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  final OldDietAssessmentController controller = Get.put(OldDietAssessmentController(ApiService()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey50,
      appBar: CustomAppBar(
        titleText: widget.role == '0' ? 'Diet Assessments' : 'Workout Assessments',
        isShowFavourite: true,
      ),
      body: Stack(
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return buildShimmerLoader();
            }
            if (controller.oldDietAssessments.isEmpty) {
              return Center(child: Text('No assessments found.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 80),
              itemCount: controller.oldDietAssessments.length,
              itemBuilder: (context, index) {
                final assessment = controller.oldDietAssessments[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => AssessmentDetails(
                            role2: widget.role,
                            assessmentId: assessment.dietAssessmentId,
                          ),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset(0.0, 0.0);
                            const curve = Curves.easeInOut;

                            final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            widget.role == '0'
                                ? SvgPicture.asset('assets/svgs/greenApple.svg')
                                : SvgPicture.asset('assets/svgs/redDumbell.svg'),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    assessment.createdAt,
                                    style: const TextStyle(
                                      color: DArkBlue900,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    assessment.dietAssessmentData,
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
            );
          }),
          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Center(
              child: Obx(() {
                if (!controller.isLoading.value) {
                  return CustomButton(
                    text: widget.role == '0' ? 'Submit New Assessment' : 'Submit New Assessment',
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => NewAssessmentsScreen(
                            role2: widget.role,
                          ),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset(0.0, 0.0);
                            const curve = Curves.easeInOut;

                            final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return SizedBox.shrink(); // Hide button when loading
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShimmerLoader() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 80),
      itemCount:  1,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    widget.role == '0'
                        ? SvgPicture.asset('assets/svgs/greenApple.svg')
                        : SvgPicture.asset('assets/svgs/redDumbell.svg'),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 13.0,
                            color: Colors.grey[300],
                          ),
                          SizedBox(height: 8.0),
                          Container(
                            width: double.infinity,
                            height: 11.0,
                            color: Colors.grey[300],
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
    );
  }
}