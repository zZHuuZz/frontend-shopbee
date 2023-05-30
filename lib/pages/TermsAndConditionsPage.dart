import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatefulWidget {
  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditionsPage> {


  @override
  Widget build(BuildContext context) {
    final String termsAndConditionsContent = '''
    1. Introduction

    Welcome to our e-commerce application! These terms and conditions govern your use of our services, so please read them carefully before proceeding.

    2. Acceptance of Terms

    By using our application, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms, please do not use our services.

    3. Intellectual Property

    All content provided in this application, including but not limited to text, graphics, logos, images, and software, is the property of our company and is protected by applicable intellectual property laws.

    4. Use of Services

    You may use our services for personal and non-commercial purposes only. You must not use the application for any illegal or unauthorized activities.

    5. Privacy Policy

    Our privacy policy explains how we collect, use, and protect your personal information. By using our services, you agree to our privacy policy.

    6. Product Information

    We strive to provide accurate and up-to-date information about our products. However, we do not warrant the accuracy, completeness, or reliability of any product descriptions or other content in the application.

    7. Pricing and Payments

    The prices of products displayed in the application are subject to change without notice. We reserve the right to modify or cancel any order if the price is incorrect. Payments for orders placed through the application are processed securely.

    8. User Accounts

    To access certain features of the application, you may need to create a user account. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.

    9. Limitation of Liability

    We are not liable for any direct, indirect, incidental, or consequential damages arising out of your use or inability to use our services, including but not limited to loss of profits, data, or goodwill.

    10. Changes to Terms and Conditions

    We reserve the right to modify these terms and conditions at any time without prior notice. Please review these terms periodically for any updates or changes.

    If you have any questions or concerns about these terms and conditions, please contact us.

    ''';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF44E49E),
        title: Text('Terms and Conditions'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Terms and conditions",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              termsAndConditionsContent,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
