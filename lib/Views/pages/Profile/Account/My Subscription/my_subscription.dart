import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/pages/Profile/profile%20Screen/profile_screen.dart';
import 'package:profit1/Views/widgets/Checkout/checkout.dart';
import 'package:profit1/utils/colors.dart';
import '../../../../widgets/AppBar/custom_appbar.dart';
import '../../../../widgets/BottomSheets/add_challenge.dart';
import '../../../../widgets/Explore/Trainer Details/Packages/text_dot.dart';
import '../../../../widgets/General/custom_loder.dart';
import '../../../../widgets/General/customBotton.dart';
import '../../../Explore/Package/check_out.dart';
import '../../../Explore/Package/controller/subscription_details.dart';

class MySubscriptionScreen extends StatelessWidget {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CheckoutController checkoutController =
        Get.find<CheckoutController>();

    return Scaffold(
      backgroundColor: grey50,
      appBar: CustomAppBar(
        titleText: 'My Subscription',
        isShowFavourite: true,
      ),
      body: Obx(
        () {
          if (checkoutController.isLoading.value) {
            return Center(
              child: CustomLoder(color: colorBlue, size: 35),
            );
          } else if (checkoutController
                  .subscriptionDetails.value.trainerName.isEmpty ||
              checkoutController
                  .subscriptionDetails.value.profilePhoto.isEmpty) {
            return Center(
              child: Text(
                'You are not subscribed to any trainer',
                style: TextStyle(
                  color: colorDarkBlue,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'cairo',
                ),
              ),
            );
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
                                                .subscriptionDetails
                                                .value
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
                                              duration:
                                                  '${checkoutController.subscriptionDetails.value.subscriptionType}',
                                            ),
                                            DurationWidget(
                                              label: 'Paid Amount',
                                              duration:
                                                  '${checkoutController.subscriptionDetails.value.price} EGP',
                                            ),
                                            DurationWidget(
                                              label: 'Start at :',
                                              duration:
                                                  ' ${checkoutController.subscriptionDetails.value.startDate}',
                                            ),
                                            DurationWidget(
                                              label: 'End at :',
                                              duration:
                                                  ' ${checkoutController.subscriptionDetails.value.endDate}',
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
                                    onPressed: () {
                                      _showBottomSheet(
                                          context, checkoutController,
                                          isReview: true);
                                    },
                                  ),
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
                    title: 'Benefits of your current subscription',
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
                            child: const Padding(
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
                                        'Meals Plans with Quantities and Alternatives',
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
                  Obx(
                    () => CustomButton(
                      text: checkoutController.isSubscriptionCancelled.value
                          ? 'Subscription'
                          : 'Cancel Subscription',
                      onPressed:
                          checkoutController.isSubscriptionCancelled.value
                              ? null
                              : () {
                                  _showBottomSheet(context, checkoutController,
                                      isReview: false);
                                },
                      subscription:
                          checkoutController.isSubscriptionCancelled.value
                              ? false
                              : true,
                    ),
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

// Bottom Sheet
  void _showBottomSheet(
      BuildContext context, CheckoutController checkoutController,
      {required bool isReview}) {
    final TextEditingController _reviewCommentController =
        TextEditingController();
    final FocusNode _focusNode = FocusNode();
    final _selectedRating = 4.obs;
    final _initialChildSize = 0.55.obs;

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _initialChildSize.value = 0.87;
      } else {
        _initialChildSize.value = 0.55;
      }
    });

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
        return Obx(() => DraggableScrollableSheet(
              initialChildSize: _initialChildSize.value,
              minChildSize: 0.3,
              maxChildSize: 0.9,
              expand: false,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: grey50,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: <Widget>[
                        CustomHeaderWithCancel(
                          title: isReview
                              ? 'Rate Trainer'
                              : 'Cancel Subscription?',
                          onCancelPressed: () => Navigator.pop(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              if (isReview)
                                Column(
                                  children: [
                                    SvgPicture.asset('assets/svgs/review.svg'),
                                    const SizedBox(height: 16),
                                    const Row(
                                      children: [
                                        Text(
                                          'How do you rate the trainer?',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: DArkBlue900,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Obx(() => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(5, (index) {
                                            return GestureDetector(
                                              onTap: () {
                                                _selectedRating.value =
                                                    index + 1;
                                              },
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/svgs/Starr.svg',
                                                    color: index <
                                                            _selectedRating
                                                                .value
                                                        ? Colors.green
                                                        : grey200,
                                                    width: 40,
                                                    height: 40,
                                                  ),
                                                  if (index < 4)
                                                    const SizedBox(width: 16),
                                                ],
                                              ),
                                            );
                                          }),
                                        )),
                                    const SizedBox(height: 16),
                                    TextField(
                                      controller: _reviewCommentController,
                                      focusNode: _focusNode,
                                      decoration: InputDecoration(
                                        hintText:
                                            'Tell us more, write your comment here',
                                        hintStyle: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          fontFamily: 'Cairo',
                                          color: reviewColor,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: reviewColor),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.all(16),
                                      ),
                                      maxLines: 2,
                                    ),
                                    const SizedBox(height: 16),
                                    CustomButton(
                                      text: 'Send',
                                      onPressed: () {
                                        checkoutController.submitReview(
                                          checkoutController.subscriptionDetails
                                              .value.trainerId,
                                          _selectedRating.value,
                                          _reviewCommentController.text,
                                        );
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              if (!isReview)
                                Column(
                                  children: [
                                    const Column(
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
                                    const SizedBox(height: 60),
                                    CustomButton(
                                      text: 'Yes',
                                      onPressed: () async {
                                        await checkoutController
                                            .cancelSubscription();
                                        Get.back();
                                      },
                                      isShowDifferent: true,
                                    ),
                                    const SizedBox(height: 8),
                                    CustomButton(
                                      text: 'No',
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ));
      },
    );
  }
}
