// ignore_for_file: unnecessary_import, file_names

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shopbee/globals.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shopbee/widgets/CartScreens/ViewOrderWidget.dart';

class ViewOrderPage extends StatefulWidget {
  const ViewOrderPage({super.key});

  @override
  State<ViewOrderPage> createState() => _ViewOrderPageState();
}

class _ViewOrderPageState extends State<ViewOrderPage> {
  String? jwtToken;
  Map<String, dynamic> profileData = {};
  bool switchable = false;
  Map<String, dynamic> orderData = {};

  Future<Map<String, dynamic>> getViewOrderList() async {
    try {
      Response response = await get(
        Uri.parse(apiURL + 'api/v1/order/shop/list'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        orderData = responseBody;
        return responseBody;
      } else {
        print(jsonDecode(response.body));
        print('failed view order list');
      }
    } catch (e) {
      print(e.toString());
    }
    return orderData;
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
    super.initState();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        backgroundColor: Color(0xFF33907C),
        title: Text(
          'View Order',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 40,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
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
                    "My Shop Order",
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
            FutureBuilder<Map<String, dynamic>>(
                future: getViewOrderList(), // function where you call your api
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  // AsyncSnapshot<Your object type>
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 78,
                      color: Colors.grey,
                    );
                  } else {
                    if (snapshot.hasError)
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 78,
                          color: Colors.white,
                          child:
                              Center(child: Text('Error: ${snapshot.error}')));
                    else if (snapshot.data?['data'] != null)
                      return Column(
                        children: [
                          for (var order in snapshot.data?['data'])
                            ViewOrderWidget(
                              orderData: order,
                            ),
                        ],
                      );
                    else {
                      return Container();
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }
}
