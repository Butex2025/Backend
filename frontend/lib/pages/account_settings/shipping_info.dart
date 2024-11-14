import 'package:flutter/material.dart';

class ShippingInfo extends StatelessWidget {
  const ShippingInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // final double screenWidth = MediaQuery.of(context).size.width;
    // final double paddingHorizontal = screenWidth * 0.04;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pushNamed(context, '/account_settings'),
        ),
        title: Text("Shippinh information"),
        centerTitle: true,
      )
    );
  }
}