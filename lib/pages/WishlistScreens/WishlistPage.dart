// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shopbee/globals.dart';

import '../ProductDetailScreens/ProductDetailPage.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  Map<String, dynamic> wishlistData = {};
  String? jwtToken;

  Future<Map<String, dynamic>> getWishlist() async {
    try {
      Response response = await get(
        Uri.parse(apiURL + 'api/v1/wishlist/view'),
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
        print('failed wishlist');
      }
    } catch (e) {
      print(e.toString());
    }
    return wishlistData;
  }

  Future<Map<String, dynamic>> getProduct(String productID) async {
    try {
      Response response = await get(
        Uri.parse(apiURL + 'api/v1/product/view/${productID}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        wishlistData = responseBody;
        return responseBody;
      } else {
        print('failed wishlist product');
      }
    } catch (e) {
      print(e.toString());
    }
    return wishlistData;
  }

  void removeFromWishlist(String productID) async {
    try {
      Response response = await post(
        Uri.parse(apiURL + 'api/v1/wishlist/removeproduct/${productID}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        print(responseBody);
        setState(() {});
      } else {
        print('failed to add');
      }
    } catch (e) {
      print(e.toString());
    }
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
      getWishlist().then((result) {
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
          'Wishlist',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
          future: getWishlist(), // function where you call your api
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
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
                  child: GridView.count(
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 12.25,
                    childAspectRatio: 0.82,
                    primary: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: [
                      for (var productData in snapshot.data!['data'])
                        FutureBuilder<Map<String, dynamic>>(
                            future: getProduct(
                                productData), // function where you call your api
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
                                      height: 300,
                                      color: Colors.white,
                                      child: Center(
                                          child: Text(
                                              'Error: ${snapshot.error}')));
                                else if (!snapshot.data?['data'].isEmpty)
                                  return Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                106, 158, 158, 158),
                                            width: 2,
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              'ProductDetailPage',
                                              arguments: ProductData(
                                                productData,
                                              ),
                                            );
                                          },
                                          child: Stack(
                                            clipBehavior: Clip.antiAlias,
                                            children: [
                                              Align(
                                                  alignment:
                                                      const Alignment(0, -1),
                                                  child: FractionallySizedBox(
                                                    heightFactor: .65,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topRight:
                                                            Radius.circular(12),
                                                        topLeft:
                                                            Radius.circular(12),
                                                      ),
                                                      child: Container(
                                                        foregroundDecoration:
                                                            BoxDecoration(
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  snapshot.data?[
                                                                              'data']
                                                                          [
                                                                          'image']
                                                                      ['url']),
                                                              fit: BoxFit.fill),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                              Align(
                                                alignment:
                                                    const Alignment(-1, 1),
                                                child: FractionallySizedBox(
                                                  heightFactor: .35,
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomRight:
                                                            Radius.circular(12),
                                                        bottomLeft:
                                                            Radius.circular(12),
                                                      ),
                                                    ),
                                                    child: FractionallySizedBox(
                                                      widthFactor: 1,
                                                      child: Column(
                                                        children: [
                                                          SizedBox(height: 4),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        12),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                snapshot.data?[
                                                                        'data']
                                                                    ['name'],
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 12,
                                                                    right: 12,
                                                                    bottom: 4),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    snapshot.data!['data']['price']
                                                                            .toString() +
                                                                        ' đ',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Color(
                                                                          0xFF33907C),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 12,
                                                                    right: 12,
                                                                    bottom: 1),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    radius: 10,
                                                                    backgroundColor:
                                                                        Color(
                                                                            0xFF33907C),
                                                                    foregroundColor:
                                                                        Colors
                                                                            .white,
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            "http://d1851nciml9u0m.cloudfront.net/user/default-1691832193326062897.png"),
                                                                  ),
                                                                  SizedBox(
                                                                      width: 6),
                                                                  Flexible(
                                                                    child: Text(
                                                                      snapshot.data?['data']
                                                                              [
                                                                              'shop']
                                                                          [
                                                                          'fullname'],
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Transform.translate(
                                          offset: Offset(10, -10),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                removeFromWishlist(productData);
                                              });
                                            },
                                            child: CircleAvatar(
                                              backgroundColor: Colors.black45,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                else
                                  return Container();
                              }
                            }),
                    ],
                  ),
                );
              else
                return Container();
            }
          }),
    );
  }
}
