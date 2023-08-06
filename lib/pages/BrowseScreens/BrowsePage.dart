// ignore_for_file: sized_box_for_whitespace, sort_child_properties_last, deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopbee/widgets/BrowseScreens/BrowseItemsWidget.dart';
import 'package:shopbee/globals.dart';
import 'dart:convert';
import 'package:http/http.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  final searchController = TextEditingController();
  Map<String, dynamic> productData = {};
  Map<String, dynamic> profileData = {};
  late int selectedPage;
  String? jwtToken;
  bool switchable = false;

  Future<Map<String, dynamic>> getProfile() async {
    try {
      Response response = await get(
        Uri.parse(apiURL + 'api/v1/user/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        profileData = responseBody;
        return responseBody;
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
    return profileData;
  }

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

  @override
  void initState() {
    _getToken().then((value) {
      getProfile().then((result) {
        setState(() {
          profileData = result;
          switchable = true;
        });
      });
    });
    searchController
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  Future<Map<String, dynamic>> getProduct() async {
    try {
      Response response = await get(
        Uri.parse(apiURL + 'api/v1/product/list'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        productData = responseBody;
        return responseBody;
      } else {
        print('failed product');
      }
    } catch (e) {
      print(e.toString());
    }
    return productData;
  }

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (switchable)
      setState(() {
        _selectedIndex = index;
        if (index == 0) {
          Navigator.pushNamed(context, 'HomePage');
        }
        if (index == 2) {
          if (profileData['data']['role'] == 'buyer')
            Navigator.pushNamed(context, 'UncreatedStorePage');
          else {
            Navigator.pushNamed(context, 'MyStorePage');
          }
        }
        if (index == 3) {
          Navigator.pushNamed(context, 'OrderHistoryPage');
        }
        if (index == 4) {
          Navigator.pushNamed(context, 'ProfilePage');
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
        elevation: 0,
        backgroundColor: const Color(0xFF33907C),
        title: Column(
          children: [
            Row(
              children: [
                const Text(
                  'ShopBee',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    size: 30,
                  ),
                  onPressed: () {
                    //favorite shop button
                  },
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                  onPressed: () {
                    //navigate to cart button
                  },
                ),
              ],
            ),
            const SizedBox(height: 23),
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: TextFormField(
                autofocus: false,
                keyboardType: TextInputType.text,
                controller: searchController,
                style: const TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF13B58C),
                  ),
                  hintText: "Search Product",
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: 56,
              color: const Color(0xFF33907C),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 112,
                    height: 31,
                    child: Row(
                      children: [
                        Container(
                          width: 112,
                          height: 31,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.sortAmountDown,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Sort by",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.transparent,
                              border: Border.all(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 112,
                    height: 31,
                    child: Row(
                      children: [
                        Container(
                          width: 112,
                          height: 31,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.mapMarkerAlt,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Location",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.transparent,
                              border: Border.all(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 112,
                    height: 31,
                    child: Row(
                      children: [
                        Container(
                          width: 112,
                          height: 31,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.listSquares,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Catagory",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.transparent,
                              border: Border.all(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            BrowseItemsWidget(searchKey: searchController.text),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF33907C),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subject),
            label: 'Order History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF33907C),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
