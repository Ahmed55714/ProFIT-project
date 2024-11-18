import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';
import 'package:profit1/Views/widgets/General/customTextFeild.dart';
import 'package:profit1/Views/widgets/General/custom_loder.dart';

import '../../../../utils/colors.dart';
import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/Checkout/checkout.dart';
import '../../../widgets/Explore/Trainers/trainer_continer.dart';
import '../../Tabs/BottomNavigationBar/BottomNavigationBar.dart';
import 'controller/subscription_details.dart';

class CheckoutScreen extends StatelessWidget {
  final String packageId;

  CheckoutScreen({
    Key? key,
    required this.packageId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CheckoutController checkoutController = Get.find<CheckoutController>();

    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'Checkout',
        showContainer: true,
      ),
      body: Obx(() {
        if (checkoutController.isLoading.value) {
          return Center(
            child: CustomLoder(
              color: colorBlue,
              size: 35,
            ),
          );
        }

        if (checkoutController.subscriptionDetails.value.trainerName.isEmpty) {
          return const Center(child: Text("No subscription details found."));
        }

        final details = checkoutController.subscriptionDetails.value;

        return SingleChildScrollView(
          child: Column(
            children: [
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
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: SizedBox(
                                      width: 75,
                                      height: 75,
                                      child: Image.network(
                                        details.profilePhoto,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          details.trainerName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 19,
                                            color: colorDarkBlue,
                                          ),
                                        ),
                                        DurationWidget(
                                          label: 'Subscription Type',
                                          duration: details.subscriptionType,
                                        ),
                                        DurationWidget(
                                          label: 'Duration',
                                          duration: details.duration,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  StartAtWidget(
                                    label: 'Start at :',
                                    value: details.startDate,
                                  ),
                                  const Spacer(),
                                  StartAtWidget(
                                    label: 'End at : ',
                                    value: details.endDate,
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
              const SizedBox(height: 263),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: CustomTextField(
                  labelText: 'Enter Coupon Code',
                  fieldHeight: 44,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset('assets/svgs/offer.svg'),
                  ),
                  isShowButton: true,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: grey200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                         Row(
                          children: [
                            const ExperienceWidget(
                              isShowSvg: false,
                              text: 'Sub-Total',
                              color: grey400,
                              text2: '',
                            ),
                            const Spacer(),
                            ExperienceWidget(
                              isShowSvg: false,
                              text: details.price == 0 ? 'Free' : '${details.price} ',
                              color: DArkBlue900,
                              text2: 'EGP',
                              isFit: true,
                            ),
                          ],
                        ),
                         Row(
                          children: [
                            const ExperienceWidget(
                              isShowSvg: false,
                              text: 'VAT',
                              color: grey400,
                              text2: '',
                            ),
                            const Spacer(),
                            ExperienceWidget(
                              isShowSvg: false,
                              text: details.price == 0 ? 'Free' : '${details.price} ',
                              color: DArkBlue900,
                              text2: 'EGP',
                              isFit: true,
                            ),
                          ],
                        ),
                        const Divider(color: grey200, thickness: 1),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Amount',
                              style: TextStyle(
                                color: grey500,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            PriceWidget(
                              isPay: true,
                              priceText: details.price == 0 ? 'Free' : '${details.price} EGP',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CustomButton(
                text: 'Pay Now',
                onPressed: () async {
                  if (!checkoutController.isLoading.value) {
                    bool paymentSuccess = await checkoutController.submitPayment(packageId);
                    if (paymentSuccess) {
                      Get.to(() => BottomNavigation(role: 'Home', selectedIndex: 0));
                    } else {
                      Get.snackbar('Payment Failed', 'Please try again.');
                    }
                  }
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      }),
    );
  }
}
