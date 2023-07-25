import 'package:flutter/material.dart';
import 'package:shopbee/pages/BrowseScreens/BrowsePage.dart';
import 'package:shopbee/pages/CategoryScreens/CategoryPage.dart';
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

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
      ),
      routes: {
        //login screens
        "/": (context) => const LoginPage(),
        "SignUpPage": (context) => const SignUpPage(),
        "EmailVerificationPage": (context) => const EmailVerificationPage(),
        "ForgotPasswordPage": (context) => const ForgotPasswordPage(),

        //home screens
        "HomePage": (context) => const HomePage(),

        //browse screens
        "BrowsePage": (context) => const BrowsePage(),

        //store screens
        "UncreatedStorePage": (context) => UncreatedStorePage(),
        "CreateStorePage": (context) => const CreateStorePage(),
        "EditStorePage": (context) => EditStorePage(),
        "MyStorePage": (context) => MyStorePage(),
        "AddProductPage": (context) => const AddProductPage(),
        "EditProductPage": (context) => const EditProductPage(),

        //order history screens
        "OrderHistoryPage": (context) => const OrderHistoryPage(),

        //profile screens
        "ProfilePage": (context) => ProfilePage(),

        //category screens
        "CategoryPage": (context) => const CategoryPage(),
      },
    );
  }
}
