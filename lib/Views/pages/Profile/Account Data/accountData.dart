import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';
import 'package:profit1/Views/widgets/General/customTextFeild.dart';
import 'package:profit1/Views/widgets/General/custom_profile_textFeild.dart';
import 'Model/profile_controller.dart';
import 'Model/account_data.dart';
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

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      profileController.updateProfileImage(_image!);
    }
  }

  Future<void> fetchImage(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final dir = await getTemporaryDirectory();
    _image = File('${dir.path}/profile.jpg');
    await _image!.writeAsBytes(bytes);
    setState(() {});
  }

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final profileController = Get.find<ProfileController>();
    profileController.fetchUserProfile().then((_) {
      if (profileController.profile.value?.profilePhoto != null) {
        fetchImage(profileController.profile.value!.profilePhoto);
      }
    });
    fetchAndSetUserProfile();
  }

  void fetchAndSetUserProfile() {
    profileController.fetchUserProfile().then((_) {
      if (profileController.profile.value != null) {
        print("Mobile Number: ${profileController.profile.value!.phoneNumber}");
        setState(() {
          firstNameController.text = profileController.profile.value!.firstName;
          lastNameController.text = profileController.profile.value!.lastName;
          emailController.text = profileController.profile.value!.email;
          mobileNumberController.text =
              profileController.profile.value!.phoneNumber;
        });
      }
    });
  }

  // @override
  // void dispose() {
  //   firstNameController.dispose();
  //   lastNameController.dispose();
  //   emailController.dispose();
  //   mobileNumberController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var profileImageUrl = profileController.profile.value?.profilePhoto ?? '';

    return Scaffold(
      appBar: CustomAppBar(titleText: 'Account Data', isShowFavourite: true),
      body: Obx(() {
        var profile = profileController.profile.value;
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
                      child: Center(
                        child: profileController.profile.value?.profilePhoto !=
                                null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: _image != null
                                    ? Image.file(
                                        _image!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                    : (profileController
                                                .profile.value?.profilePhoto !=
                                            null
                                        ? Image.network(
                                            profileController
                                                .profile.value!.profilePhoto,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                  'assets/images/profilepic.png',
                                                  width: 100,
                                                  height:
                                                      100); // Fallback image
                                            },
                                          )
                                        : Image.asset(
                                            'assets/images/profilepic.png',
                                            width: 100,
                                            height: 100)),
                              )
                            : Image.asset('assets/images/profilepic.png',
                                width: 100, height: 100),
                      ),
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
                ),
                MyInputTextField(
                  title: 'Last Name',
                  textEditingController: lastNameController,
                  focusNode: FocusNode(),
                  autoCorrect: false,
                ),
                MyInputTextField(
                  title: 'Email Address',
                  textEditingController: emailController,
                  focusNode: FocusNode(),
                  autoCorrect: false,
                ),
                MyInputTextField(
                  title: 'Mobile Number',
                  textEditingController: mobileNumberController,
                  focusNode: FocusNode(),
                  autoCorrect: false,
                ),
                SizedBox(height: 237),
                CustomButton(
                  text: 'Save Change',
                  onPressed: () async {
                    String firstName = firstNameController.text.trim();
                    String lastName = lastNameController.text.trim();
                    String email = emailController.text.trim();
                    String phoneNumber = mobileNumberController.text.trim();

                    await profileController.saveProfileChanges(
                        _image, firstName, lastName, email, phoneNumber);
                  },
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        );
      }),
    );
  }
}
