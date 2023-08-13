import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shopbee/globals.dart';
import 'package:shopbee/pages/CartScreens/PaymentOptionPage.dart';
import 'CartItemsWidget.dart';
import 'CartPriceDetailsWidget.dart';
import 'CartStoreWidget.dart';

class CartWidget extends StatefulWidget {
  final Map<String, dynamic> cartData;
  final Function(String) callbackChoose;
  final String shopChoose;
  const CartWidget({
    super.key,
    required this.cartData,
    required this.shopChoose,
    required this.callbackChoose,
  });

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  String? jwtToken;
  List<String> listName = [];
  List<int> listQuantity = [];
  List<int> listPrice = [];
  List<String> listUrl = [];
  @override
  void initState() {
    _getToken().then((value) {});
    listQuantity = widget.cartData['product_quantity'].cast<int>();
    listPrice = List.filled(widget.cartData['product_ids'].length, 0);
    listUrl = List.filled(widget.cartData['product_ids'].length, "");
    listName = List.filled(widget.cartData['product_ids'].length, "");
    for (int i = 0; i < widget.cartData['product_ids'].length; i++) {
      getCartProduct(widget.cartData['product_ids'][i]).then(
        (value) {
          listPrice[i] = value['data']['price'];
          listUrl[i] = value['data']['image']['url'];
          listName[i] = value['data']['name'];
        },
      );
    }
    super.initState();
  }

  Future<Map<String, dynamic>> getCartProduct(String id) async {
    try {
      Response response = await get(
        Uri.parse(apiURL + 'api/v1/product/view/${id}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print('failed cart product');
      }
    } catch (e) {
      print(e.toString());
    }
    return {};
  }

  void updateQuantity(String productId, int quantity) async {
    Map<String, dynamic> requestBody = {
      'product_id': productId,
      'quantity': quantity,
    };

    try {
      Response response = await patch(
        Uri.parse(apiURL + 'api/v1/cart/update'),
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        print(responseBody);
      } else {
        print('update failed');
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

  int calculatePrice(List<int> price, List<int> quantity) {
    int sum = 0;
    for (int i = 0; i < price.length; i++) {
      sum += price[i] * quantity[i];
    }
    return sum + 20000;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CartStoreWidget(
            id: widget.cartData['shop_id'],
            name: widget.cartData['shop_name'],
            url: widget.cartData['shop_avatar']['url'],
            shopChoose: widget.shopChoose,
            callbackChoose: widget.callbackChoose),
        for (int i = 0; i < widget.cartData['product_ids'].length; i++)
          CartItemsWidget(
            id: widget.cartData['product_ids'][i],
            quantity: listQuantity[i],
            callbackQuantity: (p0, p1) {
              setState(() {
                listQuantity[i] = p0;
                listPrice[i] = p1;
                updateQuantity(
                    widget.cartData['product_ids'][i], listQuantity[i]);
              });
            },
          ),
        CartPriceDetailsWidget(
          quantity: listQuantity,
          price: listPrice,
          initPrice: widget.cartData['total_price'],
        ),
        widget.cartData['shop_id'] == widget.shopChoose
            ? Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        'PaymentOptionPage',
                        arguments: PaymentData(
                            widget.cartData['shop_id'],
                            listName,
                            listPrice,
                            listQuantity,
                            listUrl,
                            calculatePrice(listPrice, listQuantity)),
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
                          "Continue to Payment",
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
              )
            : Container(),
        SizedBox(height: 35),
      ],
    );
  }
}
