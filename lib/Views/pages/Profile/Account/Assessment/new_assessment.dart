import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/pages/Profile/Account/Assessment/Diet%20Assessment/diet_assessment.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';
import 'package:profit1/Views/widgets/General/custom_loder.dart';
import '../../../../../services/api_service.dart';
import '../../../../../utils/colors.dart';
import '../../../../widgets/AppBar/custom_appbar.dart';
import '../../../../widgets/BottomSheets/add_challenge.dart';
import '../../../../widgets/Explore/Trainer Details/TabBar/tabBar.dart';
import 'Old Diet Assessment/controller/list_odl_diet.dart';
import 'controller/diet_assessment_controller.dart';
import 'Workout Assessment/workout_assessment.dart';

class NewAssessmentsScreen extends StatelessWidget {
  final String role2;
  const NewAssessmentsScreen({Key? key, required this.role2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DietAssessmentController controller =
        Get.find<DietAssessmentController>();

    void _submitAssessment() async {
      Map<String, dynamic> data = controller.getData();
      await controller.submitDietAssessment(data);
    }

    return DefaultTabController(
      length: role2 == '0' ? 3 : 2,
      child: Scaffold(
        backgroundColor: grey50,
        appBar: CustomAppBar(
          titleText:
              role2 == '0' ? 'New Diet Assessments' : 'New Workout Assessments',
          isShowFavourite: true,
          isShowProfile: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    role2 == '0'
                        ? CustomTabBar(
                            isShowFavourite: true,
                            tabTexts: const [
                              'Personal data',
                              'Measurements',
                              'Preferences'
                            ],
                          )
                        : CustomTabBar(
                            isSitable: true,
                            isShowFavourite: true,
                            tabTexts: const ['Background', 'Preferences'],
                          ),
                  ],
                ),
              ),
              Expanded(
                child: role2 == '0' ? DietAssessment() : WorkOutAssessment(),
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CustomLoder(
                      size: 35,
                    ),
                  );
                }
                return SizedBox.shrink();
              }),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: grey50,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: CustomButton(
              text: 'Submit Assessment',
              onPressed: () {
                _showSendAssessmentConfirmation(context, _submitAssessment);
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showSendAssessmentConfirmation(
      BuildContext context, VoidCallback onConfirm) {
    final OldDietAssessmentController controller2 =
        Get.put(OldDietAssessmentController(ApiService()));

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: Column(
              children: <Widget>[
                CustomHeaderWithCancel(
                  title: 'Are you sure you\'re ready to proceed?',
                  onCancelPressed: () => Navigator.pop(context),
                ),
                Image.asset('assets/images/3diconssw.png'),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      Wrap(
                        children: [
                          Text(
                            'Your progress is important to us, and we want to make sure everything is accurate.',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: DArkBlue900,
                            ),
                            maxLines: 3,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                CustomButton(
                    text: 'Yes',
                    onPressed: () {
                      onConfirm();
                      Navigator.pop(context);
                      controller2.fetchOldDietAssessments();
                    }),
                const SizedBox(height: 8),
                CustomButton(
                    text: 'No', onPressed: () {}, isShowDifferent: true),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSubmittedAssessmentConfirmation(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.38,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: grey600,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: 59,
                  height: 5,
                ),
                SizedBox(height: 16),
                Image.asset('assets/images/true.png'),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      Wrap(
                        children: [
                          Text(
                            'Diet Assessment has been successfully submitted',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 19,
                              color: DArkBlue900,
                            ),
                            maxLines: 3,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Text(
                        'Your Coach will customize your plan ',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: grey400,
                        ),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                CustomButton(text: 'Go to Home', onPressed: () {}),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
