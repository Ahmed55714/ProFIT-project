import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/colors.dart';
import '../../pages/Tabs/home/challenges/controller/challanges_controller.dart';
import '../../pages/Tabs/home/challenges/model/challanges.dart';
import '../General/animatedTextField/animated_textfield.dart';
import '../General/customBotton.dart';

class AddChallengeBottomSheet extends StatefulWidget {
  final Function(Challenge challenge) onChallengeAdded;
  const AddChallengeBottomSheet({Key? key, required this.onChallengeAdded}) : super(key: key);

  @override
  State<AddChallengeBottomSheet> createState() => _AddChallengeBottomSheetState();
}

class _AddChallengeBottomSheetState extends State<AddChallengeBottomSheet> {
  final ChallengeController _challengeController = Get.put(ChallengeController());
  File? _image;
  final TextEditingController _titleController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _image = File(image.path);
          print('Image selected: ${_image!.path}');
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  bool get _isFormValid => _titleController.text.isNotEmpty && _image != null;

  void addChallenge() async {
    if (_isFormValid) {
      await _challengeController.addChallenge(_titleController.text, _image!);
      if (_challengeController.successMessage.isNotEmpty) {
        widget.onChallengeAdded(Challenge(
          imagePath: _image!.path,
          title: _titleController.text,
        ));
        Navigator.pop(context);
      } else if (_challengeController.errorMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_challengeController.errorMessage.value)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields and select an image.")),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.55,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeaderWithCancel(
                title: "Challenge Details",
                onCancelPressed: () {
                  Navigator.pop(context);
                },
              ),
              GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: _image == null
                            ? SvgPicture.asset(
                                'assets/svgs/uploadImage1.svg',
                                width: 120,
                                height: 120,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  _image!,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: AnimatedTextField(
                  controller: _titleController,
                  label: 'Title',
                ),
              ),
              const SizedBox(height: 16),
              Obx(() {
                return CustomButton(
                  text: 'Add New Challenge',
                  onPressed: addChallenge,
                  isLoading: _challengeController.isLoading.value,
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

class CustomHeaderWithCancel extends StatelessWidget {
  final String title;
  final VoidCallback onCancelPressed;

  const CustomHeaderWithCancel({
    Key? key,
    required this.title,
    required this.onCancelPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            margin: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: grey600,
              borderRadius: BorderRadius.circular(5),
            ),
            width: 59,
            height: 5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    fontFamily: 'BoldCairo',
                    color: colorDarkBlue,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onCancelPressed,
                child: SvgPicture.asset('assets/svgs/close.svg'),
              ),
            ],
          ),
        ),
        const Divider(
          color: grey200,
          thickness: 1,
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
