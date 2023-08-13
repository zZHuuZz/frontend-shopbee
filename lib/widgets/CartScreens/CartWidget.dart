import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shopbee/globals.dart';
import 'CartItemsWidget.dart';
import 'CartPriceDetailsWidget.dart';
import 'CartStoreWidget.dart';

class CartWidget extends StatefulWidget {
  final Map<String, dynamic> cartData;
  const CartWidget({super.key, required this.cartData});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  List<int> listQuantity = [];
  List<int> listPrice = [];

  void initState() {
    listQuantity = List.filled(widget.cartData['product_ids'].length, 1);
    listPrice = List.filled(widget.cartData['product_ids'].length, 0);
    for (int i = 0; i < widget.cartData['product_ids'].length; i++) {
      getCartProduct(widget.cartData['product_ids'][i]).then(
        (value) {
          listPrice[i] = value['data']['price'];
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CartStoreWidget(
            id: widget.cartData['shop_id'],
            name: widget.cartData['shop_name'],
            url: widget.cartData['shop_avatar']['url']),
        for (int i = 0; i < widget.cartData['product_ids'].length; i++)
          //for (var cartProductData in widget.cartData['product_ids'])
          CartItemsWidget(
            id: widget.cartData['product_ids'][i],
            callbackQuantity: (p0, p1) {
              setState(() {
                listQuantity[i] = p0;
                listPrice[i] = p1;
              });
            },
          ),
        CartPriceDetailsWidget(
          quantity: listQuantity,
          price: listPrice,
          initPrice: widget.cartData['total_price'],
        ),
        SizedBox(height: 35),
      ],
    );
  }
}
