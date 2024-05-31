import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/colors.dart';
import '../../../pages/Tabs/home/challenges/controller/challanges_controller.dart';
import '../../General/custom_loder.dart';
import 'give_up.dart';

class ChallengeCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String iconPath;
  final Color borderColor;

  const ChallengeCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.iconPath,
    this.borderColor = Colors.grey,
  }) : super(key: key);

  @override
  _ChallengeCardState createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<ChallengeCard> {
  bool isExpanded = false;
  DateTime? startTime;

  @override
  void initState() {
    super.initState();
    _loadChallengeState();
  }

  Future<void> _loadChallengeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isChallengeStarted = prefs.getBool('${widget.title}_isStarted');
    String? startTimeString = prefs.getString('${widget.title}_startTime');

    if (isChallengeStarted != null && isChallengeStarted && startTimeString != null) {
      setState(() {
        isExpanded = true;
        startTime = DateTime.parse(startTimeString);
      });
    }
  }

  Future<void> _saveChallengeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${widget.title}_isStarted', isExpanded);
    if (isExpanded) {
      await prefs.setString('${widget.title}_startTime', startTime!.toIso8601String());
    } else {
      await prefs.remove('${widget.title}_startTime');
    }
  }

  void _startChallenge() {
    setState(() {
      isExpanded = true;
      startTime = DateTime.now();
    });
    _saveChallengeState();
  }

  void _giveUpChallenge() {
    setState(() {
      isExpanded = false;
      startTime = null;
    });
    _saveChallengeState();
  }

  @override
  Widget build(BuildContext context) {
    final isNetworkImage = widget.imagePath.startsWith('http') || widget.imagePath.startsWith('https');
    Widget imageWidget;

    if (isNetworkImage) {
      imageWidget = ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        child: Image.network(
          widget.imagePath,
          width: 40,
          height: 30,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/images/default_challenge.png', width: 40, height: 30, fit: BoxFit.cover);
          },
        ),
      );
    } else {
      final imageFile = File(widget.imagePath);
      imageWidget = ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Image.file(imageFile, width: 40, height: 30, fit: BoxFit.cover),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        width: isExpanded ? 343 : 171,
        height: isExpanded ? 210 : 106,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: widget.borderColor.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: isExpanded
            ? ExpandedContent(
                title: widget.title,
                startTime: startTime!,
                onGiveUpPressed: () {
                  _giveUpChallenge();
                  print("User gave up on the challenge.");
                },
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16),
                    child: imageWidget,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: colorBlue,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: _startChallenge,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Start Challenge',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                          SvgPicture.asset(
                            widget.iconPath,
                            width: 24,
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}


class ChallengesListWidget extends StatelessWidget {
  final ChallengeController challengeController = Get.put(ChallengeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (challengeController.isLoading.value) {
        return Center(child: CustomLoder());
      } else if (challengeController.errorMessage.isNotEmpty) {
        return Center(child: Text(challengeController.errorMessage.value));
      } else if (challengeController.challenges.isEmpty) {
        return Center(child: Text('No challenges found'));
      } else {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: challengeController.challenges.length,
          itemBuilder: (context, index) {
            final challenge = challengeController.challenges[index];
            return ChallengeCard(
              imagePath: challenge.imagePath ?? 'assets/images/default_challenge.png',
              title: challenge.title ?? 'Untitled',
              iconPath: 'assets/svgs/right.svg',
            );
          },
        );
      }
    });
  }
}
