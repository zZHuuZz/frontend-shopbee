import 'package:flutter/material.dart';

//browse screens
import 'package:shopbee/pages/BrowseScreens/BrowsePage.dart';

//category screens
import 'package:shopbee/pages/CategoryScreens/CategoryPage.dart';

//order history screens
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

//cart screens
import 'pages/CartScreens/CartPage.dart';
import 'package:shopbee/pages/CartScreens/AddNewAddressPage.dart';
import 'package:shopbee/pages/CartScreens/PaymentOptionPage.dart';
import 'package:shopbee/pages/CartScreens/AddCardPage.dart';

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
        '/': (context) => const HomePage(),
        //login screens
        //"/": (context) => const LoginPage(),
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

        //cart screens
        "CartPage": (context) => const CartPage(),
        "AddNewAddressPage": (context) => const AddNewAddressPage(),
        'PaymentOptionPage': (context) => const PaymentOptionPage(),
        'AddCardPage': (context) => const AddCardPage(),

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
