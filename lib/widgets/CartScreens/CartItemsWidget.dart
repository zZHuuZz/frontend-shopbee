import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shopbee/globals.dart';

class CartItemsWidget extends StatefulWidget {
  final String id;
  final int quantity;
  final Function(int, int) callbackQuantity;

  const CartItemsWidget({
    super.key,
    required this.id,
    required this.quantity,
    required this.callbackQuantity,
  });

  @override
  State<CartItemsWidget> createState() => _CartItemsWidgetState();
}

class _CartItemsWidgetState extends State<CartItemsWidget> {
  String? jwtToken;
  int num = 1;
  Map<String, dynamic> productData = {};
  Future<Map<String, dynamic>> getCartProduct() async {
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
        return responseBody;
      } else {
        print('failed cart product');
      }
    } catch (e) {
      print(e.toString());
    }
    return productData;
  }

  void deleteProduct(String id) async {
    try {
      Response response = await delete(
        Uri.parse(apiURL + 'api/v1/cart/removeproduct/${id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        print(responseBody);
        setState(() {
          Navigator.pushReplacementNamed(context, "CartPage");
        });
      } else {
        print('failed to remoce cart');
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
    _getToken().then((value) {});
    num = widget.quantity;
    super.initState();
  }

  int calculatePrice(int price) {
    return price;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: getCartProduct(), // function where you call your api
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
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Container(
                  width: MediaQuery.of(context).size.height,
                  height: 183,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 29, bottom: 12, left: 16),
                        child: Row(
                          children: [
                            Container(
                              height: 102,
                              width: 102,
                              foregroundDecoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data?['data']['image']['url']),
                                    fit: BoxFit.fill),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            const SizedBox(width: 22),
                            Expanded(
                              child: Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        snapshot.data?['data']['name'],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        snapshot.data!['data']['price']
                                                .toString() +
                                            ' đ',
                                        style: TextStyle(
                                          color: Color(0xFF33907C),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                      return Row(
                                        children: [
                                          Text(
                                            'Qty: ',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                          InkWell(
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.grey,
                                              size: 22,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                if (num > 1) num = num - 1;
                                                widget.callbackQuantity(
                                                    num,
                                                    calculatePrice(
                                                        snapshot.data!['data']
                                                            ['price']));
                                              });
                                            },
                                          ),
                                          Text(
                                            num.toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey),
                                          ),
                                          InkWell(
                                            child: Icon(
                                              Icons.arrow_drop_up,
                                              color: Colors.grey,
                                              size: 22,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                if (num <= 100) num = num + 1;
                                                widget.callbackQuantity(
                                                    num,
                                                    calculatePrice(
                                                        snapshot.data!['data']
                                                            ['price']));
                                              });
                                            },
                                          ),
                                        ],
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            deleteProduct(widget.id);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Remove',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            else {
              return Container();
            }
          }
        });
  }
}
