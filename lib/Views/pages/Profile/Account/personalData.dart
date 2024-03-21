import 'package:flutter/material.dart';

import '../../../widgets/AppBar/custom_appbar.dart';
import '../../../widgets/General/customBotton.dart';
import '../../../widgets/General/custom_profile_textFeild.dart';

class PersonalDataScreen extends StatelessWidget {
  const PersonalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Account Data', isShowFavourite: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                children: [
                  SizedBox(height: 24),
                  MyInputTextField(
                    title: 'Gender',
                    focusNode: FocusNode(),
                    autoCorrect: false,
                  ),
                  MyInputTextField(
                    title: 'BirthDate',
                    focusNode: FocusNode(),
                    autoCorrect: false,
                  ),
                  MyInputTextField(
                    title: 'Weight',
                    focusNode: FocusNode(),
                    autoCorrect: false,
                  ),
                  MyInputTextField(
                    title: 'Height',
                    focusNode: FocusNode(),
                    autoCorrect: false,
                  ),
                  MyInputTextField(
                    title: 'Goal',
                    focusNode: FocusNode(),
                    autoCorrect: false,
                  ),
                  MyInputTextField(
                    title: 'Activity Level',
                    focusNode: FocusNode(),
                    autoCorrect: false,
                  ),
                  MyInputTextField(
                    title: 'Religion',
                    focusNode: FocusNode(),
                    autoCorrect: false,
                  ),
                  MyInputTextField(
                    title: 'Nationality',
                    focusNode: FocusNode(),
                    autoCorrect: false,
                  ),
                  SizedBox(height: 105),
                
                ],
              ),
            ),
              CustomButton(text: 'Update Data', onPressed: () {}),
              SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
