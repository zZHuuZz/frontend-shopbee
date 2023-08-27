// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:shopbee/globals.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shopbee/widgets/StoreProfileScreens/StoreProfileWidget.dart';

class StoreProfileData {
  final String id;
  final String name;
  final String url;

  StoreProfileData(this.id, this.name, this.url);
}

class StoreProfilePage extends StatefulWidget {
  const StoreProfilePage({super.key});
  @override
  State<StoreProfilePage> createState() => _StoreProfilePageState();
}

class _StoreProfilePageState extends State<StoreProfilePage> {
  String? jwtToken;
  Map<String, dynamic> storeProfileData = {};
  Map<String, dynamic> storeProfileProductData = {};
  Map<String, dynamic> storeFollowers = {};

  @override
  void initState() {
    _getToken().then((value) {});
    super.initState();
  }

  Future<Map<String, dynamic>> getFollower(String id) async {
    try {
      Response response = await get(
        Uri.parse(apiURL + 'api/v1/user/like/${id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        storeFollowers = responseBody;
        print(responseBody);
        return responseBody;
      } else {
        print(jsonDecode(response.body));
        print('failed followers');
      }
    } catch (e) {
      print(e.toString());
    }
    return storeFollowers;
  }

  Future<bool> getFollowStatus(String id) async {
    try {
      Response response = await get(
        Uri.parse(apiURL + 'api/v1/user/likestatus/${id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        return true;
      } else {
        print(jsonDecode(response.body));
        print('failed check follow');
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<Map<String, dynamic>> followShop(String id) async {
    try {
      Response response = await post(
        Uri.parse(apiURL + 'api/v1/user/like/${id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        storeFollowers = responseBody;
        print(responseBody);
        return responseBody;
      } else {
        print(jsonDecode(response.body));
        print('failed to follow shop');
      }
    } catch (e) {
      print(e.toString());
    }
    return storeFollowers;
  }

  Future<Map<String, dynamic>> unfollowShop(String id) async {
    try {
      Response response = await post(
        Uri.parse(apiURL + 'api/v1/user/dislike/${id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        storeFollowers = responseBody;
        print(responseBody);
        return responseBody;
      } else {
        print(jsonDecode(response.body));
        print('failed disfllow shop');
      }
    } catch (e) {
      print(e.toString());
    }
    return storeFollowers;
  }

  Future<Map<String, dynamic>> getStoreProfile(String id) async {
    try {
      Response response = await get(
        Uri.parse(apiURL + 'api/v1/product/list?shop_id=${id}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        storeProfileData = responseBody;
        return responseBody;
      } else {
        print(response.body);
        print('failed product');
      }
    } catch (e) {
      print(e.toString());
    }
    return storeProfileData;
  }

  Future<Map<String, dynamic>> getStoreProfileProduct(String id) async {
    try {
      Response response = await get(
        Uri.parse(apiURL + 'api/v1/product/list?shop_id=${id}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        storeProfileProductData = responseBody;
        return responseBody;
      } else {
        print(response.body);
        print('failed product');
      }
    } catch (e) {
      print(e.toString());
    }
    return storeProfileProductData;
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
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as StoreProfileData;
    return FutureBuilder<Map<String, dynamic>>(
        future: getStoreProfile(data.id), // function where you call your api
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          // AsyncSnapshot<Your object type>
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 268,
              color: Colors.grey,
            );
          } else {
            if (snapshot.hasError)
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  color: Colors.white,
                  child: Center(child: Text('Error: ${snapshot.error}')));
            else if (!snapshot.data?['data'].isEmpty)
              return Scaffold(
                backgroundColor: Color(0xFFF6F9FF),
                appBar: AppBar(
                  elevation: 0,
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
                    data.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            color: Color(0xFF33907C),
                          ),
                          Container(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 180,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 46, top: 22),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Color(0xFF33907C),
                                          radius: 24,
                                          backgroundImage:
                                              NetworkImage(data.url),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          data.name,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                        Spacer(),
                                        FutureBuilder<bool>(
                                            future: getFollowStatus(data.id),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<bool> snapshot) {
                                              // AsyncSnapshot<Your object type>
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 39),
                                                  child: InkWell(
                                                    child: Container(
                                                      width: 87,
                                                      height: 23,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14),
                                                        color: Colors.white,
                                                        border: Border.all(
                                                          color:
                                                              Color(0xFF33907C),
                                                        ),
                                                      ),
                                                      child: const Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "Loading...",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF33907C),
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                if (snapshot.hasError)
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 39),
                                                    child: InkWell(
                                                      child: Container(
                                                        width: 87,
                                                        height: 23,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(14),
                                                          color: Colors.white,
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFF33907C),
                                                          ),
                                                        ),
                                                        child: const Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "Loading...",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF33907C),
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                else
                                                  return !snapshot.data!
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 39),
                                                          child: InkWell(
                                                            onTap: () {
                                                              followShop(
                                                                      data.id)
                                                                  .then(
                                                                      (value) {
                                                                setState(() {});
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 87,
                                                              height: 23,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            14),
                                                                color: const Color(
                                                                    0xFF33907C),
                                                              ),
                                                              child:
                                                                  const Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "Follow",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 39),
                                                          child: InkWell(
                                                            onTap: () {
                                                              unfollowShop(
                                                                      data.id)
                                                                  .then(
                                                                      (value) {
                                                                setState(() {});
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 87,
                                                              height: 23,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            14),
                                                                color: Colors
                                                                    .white,
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                              child:
                                                                  const Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "Unfollow",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                              }
                                            }),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Total Followers',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                            FutureBuilder<Map<String, dynamic>>(
                                                future: getFollower(data.id),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<
                                                            Map<String,
                                                                dynamic>>
                                                        snapshot) {
                                                  // AsyncSnapshot<Your object type>
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Text(
                                                      '?',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black),
                                                    );
                                                  } else {
                                                    if (snapshot.hasError)
                                                      return Text(
                                                        '?',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      );
                                                    else
                                                      return Text(
                                                        snapshot.data!['like']
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      );
                                                  }
                                                }),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Total Product',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                            FutureBuilder<Map<String, dynamic>>(
                                                future: getStoreProfileProduct(
                                                    data.id),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<
                                                            Map<String,
                                                                dynamic>>
                                                        snapshot) {
                                                  // AsyncSnapshot<Your object type>
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Text(
                                                      '?',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.black),
                                                    );
                                                  } else {
                                                    if (snapshot.hasError)
                                                      return Text(
                                                        '?',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      );
                                                    else if (!snapshot
                                                        .data?['data'].isEmpty)
                                                      return Text(
                                                        snapshot.data!['data']
                                                            .length
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      );
                                                    else {
                                                      return Text(
                                                        '?',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      );
                                                    }
                                                  }
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      StoreProfileWidget(id: data.id),
                    ],
                  ),
                ),
              );
            else
              return Scaffold(
                  backgroundColor: Color(0xFFF6F9FF),
                  appBar: AppBar(
                    elevation: 0,
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
                      data.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  body: Container());
          }
        });
  }
}
