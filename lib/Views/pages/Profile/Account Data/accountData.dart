import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';
import 'package:profit1/Views/widgets/General/customTextFeild.dart';
import '../../../widgets/General/custom_profile_textFeild.dart';
import 'controller/profile_controller.dart';
import 'package:http/http.dart' as http;

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
  List<bool> hasChanged =
      List.filled(4, false); // Initialize with false for each field

  // Text controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();

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
          mobileNumberController.text =
              profileController.profile.value!.phoneNumber;
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
    mobileNumberController
        .addListener(() => checkChange(3, mobileNumberController));
  }

  void checkChange(int index, TextEditingController controller) {
    String newValue = controller.text.trim();
    bool hasChangedFlag = false;

    switch (index) {
      case 0: // Assuming this is for the first name
        hasChangedFlag =
            (newValue != profileController.profile.value?.firstName);
        break;
      case 1: // Assuming this is for the last name
        hasChangedFlag =
            (newValue != profileController.profile.value?.lastName);
        break;
      case 2: // Assuming this is for the email
        hasChangedFlag = (newValue != profileController.profile.value?.email);
        break;
      case 3: // Assuming this is for the mobile number
        hasChangedFlag =
            (newValue != profileController.profile.value?.phoneNumber);
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
    setState(() {
      isSaving = true;
    });

    try {
      await profileController.saveProfileChanges(
          _image,
          firstNameController.text.trim(),
          lastNameController.text.trim(),
          emailController.text.trim(),
          mobileNumberController.text.trim());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Account Data', isShowFavourite: true),
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                MyInputTextField(
                    title: 'First Name',
                    textEditingController: firstNameController,
                    focusNode: FocusNode(),
                    autoCorrect: false,
                    isShowChange: hasChanged[0]),
                MyInputTextField(
                    title: 'Last Name',
                    textEditingController: lastNameController,
                    focusNode: FocusNode(),
                    autoCorrect: false,
                    isShowChange: hasChanged[1]),
                MyInputTextField(
                    title: 'Email Address',
                    textEditingController: emailController,
                    focusNode: FocusNode(),
                    autoCorrect: false,
                    isShowChange: hasChanged[2]),
                MyInputTextField(
                    title: 'Mobile Number',
                    textEditingController: mobileNumberController,
                    focusNode: FocusNode(),
                    autoCorrect: false,
                    isShowChange: hasChanged[3]),
                SizedBox(height: 237),
                CustomButton(
                    text: 'Save Change',
                    isLoading: isSaving,
                    onPressed: isSaving ? null : saveProfile),
                SizedBox(height: 16),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget buildProfileImage() {
    if (_image != null) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child:
              Image.file(_image!, width: 100, height: 100, fit: BoxFit.cover));
    } else if (profileController.profile.value?.profilePhoto != null) {
      return Image.network(profileController.profile.value!.profilePhoto,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.asset(
              'assets/images/profilepic.png',
              width: 100,
              height: 100));
    } else {
      return Image.asset('assets/images/profilepic.png',
          width: 100, height: 100);
    }
  }
}
