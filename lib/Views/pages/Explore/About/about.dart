import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';

import '../../../../../utils/colors.dart';
import '../../../widgets/Explore/Trainer Details/about/custom_Information.dart';
import '../../../widgets/Explore/Trainer Details/about/custom_list.dart';
import '../../../widgets/Explore/Trainers/free_diet.dart';

class AboutSection extends StatelessWidget {
  String about;
  final List<AwardData> awardsList;
  final String description;
  final String email;
  final String experience;
  final String location;
  final String createdAt;
  final String age;
  final List<String> specializations;
  final int subscribers;

  AboutSection({
    Key? key,
    required this.about,
    required this.awardsList,
    this.description = '',
    this.email = '',
    this.experience = '',
    this.location = '',
    this.createdAt = '',
    this.age = '',
    this.subscribers = 0,
    this.specializations = const [],
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          const EdgeInsets.symmetric(horizontal: 16.0).copyWith(bottom: 80),
      child: Container(
        color: grey50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const CustomLabelWidget(
              title: 'About',
              isPadding: true,
            ),
            const SizedBox(height: 16),
            _buildTrainerDescription(),
            const SizedBox(height: 16),
            _buildInformationWidgets(),
            const Divider(color: grey200, thickness: 1),
            _buildSpecializationSection(),
            AwardsListHorizontal(awardsList: awardsList),
            const SizedBox(height: 244),
          ],
        ),
      ),
    );
  }

  Widget _buildTrainerDescription() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: grey200),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16.0),
      child: CustomTextWidget(
        text: about,
        color: gre900,
        fontSize: 13,
      ),
    );
  }

  Widget _buildInformationWidgets() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InformationWidget(
                locationText: location,
              ),
            ),
            Expanded(
              child: InformationWidget(
                locationText: email,
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
              child: InformationWidget(
                locationText: age,
                svg: 'assets/svgs/user-1.svg',
                text: 'Age \n',
              ),
            ),
            Expanded(
              child: InformationWidget(
                locationText: createdAt,
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
              child: InformationWidget(
                locationText: experience,
                svg: 'assets/svgs/trophyy.svg',
                text: 'Experience \n',
              ),
            ),
            Expanded(
              child: InformationWidget(
                locationText: subscribers.toString(),
                svg: 'assets/svgs/users-more.svg',
                text: 'Subscriptions \n',
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSpecializationSection() {
    return Column(
      children: [
        const CustomLabelWidget(
          title: 'Specialization',
          isPadding: true,
        ),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Wrap(
                spacing: 8,
                children: specializations
                    .map((spec) => CustomBadge(text: spec))
                    .toList(),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        const Divider(color: grey200, thickness: 1),
        SizedBox(height: 16),
        const CustomLabelWidget(
          title: 'Certifications and Achievements',
          isPadding: true,
        ),
      ],
    );
  }
}
