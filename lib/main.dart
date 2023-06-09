import 'package:flutter/material.dart';
import 'pages/StoreScreens/AddProductPage.dart';
import 'pages/StoreScreens/CreateStorePage.dart';
import 'pages/StoreScreens/EditProductPage.dart';
import 'pages/LoginScreens/ForgotPasswordPage.dart';
import 'pages/HomeScreens/HomePage.dart';
import 'pages/LoginScreens/LoginPage.dart';
import 'pages/StoreScreens/MyStorePage.dart';
import 'pages/LoginScreens/SignUpPage.dart';
import 'pages/LoginScreens/TermsAndConditionsPage.dart';

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
        "/": (context) => MyStorePage(),
        //"/": (context) => LoginPage(),
        "SignUpPage": (context) => SignUpPage(),
        "ForgotPasswordPage": (context) => ForgotPasswordPage(),
        "TermsAndConditionsPage": (context) => TermsAndConditionsPage(),
        "HomePage": (context) => HomePage(),
        "MyStorePage": (context) => MyStorePage(),
        "CreateStorePage": (context) => CreateStorePage(),
        "AddProductPage": (context) => AddProductPage(),
        "EditProductPage": (context) => EditProductPage(),
      },
    );
  }
}
