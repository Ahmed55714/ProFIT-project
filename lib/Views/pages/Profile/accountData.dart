import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profit1/Views/widgets/AppBar/custom_appbar.dart';
import 'package:profit1/Views/widgets/General/customBotton.dart';
import 'package:profit1/Views/widgets/General/customTextFeild.dart';

import '../../widgets/General/custom_profile_textFeild.dart';

class AccountData extends StatefulWidget {
  const AccountData({Key? key}) : super(key: key);

  @override
  State<AccountData> createState() => _AccountDataState();
}

class _AccountDataState extends State<AccountData> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Account Data', isShowFavourite: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical:16.0),
          child: Column(
            children: [
               
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: _image == null
                          ? Image.asset(
                              'assets/images/profilepic.png',
                              width: 100,
                              height: 100,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                _image!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    right: 130,
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
              SizedBox(height: 24),
           
                    MyInputTextField(
                      title: 'First Name',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                      isShowChange:true,
                      
                        ),
                    MyInputTextField(
                      title: 'Last Name',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                      isShowChange:true,
                        ),
                    MyInputTextField(
                      title: 'Email Address',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                      isShowChange:true,
                        ),
                        MyInputTextField(
                      title: 'Mobile Number',
                      focusNode: FocusNode(),
                      autoCorrect: false,
                      isShowChange:true,
                        ),
             
              
              SizedBox(height: 237),
              CustomButton(text: 'Save Change', onPressed: (){}),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
