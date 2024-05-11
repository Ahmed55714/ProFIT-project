// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:profit1/utils/colors.dart';

import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/Explore/Trainer Details/Packages/package.dart';
import '../../../widgets/Explore/Trainer Details/Packages/text_dot.dart';
import '../../../widgets/General/customBotton.dart';
import 'check_out.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  int selectedContainerIndex = -1;

  void selectContainer(int index) {
    setState(() {
      selectedContainerIndex = (selectedContainerIndex == index) ? -1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        titleText: 'Package',
        showContainer: true,
       
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            const CustomLabelWidget(
              title: 'Choose Your Package',
            ),
            PackageSelector(
              index: 0,
              isSelected: selectedContainerIndex == 0,
              title: 'Bronze Package',
              description: '3 months',
              price: '1,650',
              price2: 'EGP',
              svgAsset: 'assets/svgs/PackageSelect.svg',
              onTap: () {
                selectContainer(0);
              },
            ),
            PackageSelector(
              index: 1,
              isSelected: selectedContainerIndex == 1,
              title: 'Silver Package',
              description: '6 Months',
              price: '2,800',
              price2: 'EGP',
              svgAsset: 'assets/svgs/UnPackageSelect.svg',
              onTap: () {
                selectContainer(1);
              },
            ),
            PackageSelector(
              index: 2,
              isSelected: selectedContainerIndex == 2,
              title: 'Bronze Package',
              description: '3 months',
              price: '3,600',
              price2: 'EGP',
              svgAsset: 'assets/svgs/UnPackageSelect.svg',
              onTap: () {
                selectContainer(2);
              },
            ),
            const SizedBox(height: 8),
            const CustomLabelWidget(
              title: 'Package Details',
            ),
            const TextWithDot(text: 'Establishing a healthy lifestyle.'),
            const TextWithDot(
                text:
                    'Customized nutrition plan and exercise schedule based on your body type, available time and equipment.'),
            const TextWithDot(
                text:
                    'Daily response to your inquiries from our medical and sports team.'),
            const TextWithDot(text: 'Customized nutrition program every 14 days.'),
            const TextWithDot(
                text:
                    'Boost your physical fitness through monthly programs for (cardio, resistance).'),
            const TextWithDot(text: 'Improve your flexibility.'),
            const TextWithDot(text: 'Achieve your best body form.'),
            const TextWithDot(
                text: 'Monthly follow-up with statistics to modify plans.'),
            const SizedBox(height: 16),
            CustomButton(text: 'Proceed to Checkout', onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  CheckoutScreen(),
                ),
              );
            }),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

