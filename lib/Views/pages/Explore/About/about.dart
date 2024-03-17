import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';

import '../../../../../utils/colors.dart';
import '../../../widgets/Explore/Trainer Details/about/custom_Information.dart';
import '../../../widgets/Explore/Trainer Details/about/custom_list.dart';
import '../../../widgets/Explore/Trainers/free_diet.dart';

class AboutSection extends StatelessWidget {
  final List<AwardData> awardsList;

  const AboutSection({Key? key, required this.awardsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(
              bottom:
                  80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const CustomLabelWidget(title: 'About', isPadding: true,),
              const SizedBox(height: 16),
              _buildTrainerDescription(),
              const SizedBox(height: 16),
              _buildInformationWidgets(),
              const Divider(color: grey200, thickness: 1),
              _buildSpecializationSection(),
              AwardsListHorizontal(awardsList: awardsList),
              const SizedBox(
                  height: 244),
            ],
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
      child: const CustomTextWidget(
        text:
            'An internationally certified trainer has helped many people achieve the body shape they dream of, 100% natural, and be healthy in the best condition through commitment and continuity, which is my main goal in training. Let me help you achieve this and be one of the people who achieve the body shape you dream of',
        color: gre900,
        fontSize: 13,
      ),
    );
  }

  Widget _buildInformationWidgets() {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InformationWidget(
                locationText: 'Alexandria, Egypt',
              ),
            ),
            Expanded(
              child: InformationWidget(
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
              child: InformationWidget(
                locationText: '23 Years Old',
                svg: 'assets/svgs/user-1.svg',
                text: 'Age \n',
              ),
            ),
            Expanded(
              child: InformationWidget(
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
              child: InformationWidget(
                locationText: '3 Years',
                svg: 'assets/svgs/trophyy.svg',
                text: 'Experience \n',
              ),
            ),
            Expanded(
              child: InformationWidget(
                locationText: '119',
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
    return const Column(
      children: [
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
            CustomBadge(text: 'Fitness'),
             SizedBox(width: 8),
            CustomBadge(text: 'Abdo Elsayed'),
          ],
        ),
        SizedBox(height: 16),
        Divider(color: grey200, thickness: 1),
        SizedBox(height: 16),
        CustomLabelWidget(
          title: 'Certifications and Achievements',
          isPadding: true,
        ),
      ],
    );
  }
}
