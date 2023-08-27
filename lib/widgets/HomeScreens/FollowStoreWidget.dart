// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shopbee/pages/StoreProfileScreens/StoreProfilePage.dart';
import 'package:shopbee/globals.dart';
import 'dart:convert';
import 'package:http/http.dart';

class FollowStoreWidget extends StatefulWidget {
  final String name;
  final String id;
  final String url;
  const FollowStoreWidget(
      {super.key, required this.name, required this.id, required this.url});

  @override
  State<FollowStoreWidget> createState() => _FollowStoreWidgetState();
}

class _FollowStoreWidgetState extends State<FollowStoreWidget> {
  String? jwtToken;
  Map<String, dynamic> storeFollowers = {};
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
    _getToken().then((value) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromARGB(106, 158, 158, 158),
          width: 2,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Align(
              alignment: const Alignment(0, -1),
              child: FractionallySizedBox(
                heightFactor: .4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                  child: Container(
                    foregroundDecoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/followstore_devonly.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
              )),
          Align(
            alignment: const Alignment(-1, 1),
            child: FractionallySizedBox(
              heightFactor: .6,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: Column(
                    children: [
                      const SizedBox(height: 14),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 35),
                        child: Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                'StoreProfilePage',
                                arguments: StoreProfileData(
                                    widget.id, widget.name, widget.url),
                              );
                            },
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      FutureBuilder<bool>(
                          future: getFollowStatus(widget.id),
                          builder: (BuildContext context,
                              AsyncSnapshot<bool> snapshot) {
                            // AsyncSnapshot<Your object type>
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return InkWell(
                                child: Container(
                                  width: 87,
                                  height: 23,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color(0xFF33907C),
                                    ),
                                  ),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Loading...",
                                      style: TextStyle(
                                        color: Color(0xFF33907C),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              if (snapshot.hasError)
                                return InkWell(
                                  child: Container(
                                    width: 87,
                                    height: 23,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Color(0xFF33907C),
                                      ),
                                    ),
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Loading...",
                                        style: TextStyle(
                                          color: Color(0xFF33907C),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              else
                                return !snapshot.data!
                                    ? InkWell(
                                        onTap: () {
                                          followShop(widget.id).then((value) {
                                            setState(() {});
                                          });
                                        },
                                        child: Container(
                                          width: 87,
                                          height: 23,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            color: const Color(0xFF33907C),
                                          ),
                                          child: const Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Follow",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          unfollowShop(widget.id).then((value) {
                                            setState(() {});
                                          });
                                        },
                                        child: Container(
                                          width: 87,
                                          height: 23,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.red,
                                            ),
                                          ),
                                          child: const Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Unfollow",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                            }
                          }),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -0.25),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Color(0xFF33907C),
              foregroundColor: Colors.white,
              backgroundImage: NetworkImage(widget.url),
            ),
          ),
        ],
      ),
    );
  }
}
