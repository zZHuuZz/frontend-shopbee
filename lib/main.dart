import 'package:flutter/material.dart';
import 'package:shopbee/pages/OrderHistoryScreens/OrderHistoryPage.dart';

//store screens
import 'pages/ProfileScreens/ProfilePage.dart';
import 'pages/StoreScreens/AddProductPage.dart';
import 'pages/StoreScreens/CreateStorePage.dart';
import 'pages/StoreScreens/EditProductPage.dart';
import 'pages/StoreScreens/EditStorePage.dart';
import 'pages/StoreScreens/MyStorePage.dart';
import 'pages/StoreScreens/UncreatedStorePage.dart';

//login screens
import 'pages/LoginScreens/EmailVerificationPage.dart';
import 'pages/LoginScreens/LoginPage.dart';
import 'pages/LoginScreens/SignUpPage.dart';
import 'pages/LoginScreens/ForgotPasswordPage.dart';

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
        "/": (context) => ProfilePage(),

        //login screens
        //"/": (context) => LoginPage(),
        "SignUpPage": (context) => SignUpPage(),
        "EmailVerificationPage": (context) => EmailVerificationPage(),
        "ForgotPasswordPage": (context) => ForgotPasswordPage(),

        //home screens
        "HomePage": (context) => HomePage(),

        //store screens
        "UncreatedStorePage": (context) => UncreatedStorePage(),
        "CreateStorePage": (context) => CreateStorePage(),
        "EditStorePage": (context) => EditStorePage(),
        "MyStorePage": (context) => MyStorePage(),
        "AddProductPage": (context) => AddProductPage(),
        "EditProductPage": (context) => EditProductPage(),

        //order history screens
        "OrderHistoryPage": (context) => OrderHistoryPage(),

        //profile screens
        "ProfilePage": (context) => ProfilePage(),
      },
    );
  }
}
