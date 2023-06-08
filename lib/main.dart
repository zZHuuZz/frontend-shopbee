import 'package:flutter/material.dart';
import 'pages/AddProductPage.dart';
import 'pages/EditProductPage.dart';
import 'pages/ForgotPasswordPage.dart';
import 'pages/HomePage.dart';
import 'pages/LoginPage.dart';
import 'pages/MyStorePage.dart';
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
        "/": (context) => HomePage(),
        //"/": (context) => LoginPage(),
        "SignUpPage": (context) => SignUpPage(),
        "ForgotPasswordPage": (context) => ForgotPasswordPage(),
        "TermsAndConditionsPage": (context) => TermsAndConditionsPage(),
        "HomePage": (context) => HomePage(),
        "MyStorePage": (context) => MyStorePage(),
        "AddProductPage": (context) => AddProductPage(),
        "EditProductPage": (context) => EditProductPage(),
      },
    );
  }
}
