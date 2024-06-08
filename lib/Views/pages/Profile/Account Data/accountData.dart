import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import 'package:profit1/Views/widgets/General/customTextFeild.dart';
import 'package:profit1/utils/colors.dart';
import '../../../widgets/General/animatedTextField/animated_textfield.dart';
import '../../../widgets/General/customBotton.dart';
import '../../../widgets/General/custom_profile_textFeild.dart';
import 'controller/profile_controller.dart';
import 'dart:io';

class AccountData extends StatefulWidget {
  const AccountData({Key? key}) : super(key: key);

  @override
  State<AccountData> createState() => _AccountDataState();
}

class _AccountDataState extends State<AccountData> {
  final ImagePicker _picker = ImagePicker();
  final ProfileController profileController = Get.find<ProfileController>();
  File? _image;
  bool isSaving = false;
  List<bool> hasChanged = List.filled(4, false);

  // Text controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();

  String? emailError;

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  void fetchInitialData() {
    final profileController = Get.find<ProfileController>();
    profileController.fetchUserProfile().then((_) {
      if (profileController.profile.value != null) {
        setState(() {
          firstNameController.text = profileController.profile.value!.firstName;
          lastNameController.text = profileController.profile.value!.lastName;
          emailController.text = profileController.profile.value!.email;
          mobileNumberController.text = profileController.profile.value!.phoneNumber;
          hasChanged = [false, false, false, false];
        });
        setupListeners();
      }
    });
  }

  void setupListeners() {
    firstNameController.addListener(() => checkChange(0, firstNameController));
    lastNameController.addListener(() => checkChange(1, lastNameController));
    emailController.addListener(() => checkChange(2, emailController));
    mobileNumberController.addListener(() => checkChange(3, mobileNumberController));
  }

  void checkChange(int index, TextEditingController controller) {
    String newValue = controller.text.trim();
    bool hasChangedFlag = false;

    switch (index) {
      case 0: // Assuming this is for the first name
        hasChangedFlag = (newValue != profileController.profile.value?.firstName);
        break;
      case 1:
        hasChangedFlag = (newValue != profileController.profile.value?.lastName);
        break;
      case 2:
        hasChangedFlag = (newValue != profileController.profile.value?.email);
        break;
      case 3:
        hasChangedFlag = (newValue != profileController.profile.value?.phoneNumber);
        break;
    }

    if (hasChangedFlag && !hasChanged[index]) {
      setState(() {
        hasChanged[index] = true;
      });
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      profileController.updateProfileImage(_image!);
    }
  }

  void saveProfile() async {
    if (!validateEmail(emailController.text.trim())) {
      setState(() {
        emailError = 'Please enter a valid email address';
      });
      return;
    }

    setState(() {
      isSaving = true;
      emailError = null;
    });

    try {
      await profileController.saveProfileChanges(
        _image,
        firstNameController.text.trim(),
        lastNameController.text.trim(),
        emailController.text.trim(),
        mobileNumberController.text.trim(),
      );
    } catch (e) {
      print("Error saving profile: $e");
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey50,
      appBar: CustomAppBar(titleText: 'Account Data', isShowFavourite: true),
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        if (profileController.isLoading.value) {
          return buildSkeletonLoader();
        }

        return Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Center(child: buildProfileImage()),
                        ),
                        Positioned(
                          right: 130,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: SvgPicture.asset('assets/svgs/editt.svg'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    AnimatedTextField(
                      label: 'First Name',
                      controller: firstNameController,
                    ),
                    AnimatedTextField(
                      label: 'Last Name',
                      controller: lastNameController,
                    ),
                    AnimatedTextField(
                      label: 'Email Address',
                      controller: emailController,
                      onChanged: (value) {
                        if (emailError != null) {
                          setState(() {
                            emailError = null;
                          });
                        }
                      },
                    ),
                    if (emailError != null)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          left: 10,
                          bottom: 8,
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/images/alert.png', width: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                emailError ?? '',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 13,
                                  fontFamily: 'Arial',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    AnimatedTextField(
                      label: 'Mobile Number',
                      controller: mobileNumberController,
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: CustomButton(
                    text: 'Save Change',
                    isLoading: isSaving,
                    onPressed: isSaving ? null : saveProfile,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget buildProfileImage() {
    if (_image != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(_image!, width: 100, height: 100, fit: BoxFit.cover),
      );
    } else if (profileController.profile.value?.profilePhoto != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          profileController.profile.value!.profilePhoto,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/profilepic.png',
              width: 100,
              height: 100,
            ),
          ),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          'assets/images/profilepic.png',
          width: 100,
          height: 100,
        ),
      );
    }
  }

  Widget buildSkeletonLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              margin: EdgeInsets.only(bottom: 24),
            ),
            Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              margin: EdgeInsets.only(bottom: 16),
            ),
            Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              margin: EdgeInsets.only(bottom: 16),
            ),
            Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              margin: EdgeInsets.only(bottom: 16),
            ),
            Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              margin: EdgeInsets.only(bottom: 40),
            ),
          ],
        ),
      ),
    );
  }
}
