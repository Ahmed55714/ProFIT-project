import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:profit1/Views/widgets/BottomSheets/Water%20Need/water_needs.dart' as water_needs;
import 'package:profit1/Views/widgets/Home/Cards/custom_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:profit1/utils/colors.dart';
import '../../../widgets/BottomSheets/Water Need/water_need.dart';
import '../../../widgets/BottomSheets/add_challenge.dart';
import '../../../widgets/BottomSheets/Sleep Track/sleep_track.dart';
import '../../../widgets/General/customBotton.dart';
import '../../../widgets/General/custom_loder.dart';
import '../../../widgets/Home/Banner/BannerCarousel.dart';
import '../../../widgets/Home/Cards/Custom_info_card.dart';
import '../../../widgets/Home/Rounded Continer/custom_rounded_continer.dart';
import '../../Features/Chat/chat.dart';
import '../../Features/Chat/trainers_list.dart';
import '../../Features/Heart Rate/controller/heart_rate_controller.dart';
import '../../Features/Heart Rate/heart_rate.dart';
import '../../Features/Notifications/Notification.dart';
import '../../Features/Steps/steps.dart';
import '../../Features/Water Need/controller/water_controller.dart';
import '../../Profile/Account Data/controller/profile_controller.dart';
import '../../Profile/profile Screen/profile_screen.dart';
import 'Steps/controller/steps_controller.dart';
import '../../Features/Sleep Track/controller/sleep_track_controller.dart';
import 'challenges/controller/challanges_controller.dart';
import 'challenges/custom_challeng_card.dart';
import 'challenges/model/challanges.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProfileController profileController = Get.find<ProfileController>();
  final HeartRateController heartRateController = Get.put(HeartRateController());
  final StepsController stepsController = Get.put(StepsController());
  final WaterController waterController = Get.put(WaterController());
  final SleepTrackController sleepTrackController = Get.put(SleepTrackController());
  final ChallengeController challengeController = Get.put(ChallengeController());

  File? _image;

  void _showAddChallengeModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddChallengeBottomSheet(
        onChallengeAdded: (Challenge challenge) {
          challengeController.fetchChallenges();
        },
      ),
    );
  }

  Future<void> fetchImage(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      final bytes = response.bodyBytes;
      if (bytes.isNotEmpty) {
        final dir = await getTemporaryDirectory();
        _image = File('${dir.path}/profile.jpg');
        await _image!.writeAsBytes(bytes);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('profile_image_path', _image!.path);
        setState(() {});
      } else {
        print('Fetched image data is empty.');
      }
    } catch (e) {
      print('Failed to fetch image: $e');
    }
  }

  Future<void> loadImage() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? imagePath = prefs.getString('profile_image_path');
      if (imagePath != null) {
        File imageFile = File(imagePath);
        bool fileExists = await imageFile.exists();
        if (fileExists) {
          _image = imageFile;
          await decodeImageFromList(await _image!.readAsBytes());
          setState(() {});
        } else {
          fetchImage(profileController.profile.value?.profilePhoto ?? '');
        }
      } else {
        fetchImage(profileController.profile.value?.profilePhoto ?? '');
      }
    } catch (e) {
      print('Failed to load image: $e');
      _image = null;
      setState(() {});
    }
  }

  Future<void> _navigateToHeartRateScreen() async {
    final result = await Get.to(() => HeartRateScreen());
    if (result != null) {
      heartRateController.heartRate.value = result;
    }
  }

  @override
  void initState() {
    super.initState();
    profileController.fetchUserProfile().then((_) {
      loadImage();
    });

    heartRateController.requestPermissions();
    heartRateController.fetchHeartRateData();
    waterController.fetchWaterIntake();
    sleepTrackController.fetchLatestSleepData();
    challengeController.fetchChallenges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBlue,
        automaticallyImplyLeading: false,
        toolbarHeight: 64,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              child: Obx(() {
                var userProfile = profileController.profile.value;
                return userProfile == null
                    ? CustomLoder(color: colorBlue)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 21,
                          child: userProfile?.profilePhoto != null
                              ? Image.network(
                                  userProfile!.profilePhoto,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/images/profileHome.png',
                                        width: 100,
                                        height: 100);
                                  },
                                )
                              : Image.asset(
                                  'assets/images/profileHome.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      );
              }),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'Hello 👋',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Cairo',
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                  Obx(() {
                    return RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: profileController.profile.value?.firstName ??
                                '',
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BoldCairo',
                              color: Colors.white,
                            ),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: SvgPicture.asset(
                                'assets/svgs/smellLeft.svg',
                                width: 24,
                                height: 24,
                                color: Colors.white,
                              ),
                            ),
                            alignment: PlaceholderAlignment.middle,
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.to(TrainerListScreen(
                  
                ));
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset('assets/svgs/message-circle-lines.svg'),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                Get.to(NotificationScreen());
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset('assets/svgs/bell.svg'),
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: BannerCarousel(),
          ),
          SliverToBoxAdapter(
            child: const SizedBox(height: 24),
          ),
          SliverToBoxAdapter(
            child: const Row(
              children: [
                CustomLabelWidget(
                  title: 'Today’s Mission',
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: const SizedBox(height: 16),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 167.5 / 123,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index == 0) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => StepsScreen(
                            title: 'Diet',
                            asset: 'assets/svgs/apple.svg',
                          ),
                        );
                      },
                      child: CustomInfoCard(
                        leftIconPath: 'assets/svgs/apple.svg',
                        rightIconPath: 'assets/svgs/right.svg',
                        title: 'Diet',
                        percentage: 0.0,
                        borderColor: Colors.grey[200]!,
                        titleColor: colorDarkBlue,
                        percentageColor: green500,
                        Text1: '0 / 0 Kcal',
                        width: 167.5,
                        height: 123,
                        onTap: () {
                          Get.to(
                            () => StepsScreen(
                              title: 'Diet',
                              asset: 'assets/svgs/apple.svg',
                            ),
                          );
                        },
                      ),
                    );
                  } else if (index == 1) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => StepsScreen(
                            title: 'Workout',
                            asset: 'assets/svgs/Dumbbelll.svg',
                          ),
                        );
                      },
                      child: CustomInfoCard(
                        leftIconPath: 'assets/svgs/Dumbbelll.svg',
                        rightIconPath: 'assets/svgs/right.svg',
                        title: 'Workout',
                        percentage: 0.0, 
                        borderColor: Colors.grey[200]!,
                        titleColor: colorDarkBlue,
                        percentageColor: redColor,
                        Text1: '0 / 0 Exercises',
                        width: 167.5,
                        height: 123,
                        onTap: () {
                          Get.to(
                            () => StepsScreen(
                              title: 'Workout',
                              asset: 'assets/svgs/Dumbbelll.svg',
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
                childCount: 2,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: const SizedBox(height: 8),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Obx(() {
                final stepPercentage = (stepsController.steps.value /
                        stepsController.dailyStepGoal.value)
                    .clamp(0.0, 1.0);
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      () => StepsScreen(
                        title: 'Steps',
                        asset: 'assets/svgs/ic_round-directions-run.svg',
                      ),
                    );
                  },
                  child: CustomInfoCard(
                    onTap: () {
                      Get.to(
                        () => StepsScreen(
                          title: 'Steps',
                          asset: 'assets/svgs/ic_round-directions-run.svg',
                        ),
                      );
                    },
                    leftIconPath: 'assets/svgs/ic_round-directions-run.svg',
                    rightIconPath: 'assets/svgs/right.svg',
                    title: 'Steps',
                    percentage: stepPercentage,
                    borderColor: Colors.grey[200]!,
                    titleColor: colorDarkBlue,
                    percentageColor: pinkColor,
                    Text1:
                        '${stepsController.steps.value} / ${stepsController.dailyStepGoal.value} Steps',
                    width: 343,
                    height: 148,
                    isShow: true,
                    isShowText2: true,
                  ),
                );
              }),
            ),
          ),
          SliverToBoxAdapter(
            child: const SizedBox(height: 8),
          ),
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                Get.to(
                  () => StepsScreen(
                    title: 'water Needs',
                    asset: 'assets/svgs/mingcute_glass-cup-fill.svg',
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: 343,
                  height: 208,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey[200]!,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 16,
                      right: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/mingcute_glass-cup-fill.svg',
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'Water Needs',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: colorDarkBlue,
                                fontFamily: 'BoldCairo',
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => StepsScreen(
                                    title: 'water Needs',
                                    asset: 'assets/svgs/mingcute_glass-cup-fill.svg',
                                  ),
                                );
                              },
                              child: SvgPicture.asset(
                                'assets/svgs/right.svg',
                                color: colorDarkBlue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Obx(
                          () => water_needs.WaterNeedsWidget(
                            currentIntakeML: waterController.waterIntake.value.toDouble(),
                            goalIntakeML: waterController.waterGoal.value.toDouble(),
                          ),
                        ),
                        Expanded(
                          child: ActionButton(
                            text: 'Add Cup (250mL)',
                            onPressed: () {
                              showWaterNeedsBottomSheet(context);
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: const SizedBox(height: 24),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: const RoundedContainerWithRow(
                text: 'Nearest Gym',
                buttonIconPath: 'assets/svgs/search.svg',
                iconPath: 'assets/svgs/Location.svg',
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: const SizedBox(height: 24),
          ),
          SliverToBoxAdapter(
            child: const CustomLabelWidget(
              title: 'Health Tracking',
            ),
          ),
          SliverToBoxAdapter(
            child: const SizedBox(height: 16),
          ),
        SliverToBoxAdapter(
  child: Obx(() {
    final sleepData = sleepTrackController.hoursSlept.value.split(' ');
    final hours = sleepData.isNotEmpty && sleepData[0] != '0'
        ? int.tryParse(sleepData[0])?.toString() ?? '0'
        : '0';

    final minutes = sleepData.length > 2 
        ? int.tryParse(sleepData[2])?.toString() ?? '0' 
        : '0';

    return GestureDetector(
      onTap: () {
        Get.to(
          () => StepsScreen(
            title: 'Sleep Tracking',
            asset: 'assets/svgs/sleep1.svg',
          ),
        );
      },
      child: CustomCard(
        title: "Sleep Tracking",
        number: hours,
        text1: 'hrs',
        minutes: minutes,
        date: sleepTrackController.dateRecorded.value.isNotEmpty
            ? sleepTrackController.dateRecorded.value
            : 'No data',
        imagePath: 'assets/images/124.png',
        icon: 'assets/svgs/sleep1.svg',
        onPress: () {
          showSleepTrackBottomSheet(context);
        },
        onRecordTime: () {
          Get.to(
            StepsScreen(
              title: 'Sleep Tracking',
              asset: 'assets/svgs/sleep1.svg',
            ),
          );
        },
      ),
    );
  }),
),

          SliverToBoxAdapter(
            child: const SizedBox(height: 8),
          ),
          SliverToBoxAdapter(
            child: Obx(() {
              return GestureDetector(
                onTap: _navigateToHeartRateScreen,
                child: CustomCard(
                  title: "Heart Rate",
                  number: heartRateController.heartRate.value.toString(),
                  text1: 'BPM\n',
                  date: heartRateController.formattedDate.value,
                  imagePath: 'assets/images/heart.png',
                  icon: 'assets/svgs/heart.svg',
                  onRecordTime: _navigateToHeartRateScreen,
                  isShow: false,
                ),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: const SizedBox(height: 24),
          ),
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                _showAddChallengeModalBottomSheet(context);
              },
              child: Row(
                children: [
                  const CustomLabelWidget(
                    title: 'Challenges',
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/svgs/plus.svg',
                    width: 24,
                    height: 24,
                    color: colorDarkBlue,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Add Challenge',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: colorDarkBlue,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: const SizedBox(height: 8),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 110,
                    child: ChallengesListWidget(),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: const SizedBox(height: 60),
          ),
        ],
      ),
    );
  }
}
