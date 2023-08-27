import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shopbee/globals.dart';
import 'package:shopbee/widgets/ProductDetailWidget.dart/ProductDetailFollowStoreWidget.dart';

class ProductDetailWidget extends StatefulWidget {
  final String id;
  const ProductDetailWidget({super.key, required this.id});
  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  String? jwtToken;
  Map<String, dynamic> productData = {};
  Future<Map<String, dynamic>> getProductDetail() async {
    try {
      Response response = await get(
        Uri.parse(apiURL + 'api/v1/product/view/${widget.id}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        productData = responseBody;
        print(responseBody);
        return responseBody;
      } else {
        print(jsonDecode(response.body));
        print('failed product details');
      }
    } catch (e) {
      print(e.toString());
    }
    return productData;
  }

  void addToWishlist(String productID) async {
    try {
      Response response = await post(
        Uri.parse(apiURL + 'api/v1/wishlist/addproduct/${productID}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        print(responseBody);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Success"),
            content: const Text("Product added in whishlist"),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      } else {
        print('failed to add wishlist');

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: const Text("Product already in whishlist"),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
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
    return FutureBuilder<Map<String, dynamic>>(
        future: getProductDetail(), // function where you call your api
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          // AsyncSnapshot<Your object type>
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            if (snapshot.hasError)
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 165,
                  color: Colors.white,
                  child: Center(child: Text('Error: ${snapshot.error}')));
            else
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      height: 326,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              snapshot.data?['data']['image']['url'],
                            ),
                            fit: BoxFit.fill),
                        color: const Color.fromARGB(65, 0, 0, 0),
                      ),
                    ),
                    Container(
                      height: 95,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 5, left: 16, right: 16),
                                    child: Text(
                                      snapshot.data?['data']['name'],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: IconButton(
                                  icon: Icon(Icons.favorite_border,
                                      color: Colors.pink, size: 30),
                                  onPressed: () => {addToWishlist(widget.id)},
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  child: Text(
                                    snapshot.data!['data']['price'].toString() +
                                        ' đ',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF33907C),
                                    ),
                                  )),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: Text(
                                  'Qty: ' +
                                      snapshot.data!['data']['quantity']
                                          .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6),
                    Container(
                      height: 72,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor: Color(0xFF33907C),
                                backgroundImage: NetworkImage(
                                    'http://d1851nciml9u0m.cloudfront.net/user/default-1691832193326062897.png'),
                              ),
                            ),
                            SizedBox(width: 11),
                            Text(
                              snapshot.data!['data']['shop']['fullname'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: ProductDetailFollowStoreWidget(
                                    id: snapshot.data!['data']['shop']['id'])),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      constraints: const BoxConstraints(
                        maxWidth: 500,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                        child: Text(
                          snapshot.data!['data']['description'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 16, top: 10),
                                    child: Text(
                                      'Condition',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16, top: 16),
                                    child: Text(
                                      'Category',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          SizedBox(width: 32),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 16, top: 10),
                                  child: Text(
                                    snapshot.data!['data']['condition'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16, top: 16),
                                  child: Text(
                                    snapshot.data!['data']['category']['name'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
          }
        });
  }
}
