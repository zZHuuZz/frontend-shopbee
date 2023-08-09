// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shopbee/widgets/StoreScreens/MyStoreEditWidget.dart';
import 'package:shopbee/widgets/StoreScreens/MyStoreEmptyWidget.dart';
import 'package:shopbee/widgets/StoreScreens/MyStoreViewWidget.dart';
import 'package:shopbee/globals.dart';
import 'dart:convert';
import 'package:http/http.dart';

class MyStorePage extends StatefulWidget {
  @override
  State<MyStorePage> createState() => _MyStorePageState();
}

class _MyStorePageState extends State<MyStorePage> {
  String? jwtToken;
  Map<String, dynamic> profileData = {};
  Map<String, dynamic> myProductData = {};
  bool edit = false;
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
        print('failed profile');
      }
    } catch (e) {
      print(e.toString());
    }
    return profileData;
  }

  Future<Map<String, dynamic>> getMyProduct() async {
    try {
      Response response = await get(
        Uri.parse(apiURL +
            'api/v1/product/list?shop_id=${profileData['data']['id']}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        myProductData = responseBody;
        return responseBody;
      } else {
        print(response.body);
        print('failed product');
      }
    } catch (e) {
      print(e.toString());
    }
    return myProductData;
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
          switchable = true;
          profileData = result;
        });
      });
    });
    print(myProductData);
    super.initState();
  }

  int _selectedIndex = 2;
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
                Navigator.pushNamed(context, 'WishlistPage');
              },
            ),
            SizedBox(width: 10),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'CartPage');
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
          future: getProfile(),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            // AsyncSnapshot<Your object type>
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 210,
                color: Colors.grey,
              );
            } else {
              if (snapshot.hasError)
                return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 210,
                    color: Colors.white,
                    child: Center(child: Text('Error: ${snapshot.error}')));
              else
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.height,
                        height: 210,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Color(0xFF33907C),
                              foregroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                  profileData['data']['avatar']['url']),
                            ),
                            SizedBox(height: 16),
                            Text(
                              profileData['data']['fullname'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    color:
                                        edit ? Color(0xFF33907C) : Colors.white,
                                    border: Border.all(
                                      color: Color(0xFF33907C),
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        edit = true;
                                      });
                                    },
                                    child: Center(
                                      child: Text(
                                        "Edit Store",
                                        style: TextStyle(
                                          color: edit
                                              ? Colors.white
                                              : Color(0xFF33907C),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 17),
                                Container(
                                  height: 25,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    color:
                                        edit ? Colors.white : Color(0xFF33907C),
                                    border: Border.all(
                                      color: Color(0xFF33907C),
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        edit = false;
                                      });
                                    },
                                    child: Center(
                                      child: Text(
                                        "View Store",
                                        style: TextStyle(
                                          color: edit
                                              ? Color(0xFF33907C)
                                              : Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 27,
                            ),
                          ],
                        ),
                      ),
                      FutureBuilder<Map<String, dynamic>>(
                          future: getMyProduct(),
                          builder: (BuildContext context,
                              AsyncSnapshot<Map<String, dynamic>> snapshot) {
                            // AsyncSnapshot<Your object type>
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container();
                            } else {
                              if (snapshot.hasError)
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 200,
                                    color: Colors.grey,
                                    child: Center(
                                        child:
                                            Text('Error: ${snapshot.error}')));
                              else if (!snapshot.data?['data'].isEmpty)
                                return edit
                                    ? MyStoreEditWidget(
                                        profileData: profileData,
                                      )
                                    : MyStoreViewWidget(
                                        profileData: profileData,
                                      );
                              else
                                return MyStoreEmptyWidget();
                            }
                          }),
                    ],
                  ),
                );
            }
          }),
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
