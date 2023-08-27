import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shopbee/globals.dart';

class ProductDetailFollowStoreWidget extends StatefulWidget {
  final String id;
  const ProductDetailFollowStoreWidget({super.key, required this.id});
  @override
  State<ProductDetailFollowStoreWidget> createState() =>
      _ProductDetailFollowStoreWidgetState();
}

class _ProductDetailFollowStoreWidgetState
    extends State<ProductDetailFollowStoreWidget> {
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
    return FutureBuilder<bool>(
        future: getFollowStatus(widget.id),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          // AsyncSnapshot<Your object type>
          if (snapshot.connectionState == ConnectionState.waiting) {
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
                          borderRadius: BorderRadius.circular(14),
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
                          borderRadius: BorderRadius.circular(14),
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
        });
  }
}
