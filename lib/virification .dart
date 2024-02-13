// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:profit/utils/colors.dart';

// import '../../widgets/customBotton.dart';
// import '../../widgets/custom_back_button.dart';
// import '../../widgets/custom_image_forgot.dart';

// class VerificationScreen extends StatelessWidget {
//   const VerificationScreen({required this.email, super.key});
//   final String email;
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 BackBlueButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//                 TitleWidget(
//                   text: "Verification",
//                   secondText:
//                       "Enter the 4-digits code we’ve sent to ", email: email,
//                 ),
//                 const SizedBox(height: 24),
//                 const CustomImageWidget(
//                     imagePath: 'assets/images/3dicons(1).png'),
//                 const SizedBox(height: 8),
//                 const Center(
//                   child: Text(
//                     "Request code again in 00:56",
//                     style: TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w400,
//                       color: RoyalBlue,
//                     ),
//                   ),
//                 ),
//                 const VerificationCode(),
//                 const SizedBox(height: 135),
//                 const Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Don’t received link? ",
//                         style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w400,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       Text(
//                         "Resend",
//                         style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w400,
//                           color: RoyalBlue,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Center(
//                   child: CustomButton(
//                     text: 'Verify Account',
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/confirm');
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TitleWidget extends StatelessWidget {
//   final String text;
//   final String secondText;
//   final String email;


//   const TitleWidget({Key? key, required this.email,required this.text, required this.secondText})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           text,
//           style: const TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           "$secondText\n $email",
//           style: const TextStyle(
//             fontSize: 14,
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class VerificationCode extends StatelessWidget {
//   const VerificationCode({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: List.generate(
//           4,
//           (index) => const SizedBox(
//             height: 68,
//             width: 64,
//             child: VerificationCodeForm(),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class VerificationCodeForm extends StatelessWidget {
//   const VerificationCodeForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       onChanged: (value) {
//         if (value.length == 1) {
//           FocusScope.of(context).nextFocus();
//         }
//       },
//       keyboardType: TextInputType.number,
//       textAlign: TextAlign.center,
//       inputFormatters: [
//         LengthLimitingTextInputFormatter(1),
//         FilteringTextInputFormatter.digitsOnly,
//       ],
//       decoration: InputDecoration(
//         hintStyle: const TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//           color: RoyalBlue,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(width: 2, color: RoyalBlue),
//         ),
//       ),
//     );
//   }
// }
