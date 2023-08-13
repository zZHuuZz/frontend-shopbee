// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shopbee/globals.dart';
import 'package:shopbee/widgets/CartScreens/CartWidget.dart';
import 'package:shopbee/widgets/CartScreens/UserLocationWidget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool userLocation = false;
  Map<String, dynamic> wishlistData = {};
  String? jwtToken;

  // Function to set the JWT token
  Future<void> _setToken(String token) async {
    await setToken(token);
    setState(() {
      jwtToken = token;
    });
    print(jwtToken.toString());
  }

  // Function to get the JWT token
  Future<void> _getToken() async {
    String? token = await getToken();
    setState(() {
      jwtToken = token;
    });
  }

  Future<Map<String, dynamic>> getCart() async {
    try {
      Response response = await get(
        Uri.parse(apiURL + 'api/v1/cart/view'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        wishlistData = responseBody;
        return responseBody;
      } else {
        print('failed cart');
      }
    } catch (e) {
      print(e.toString());
    }
    return wishlistData;
  }

  @override
  void initState() {
    _getToken().then((value) {
      getCart().then((result) {
        setState(() {
          wishlistData = result;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F9FF),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        backgroundColor: Color(0xFF33907C),
        title: Text(
          'My Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
          future: getCart(), // function where you call your api
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            // AsyncSnapshot<Your object type>
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            } else {
              if (snapshot.hasError)
                return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    color: Colors.white,
                    child: Center(child: Text('Error: ${snapshot.error}')));
              else if (snapshot.data!['data'] != null)
                return Column(
                  children: [
                    userLocation
                        ? UserLocationWidget()
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            height: 69,
                            child: InkWell(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '+ Add New Address',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, 'AddNewAddressPage');
                                setState(() {
                                  userLocation = true;
                                });
                              },
                            ),
                            color: Colors.white,
                          ),
                    SizedBox(height: 9),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            for (var cartShopData in snapshot.data?['data'])
                              CartWidget(cartData: cartShopData),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              else {
                return Container();
              }
            }
          }),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'PaymentOptionPage');
              },
              child: Container(
                height: 49,
                width: 84,
                decoration: BoxDecoration(
                  color: Color(0xFF33907C),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    "Continue to Payment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
