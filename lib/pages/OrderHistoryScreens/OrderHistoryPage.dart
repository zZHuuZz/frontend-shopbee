// ignore_for_file: unnecessary_import, file_names

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shopbee/widgets/OrderHistoryScreens/OrderWidget.dart';
import 'package:shopbee/globals.dart';
import 'dart:convert';
import 'package:http/http.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  String? jwtToken;
  Map<String, dynamic> profileData = {};
  int _selectedIndex = 3;
  bool switchable = false;

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
    super.initState();
  }

  Future<Map<String, dynamic>> getProfile() async {
    try {
      Response response = await get(
        Uri.parse('http://shopbee-api.shop:3055/api/v1/user/profile'),
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
        print('failed profile');
      }
    } catch (e) {
      print(e.toString());
    }
    return profileData;
  }

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

  void _onItemTapped(int index) {
    if (switchable)
      setState(() {
        _selectedIndex = index;
        if (index == 0) {
          Navigator.pushNamed(context, 'HomePage');
        }
        if (index == 1) {
          Navigator.pushNamed(context, 'BrowsePage');
        }
        if (index == 2) {
          if (profileData['data']['role'] == 'buyer')
            Navigator.pushNamed(context, 'UncreatedStorePage');
          else {
            Navigator.pushNamed(context, 'MyStorePage');
          }
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
        toolbarHeight: 100,
        backgroundColor: const Color(0xFF33907C),
        title: Row(
          children: [
            const Text(
              'Order History',
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
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 9),
                  child: Text(
                    "Transactions",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                Container(
                  width: 107,
                  height: 26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color.fromARGB(20, 51, 144, 124),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "January 2022",
                      style: TextStyle(
                          color: Color(0xFF33907C),
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Column(
              children: [
                for (int i = 0; i < 15; i++) const OrderWidget(),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF33907C),
        // ignore: prefer_const_literals_to_create_immutables
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Browse',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.subject),
            label: 'Order History',
          ),
          const BottomNavigationBarItem(
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
