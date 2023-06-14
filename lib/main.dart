import 'package:flutter/material.dart';

//store screens
import 'pages/StoreScreens/AddProductPage.dart';
import 'pages/StoreScreens/CreateStorePage.dart';
import 'pages/StoreScreens/EditProductPage.dart';
import 'pages/StoreScreens/EditStorePage.dart';
import 'pages/StoreScreens/EmptyStorePage.dart';
import 'pages/StoreScreens/UncreatedStorePage.dart';

//login screens
import 'pages/LoginScreens/EmailVerificationPage.dart';
import 'pages/LoginScreens/LoginPage.dart';
import 'pages/LoginScreens/SignUpPage.dart';
import 'pages/LoginScreens/TermsAndConditionsPage.dart';

//home screens
import 'pages/HomeScreens/HomePage.dart';

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
        //login screens
        "/": (context) => LoginPage(),
        "SignUpPage": (context) => SignUpPage(),
        "EmailVerificationPage": (context) => EmailVerificationPage(),
        "TermsAndConditionsPage": (context) => TermsAndConditionsPage(),

        //home screens
        "HomePage": (context) => HomePage(),

        //store screens
        "UncreatedStorePage": (context) => UncreatedStorePage(),
        "CreateStorePage": (context) => CreateStorePage(),
        "EditStorePage": (context) => EditStorePage(),
        "EmptyStorePage": (context) => EmptyStorePage(),
        "AddProductPage": (context) => AddProductPage(),
        "EditProductPage": (context) => EditProductPage(),
      },
    );
  }
}
