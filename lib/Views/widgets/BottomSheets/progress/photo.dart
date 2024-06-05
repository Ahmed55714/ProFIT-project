import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../services/api_service.dart';
import '../../../pages/Tabs/More/My Progress/Photo/controller/controller.dart';
import '../../General/animatedTextField/animated_textfield.dart';
import '../../General/customBotton.dart';
import '../add_challenge.dart';

class AddPhotoBottomSheet extends StatefulWidget {
  const AddPhotoBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddPhotoBottomSheet> createState() => _AddPhotoBottomSheetState();
}

class _AddPhotoBottomSheetState extends State<AddPhotoBottomSheet> {
  ApiService apiService = ApiService();
  File? _image;
  final TextEditingController _titleController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  double _initialChildSize = 0.5;
  bool _isLoading = false;

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

  bool get _isFormValid => _image != null;

  Future<void> _savePhoto() async {
    if (_isFormValid) {
      setState(() {
        _isLoading = true;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token != null) {
        bool success = await apiService.addPhoto(token, 'Title', _image!);

        setState(() {
          _isLoading = false;
        });

        if (success) {
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload photo')));
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No authentication token found')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select an image')));
    }
    final photoController = Get.put(PhotoController(ApiService()));
    photoController.fetchPhotos();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    if (bottomInset > 0 && _initialChildSize != 0.86) {
      setState(() {
        _initialChildSize = 0.86;
      });
    } else if (bottomInset == 0 && _initialChildSize != 0.5) {
      setState(() {
        _initialChildSize = 0.5;
      });
    }

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: _initialChildSize,
      builder: (BuildContext context, ScrollController scrollController) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
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
                        title: "Photo Details",
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
                      const SizedBox(height: 16),
                      CustomButton(
                        text: 'Save',
                        onPressed: _isLoading ? null : _savePhoto, // Disable button while loading
                        isLoading: _isLoading,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
