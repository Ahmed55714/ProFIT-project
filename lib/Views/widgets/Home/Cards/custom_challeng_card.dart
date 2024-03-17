import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/colors.dart';
import '../../BottomSheets/add_challenge.dart';
import '../BannerCarousel.dart';
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

  @override
  Widget build(BuildContext context) {
    final isAssetImage = widget.imagePath.startsWith('assets/');
    Widget imageWidget;

    if (isAssetImage) {
      // For asset images
      imageWidget = Image.asset(widget.imagePath,
          width: 40, height: 30, fit: BoxFit.cover);
    } else {
      // For file images
      final imageFile = File(widget.imagePath);
      imageWidget = ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Image.file(imageFile, width: 40, height: 30, fit: BoxFit.cover),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
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
                onGiveUpPressed: () {
                  print("User gave up on the challenge.");
                  setState(() {
                    isExpanded = false;
                  });
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
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
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







class ChallengesListWidget extends StatefulWidget {
  final List<Challenge> challenges;

  const ChallengesListWidget({Key? key, required this.challenges})
      : super(key: key);

  @override
  _ChallengesListWidgetState createState() => _ChallengesListWidgetState();
}

class _ChallengesListWidgetState extends State<ChallengesListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.challenges.length,
        itemBuilder: (context, index) {
          final challenge = widget.challenges[index];
          return ChallengeCard(
            imagePath: challenge.imagePath,
            title: challenge.title,
            iconPath: 'assets/svgs/right.svg',
          );
        },
      ),
    );
  }
}

