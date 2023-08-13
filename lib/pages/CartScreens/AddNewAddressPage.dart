// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shopbee/globals.dart';

class AddNewAddressPage extends StatefulWidget {
  const AddNewAddressPage({super.key});

  @override
  State<AddNewAddressPage> createState() => _AddNewAddressPageState();
}

class _AddNewAddressPageState extends State<AddNewAddressPage> {
  TextEditingController addressController = TextEditingController();
  String? jwtToken;
  Map<String, dynamic> profileData = {};
  String userName = "";
  String phone = "";

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
        print(responseBody);
        userName = profileData['data']['fullname'];
        phone = profileData['data']['phone'];
        addressController.text = profileData['data']['addr'];
        return responseBody;
      } else {
        print('failed profile');
      }
    } catch (e) {
      print(e.toString());
    }
    return profileData;
  }

  Future<Map<String, dynamic>> updateAddress(String id, String addr) async {
    Map<String, dynamic> requestBody = {
      "addr": addr,
    };

    try {
      Response response = await patch(
        Uri.parse(apiURL + 'api/v1/user/update/${id}'),
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        profileData = responseBody;
        print(responseBody);
        return responseBody;
      } else {
        print(response.body);
        print('failed update');
      }
    } catch (e) {
      print(e.toString());
    }
    return profileData;
  }

  void initState() {
    _getToken().then((value) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: getProfile(), // function where you call your api
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          // AsyncSnapshot<Your object type>
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(height: 64);
          } else {
            if (snapshot.hasError)
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  color: Colors.white,
                  child: Center(child: Text('Error: ${snapshot.error}')));
            else
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
                    'Add address',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                body: Column(
                  children: [
                    SizedBox(height: 9),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(color: Colors.grey),
                              )),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    userName,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                    ),
                                  )),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Phone',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(color: Colors.grey),
                              )),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  phone == ""
                                      ? "Please add phone number in profile!"
                                      : phone,
                                  style: phone == ""
                                      ? TextStyle(
                                          fontSize: 20,
                                          color: Colors.red,
                                        )
                                      : TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Street Address',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: addressController,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 9)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: BottomAppBar(
                  color: Colors.white,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: InkWell(
                        onTap: () {
                          updateAddress(
                            snapshot.data!['data']['id'],
                            addressController.text,
                          ).then(
                            (value) {
                              Navigator.pop(context);
                            },
                          );
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
                              "Save",
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
        });
  }
}
