import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/pages/ai/main_screen.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';

import '../../../../../utils/colors.dart';
import '../../../../main.dart';
import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/More/Achievements.dart';
import '../../More/achievements.dart';
import 'my_progress.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'ProFIT HUB',
        showContainer: true,
        isShowNormal: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.to(const MyProgress());
                  },
                  child: const AchievementsWidget(
                    text: 'My Progress',
                    svgAsset: 'assets/svgs/Activity.svg',
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Achievements(),
                      ),
                    );
                  },
                  child: const AchievementsWidget(
                    text: 'My Achievements',
                    svgAsset: 'assets/svgs/Medal gold.svg',
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(cameras),
                      ),
                    );
                  },
                  child: const AchievementsWidget(
                    text: 'My AI',
                    svgAsset: 'assets/svgs/ai.svg',
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(cameras),
                      ),
                    );
                  },
                  child: const AchievementsWidget(
                    text: 'My Subscription',
                    svgAsset: 'assets/svgs/trainert.svg',
                  ),
                ),
              ),
            ],
          ),
          const CustomLabelWidget(
            title: 'Benefits',
          ),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {
              showSuccessDialog(context);
            },
            child: Image.asset(
              'assets/images/pon.png',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {
              showSuccessDialog(context);
            },
            child: Image.asset(
              'assets/images/pon.png',
            ),
          ),
        ],
      ),
    );
  }
}

class CouponCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Coupon Code',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          'CAP290920',
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}

class CustomBadge extends StatelessWidget {
  final String text;

  const CustomBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14.0,
        color: Colors.green,
      ),
    );
  }
}

class ReferenceRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text(
          'Reference',
          style: TextStyle(fontSize: 14.0, color: Colors.grey),
        ),
        Text(
          'Gift Card',
          style: TextStyle(fontSize: 14.0, color: Colors.blue[900]),
        ),
      ],
    );
  }
}

class DateRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text(
          'Date',
          style: TextStyle(fontSize: 14.0, color: Colors.grey),
        ),
        Text(
          '02/02/2024',
          style: TextStyle(fontSize: 14.0, color: Colors.blue[900]),
        ),
      ],
    );
  }
}

class AmountRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text(
          'Amount',
          style: TextStyle(fontSize: 14.0, color: Colors.grey),
        ),
        Text(
          '50 EGP',
          style: TextStyle(fontSize: 14.0, color: Colors.blue[900]),
        ),
      ],
    );
  }
}

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CouponCode(),
            const SizedBox(height: 8.0),
            const CustomBadge(
              text: 'Redeemed Successfully',
            ),
            const SizedBox(height: 16.0),
            ReferenceRow(),
            const SizedBox(height: 4.0),
            DateRow(),
            const SizedBox(height: 4.0),
            AmountRow(),
          ],
        ),
      ),
    );
  }
}

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => SuccessDialog(),
  );
}
