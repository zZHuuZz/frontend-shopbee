// ignore_for_file: file_names, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({super.key});

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  String term = """
Terms and Conditions for Shopbee

1. Acceptance of Terms

By accessing and using Shopbee, you agree to comply with and be bound by these terms and conditions. If you do not agree with any of the terms, you are prohibited from using the app.

2. Use of the App

2.1. You must be of legal age and capable of forming a binding contract in your jurisdiction to use this app.

2.2. You are responsible for maintaining the confidentiality of your account credentials and are liable for any activities performed using your account.

3. Products and Services

3.1. Shopbee provides a platform to purchase products and services. We strive to provide accurate information about products, but we do not warrant their accuracy, completeness, or suitability for any purpose.

3.2. Prices, promotions, and availability are subject to change without notice.

4. Orders and Payments

4.1. Placing an order constitutes an offer to purchase. All orders are subject to acceptance by Shopbee.

4.2. Payment must be made in full at the time of placing the order. We accept various payment methods as specified on the app.

5. Shipping and Returns

5.1. Shipping and delivery terms are outlined in our Shipping Policy, which forms part of these terms and conditions.

5.2. Returns and refunds are subject to our Return Policy, available on the app.

6. User Content

6.1. You may submit content, including reviews and comments. By doing so, you grant Shopbee a non-exclusive, royalty-free, perpetual, and worldwide license to use, modify, and distribute your content.

6.2. You must not submit content that is illegal, obscene, defamatory, or infringing on intellectual property rights.

7. Intellectual Property

7.1. All content on Shopbee, including text, graphics, logos, and images, is protected by copyright and other intellectual property laws.

7.2. You are granted a limited, non-exclusive license to access and use the app for personal, non-commercial purposes.

8. Privacy

8.1. Your use of Shopbee is subject to our Privacy Policy, which outlines how we collect, use, and protect your personal information.

9. Termination

9.1. Shopbee reserves the right to terminate or suspend your account without notice if you violate these terms or engage in fraudulent activities.

10. Limitation of Liability

10.1. Shopbee is not liable for any direct, indirect, incidental, special, or consequential damages arising from the use or inability to use the app.

11. Governing Law

11.1. These terms and conditions are governed by and construed in accordance with the laws of [Your Jurisdiction].

12. Changes to Terms

12.1. Shopbee reserves the right to modify these terms at any time. Changes will be effective upon posting on the app.
""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Color(0xFF33907C),
        title: Text(
          'Terms & Conditions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 40,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(term),
      ),
    );
  }
}
