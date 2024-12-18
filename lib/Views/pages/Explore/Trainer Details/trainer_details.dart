import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profit1/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../services/api_service.dart';
import '../../../widgets/Animation/AnimationPage.dart';
import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/Explore/Trainer Details/TabBar/tabBar.dart';
import '../../../widgets/Explore/Trainer Details/about/custom_list.dart';
import '../../../widgets/Explore/Trainers/trainer_continer.dart';
import '../../../widgets/General/customBotton.dart';
import '../../Tabs/Explore/model/trainer.dart';
import '../About/about.dart';
import '../About/controller/trainer_about_controller.dart';
import '../Free Plans/controller/free_plan_controller.dart';
import '../Free Plans/free_plans.dart';
import '../Package/package.dart';
import '../Reviews/reviews.dart';
import '../Transformation/controller/transformation_controller.dart';
import '../Transformation/transformation .dart';

class TrainerDetails extends StatelessWidget {
  final String trainerId;
  final Trainer trainer;

  const TrainerDetails({
    Key? key,
    required this.trainerId,
    required this.trainer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TrainerDetailsController controller = Get.put(TrainerDetailsController());
    controller.loadTrainerDetails(trainerId);
    final TransformController controller2 = Get.put(TransformController());
    controller2.fetchDetails(trainerId);

    // Fetch token from shared preferences
    SharedPreferences.getInstance().then((prefs) {
      String? token = prefs.getString('auth_token');
      if (token != null) {
        final DietPlanController dietPlanController = Get.put(DietPlanController(ApiService()));
        dietPlanController.initialize(trainerId, token);
      }
    });

    return Obx(() {
      return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: CustomAppBar(
            titleText: trainer.fullName ?? '',
            showContainer: true,
            isShowProfile: true,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: trainer.profilePhoto != null
                          ? Image.network(
                              trainer.profilePhoto!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset('assets/images/trainer.png', fit: BoxFit.cover),
                            )
                          : Image.asset('assets/images/trainer.png', fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 35,
                          child: CustomLabelWidget(
                            title: trainer.fullName ?? '',
                          ),
                        ),
                      ],
                    ),
                    RatingWidget(
                      rate: trainer.averageRating.toStringAsFixed(1),
                      rate2: trainer.subscribers.toStringAsFixed(0),
                    ),
                    const SizedBox(height: 16),
                    CustomTabBar(isShowFavourite: true, tabTexts: const [
                      'About',
                      'Reviews',
                      'Gallery',
                      'Free Plans'
                    ]),
                    Container(
                      height: 600,
                      decoration: const BoxDecoration(
                        color: grey50,
                      ),
                      child: controller.isLoading.value
                          ? _buildShimmer()
                          : TabBarView(
                              children: [
                                AboutSection(
                                  about: controller.trainerDetails.value?.biography ?? 'No biography available',
                                  awardsList: controller.trainerDetails.value?.qualificationsAndAchievements
                                          ?.map((achievement) => AwardData(imagePath: achievement))
                                          .toList() ??
                                      [],
                                  email: controller.trainerDetails.value?.email ?? 'No email provided',
                                  experience: controller.trainerDetails.value?.yearsOfExperience ?? 'No experience provided',
                                  location: controller.trainerDetails.value?.location ?? 'No location provided',
                                  createdAt: controller.trainerDetails.value?.createdAt ?? 'No creation date provided',
                                  age: controller.trainerDetails.value?.age ?? 'No age provided',
                                  specializations: controller.trainerDetails.value?.specializations ?? [],
                               subscribers:  controller.trainerDetails.value?.subscribers ?? 0,
                                ),
                                SingleChildScrollView(child: ReviewSection(trainerId: trainerId)),
                                SingleChildScrollView(
                                  child: Gallery(),
                                ),
                                SingleChildScrollView(child: FreePlans()),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.3),
                        Colors.white.withOpacity(0.3),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: CustomButton(
                    text: 'Choose Your Package',
                    onPressed: () {
                      Navigator.of(context).push(
                        createRoute(
                          PackageScreen(
                            packageIds: trainerId,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          8,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              width: double.infinity,
              height: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerTab() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          5,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              width: double.infinity,
              height: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
