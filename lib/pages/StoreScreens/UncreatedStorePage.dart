// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shopbee/globals.dart';
import 'package:http/http.dart';
import 'dart:convert';

class UncreatedStorePage extends StatefulWidget {
  @override
  State<UncreatedStorePage> createState() => _UncreatedStorePageState();
}

class _UncreatedStorePageState extends State<UncreatedStorePage> {
  String? jwtToken;
  Map<String, dynamic> profileData = {};
  int statusRequest = 200;
  bool isRequested = false;
  Future<Map<String, dynamic>> requestCreateStore() async {
    try {
      final response = await post(
        Uri.parse(apiURL + 'api/v1/user/upgrade'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        statusRequest = 200;
        print('Waiting accepted');
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        profileData = responseBody;
      } else {
        statusRequest = response.statusCode;
        print('Failed to request store');
      }
    } catch (e) {
      print(e.toString());
    }
    return profileData;
  }

  @override
  void initState() {
    _getToken().then((value) {
      requestCreateStore().then((result) {
        print(result);
        setState(() {
          profileData = result;
        });
      });
    });
    super.initState();
  }

  Future<void> _setToken(String token) async {
    await setToken(token);
    setState(() {
      jwtToken = token;
    });
  }

  // Function to get the JWT token
  Future<void> _getToken() async {
    String? token = await getToken();
    setState(() {
      jwtToken = token;
    });
  }

  int _selectedIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushNamed(context, 'HomePage');
      }
      if (index == 1) {
        Navigator.pushNamed(context, 'BrowsePage');
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
      backgroundColor: Color(0xFFF6F9FF),
      appBar: AppBar(
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
        title: Row(
          children: [
            Text(
              'My Store',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.favorite,
                size: 30,
              ),
              onPressed: () {
                //favorite shop button
              },
            ),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(
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
      body: Column(
        children: [
          SizedBox(height: 40),
          isRequested
              ? statusRequest == 200
                  ? Center(
                      child:
                          Text('Your request is being reviewed by our staff!',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                    )
                  : Center(
                      child:
                          Text('Your request is being reviewed by our staff!',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                    )
              : Text(''),
          SizedBox(height: 40),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "images/mystore.png",
            ),
          ),
          SizedBox(height: 30),
          Text(
            'You Don\'t Have a Store',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 40),
          InkWell(
            onTap: () {
              setState(() {
                requestCreateStore();
                isRequested = true;
              });
            },
            child: Container(
              height: 50,
              width: 210,
              decoration: BoxDecoration(
                color: Color(0xFF33907C),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  "Create store",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF33907C),
        items: <BottomNavigationBarItem>[
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
        selectedItemColor: Color(0xFF33907C),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
