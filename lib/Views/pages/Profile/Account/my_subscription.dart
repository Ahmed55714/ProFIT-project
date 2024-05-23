import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profit1/utils/colors.dart';
import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/BottomSheets/add_challenge.dart';
import '../../../widgets/Explore/Trainer Details/Packages/text_dot.dart';
import '../../../widgets/General/custom_loder.dart';
import '../../../widgets/General/customBotton.dart';
import '../../Explore/Package/check_out.dart';
import '../../Explore/Package/controller/subscription_details.dart';
import '../profile Screen/profile_screen.dart';

class MySubscriptionScreen extends StatelessWidget {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CheckoutController checkoutController = Get.find<CheckoutController>();

    return Scaffold(
      backgroundColor: grey50,
      appBar: CustomAppBar(
        titleText: 'My Subscription',
        isShowFavourite: true,
      ),
      body: Obx(
        () {
          if (checkoutController.isLoading.value) {
            return  Center(child: CustomLoder(color: colorBlue, size: 35));
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  const CustomLabelWidget(
                    title: 'Current Subscription',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: grey200),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Image.network(
                                            checkoutController
                                                .subscriptionDetails.value
                                                .profilePhoto,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              checkoutController
                                                  .subscriptionDetails
                                                  .value
                                                  .trainerName,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19,
                                                color: colorDarkBlue,
                                                fontFamily: 'Cairo',
                                              ),
                                            ),
                                            DurationWidget(
                                              label: 'Subscription Type',
                                              duration: '${checkoutController.subscriptionDetails.value.subscriptionType}',
                                            ),
                                             DurationWidget(
                                              label: 'Paid Amount',
                                              duration: '${checkoutController.subscriptionDetails.value.price} EGP',
                                            ),
                                            DurationWidget(
                                              label: 'Start at :',
                                              duration:
                                                  ' ${checkoutController.subscriptionDetails.value.startDate}',
                                            ),
                                            DurationWidget(
                                              label: 'End at :',
                                              duration: ' ${checkoutController.subscriptionDetails.value.endDate}',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  ActionButton(
                                      text: 'Review Trainer',
                                      svg: 'assets/svgs/star-111.svg',
                                      onPressed: () {}),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const CustomLabelWidget(
                    title: 'Payment Method',
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: grey200),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: SizedBox(
                                          width: 32,
                                          height: 32,
                                          child: Image.asset(
                                            'assets/images/VISA.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      const Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Credit Card',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                color: colorDarkBlue,
                                              ),
                                            ),
                                            Text(
                                              '****5890',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11,
                                                color: colorDarkBlue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      const CustomBadge(
                                        text: 'Active',
                                        backgroundColor: green100,
                                        textColor: green600,
                                      ),
                                      const SizedBox(width: 16),
                                      SvgPicture.asset(
                                        'assets/svgs/chevron-small-left.svg',
                                        color: grey500,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const CustomLabelWidget(
                    title: 'Benefits of you current subscription',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: grey200),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child:  const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWithDot(
                                    text:
                                        'Smart Fitness Plan Customized to your level',
                                    isSvg: true,
                                  ),
                                  TextWithDot(
                                    text:
                                        'Meals Plans with Quantities and Alternativesl',
                                    isSvg: true,
                                  ),
                                  TextWithDot(
                                    text: 'Demo Videos for every workout',
                                    isSvg: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: grey200),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: SvgPicture.asset(
                                          'assets/svgs/alert.svg',
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      const Text(
                                        'Cancellation terms and conditions',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          color: DArkBlue900,
                                        ),
                                      ),
                                      const Spacer(),
                                      const SizedBox(width: 16),
                                      SvgPicture.asset(
                                        'assets/svgs/bottomArrow.svg',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 89),
                  CustomButton(
                    text: 'Cancel Subscription',
                    onPressed: () {
                      _showCancelSubscriptionConfirmation(context);
                    },
                    Subscription: true,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _showCancelSubscriptionConfirmation(BuildContext context) {
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
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.5,
          ),
          child: Column(
            children: <Widget>[
              CustomHeaderWithCancel(
                title: 'Cancel Subscription?',
                onCancelPressed: () => Navigator.pop(context),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Text(
                      'Active subscription will be canceled and cannot be refunded',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: DArkBlue900,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'To be eligible for a full refund, you must cancel your subscription before any customized program has been sent by your trainer. The ability to cancel your subscription will be disabled once the first program is received.',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: DArkBlue900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              CustomButton(text: 'Yes', onPressed: () {}, isShowDifferent: true),
              const SizedBox(height: 8),
              CustomButton(text: 'No', onPressed: () {}),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
