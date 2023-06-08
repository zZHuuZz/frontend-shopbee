import 'package:flutter/material.dart';
import 'package:shopbee/pages/MainPage.dart';
import 'pages/AddProductPage.dart';
import 'pages/ForgotPasswordPage.dart';
import 'pages/LoginPage.dart';
import 'pages/SignUpPage.dart';
import 'pages/TermsAndConditionsPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
      ),
      routes: {
        "/": (context) => LoginPage(),
        "SignUpPage": (context) => SignUpPage(),
        "ForgotPasswordPage": (context) => ForgotPasswordPage(),
        "TermsAndConditionsPage": (context) => TermsAndConditionsPage(),
        "MainPage": (context) => MainPage(),
        "AddProductPage": (context) => AddProductPage(),
      },
    );
  }
}
