import 'package:flutter/material.dart';

import '../../../widgets/AppBar/custom_appbar.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBar(
        titleText: 'Checkout',
        showContainer: true,
      ), 
      body: Center(
        child: Text('Checkout'),
      ),
    );
  }
}