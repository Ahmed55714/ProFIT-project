import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';


import '../../../utils/colors.dart';
import '../General/customBotton.dart';
import '../General/customTextFeild.dart';

class AddChallengeBottomSheet extends StatefulWidget {
  final Function(Challenge challenge) onChallengeAdded;
  const AddChallengeBottomSheet({Key? key, required this.onChallengeAdded})
      : super(key: key);
  @override
  State<AddChallengeBottomSheet> createState() =>
      _AddChallengeBottomSheetState();
}

class _AddChallengeBottomSheetState extends State<AddChallengeBottomSheet> {
  File? _image;
  final TextEditingController _titleController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  bool get _isFormValid => _titleController.text.isNotEmpty && _image != null;

  void addChallenge(Challenge challenge) {
    widget.onChallengeAdded(challenge);
  }

  void showAddChallengeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => AddChallengeBottomSheet(
        onChallengeAdded: (Challenge challenge) {
          Navigator.pop(context);
          addChallenge(challenge);
        },
      ),
    );
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
        
                Stack(
            children: [
             
              Padding(
                padding: const EdgeInsets.only( top: 10),
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
              Positioned(
                top: 8,
                right: 133,
                child: GestureDetector(
                  onTap: () {
                    _pickImage();
                  },
                  child: SvgPicture.asset(
                    'assets/svgs/editt.svg',
                  ),
                ),
              ),
            ],
          ),
                // Text Field for Title
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: CustomTextField(
                    labelText: 'title',
                    isShowColor: true,
                    controller: _titleController,
                  ),
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: 'Add New Challenge',
                  onPressed: () {
                    if (_isFormValid) {
                      final newChallenge = Challenge(
                          imagePath: _image!.path, title: _titleController.text);
        
                      widget.onChallengeAdded(newChallenge);
        
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Please fill in all fields and select an image.")));
                    }
                  },
                ),
                SizedBox(height: 16),
              ],
            ),
          
        );
      },
    );
  }
}

class Challenge {
  final String imagePath;
  final String title;

  Challenge({required this.imagePath, required this.title});
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
                  child: SvgPicture.asset('assets/svgs/close.svg')),
            ],
          ),
        ),
        const Divider(
          color: grey200,
          thickness: 1,
        ),
           SizedBox(height: 10.0),
      ],
    );
  }
}
