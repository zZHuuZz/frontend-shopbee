import 'package:flutter/material.dart';

//browse screens
import 'pages/BrowseScreens/BrowsePage.dart';

//category screens
import 'pages/CategoryScreens/CategoryPage.dart';

//order history screens
import 'pages/OrderHistoryScreens/OrderHistoryPage.dart';

//profile screens
import 'pages/ProfileScreens/ProfilePage.dart';
import 'pages/ProfileScreens/EditProfilePage.dart';

//store screens
import 'pages/StoreScreens/AddProductPage.dart';
import 'pages/StoreScreens/EditProductPage.dart';
import 'pages/StoreScreens/MyStorePage.dart';
import 'pages/StoreScreens/UncreatedStorePage.dart';

//login screens
import 'pages/LoginScreens/LoginPage.dart';
import 'pages/LoginScreens/SignUpPage.dart';
import 'pages/LoginScreens/ForgotPasswordPage.dart';

//home screens
import 'pages/HomeScreens/HomePage.dart';

//cart screens
import 'pages/CartScreens/CartPage.dart';
import 'pages/CartScreens/AddNewAddressPage.dart';
import 'pages/CartScreens/PaymentOptionPage.dart';
import 'pages/CartScreens/AddCardPage.dart';

//wishlist screens
import 'pages/WishlistScreens/WishlistPage.dart';

//product detail screens
import 'pages/ProductDetailScreens/ProductDetailPage.dart';

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
        "ForgotPasswordPage": (context) => const ForgotPasswordPage(),

        //home screens
        "HomePage": (context) => const HomePage(),

        //browse screens
        "BrowsePage": (context) => const BrowsePage(),

        //store screens
        "UncreatedStorePage": (context) => UncreatedStorePage(),
        "MyStorePage": (context) => MyStorePage(),
        "AddProductPage": (context) => const AddProductPage(),
        "EditProductPage": (context) => const EditProductPage(),

        //cart screens
        "CartPage": (context) => const CartPage(),
        "AddNewAddressPage": (context) => const AddNewAddressPage(),
        'PaymentOptionPage': (context) => const PaymentOptionPage(),
        'AddCardPage': (context) => const AddCardPage(),

        //wishlist screens
        "WishlistPage": (context) => WishlistPage(),

        //order history screens
        "OrderHistoryPage": (context) => const OrderHistoryPage(),

        //profile screens
        "ProfilePage": (context) => ProfilePage(),
        "EditProfilePage": (context) => const EditProfilePage(),

        //category screens
        "CategoryPage": (context) => const CategoryPage(),

        //product detail screens
        "ProductDetailPage": (context) => const ProductDetailPage(),
      },
    );
  }
}
