// ignore_for_file: unused_import, file_names

import 'package:flutter/material.dart';
import 'package:shopbee/globals.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shopbee/widgets/CartScreens/ViewOrderProductWidget.dart';
import 'package:intl/intl.dart';

class ViewOrderWidget extends StatefulWidget {
  final Map<String, dynamic> orderData;
  const ViewOrderWidget({super.key, required this.orderData});

  @override
  State<ViewOrderWidget> createState() => _ViewOrderWidgetState();
}

class _ViewOrderWidgetState extends State<ViewOrderWidget> {
  String? jwtToken;
  List<String> orderStatus = ["pending", "confirm", "delivering", "completed"];
  Map<String, dynamic> orderProduct = {};
  bool onClicked = false;
  Future<Map<String, dynamic>> getViewOrderProduct() async {
    try {
      Response response = await get(
        Uri.parse(apiURL + 'api/v1/order/shop/${widget.orderData['id']}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        orderProduct = responseBody;
        return responseBody;
      } else {
        print(widget.orderData['id']);
        print(jsonDecode(response.body));
        print('failed view order list');
      }
    } catch (e) {
      print(e.toString());
    }
    return orderProduct;
  }

  Future<void> changeStatus(String id, String value) async {
    try {
      Response response = await patch(
        Uri.parse(apiURL + 'api/v1/order/shop/${id}/${value}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        print(responseBody);
      } else {
        print(jsonDecode(response.body));
        print('failed change status list');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    _getToken().then((value) {});
    super.initState();
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
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              onClicked = !onClicked;
            });
          },
          child: Container(
            height: 78,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey, width: 2))),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 16, bottom: 16, right: 10),
              child: Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.orderData['id'].toString().toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          widget.orderData['total_price'].toString() + ' đ',
                          style: TextStyle(
                            color: Color(0xFF33907C),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                DropdownMenu<String>(
                  width: 155,
                  initialSelection: widget.orderData['order_status'],
                  onSelected: (String? value) {
                    // This is called when the user selects an item.
                    changeStatus(widget.orderData['id'], value!).then(
                      (value) {
                        setState(() {});
                      },
                    );
                  },
                  dropdownMenuEntries: orderStatus
                      .map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList(),
                ),
              ]),
            ),
          ),
        ),
        FutureBuilder<Map<String, dynamic>>(
            future: getViewOrderProduct(), // function where you call your api
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
                      child: Center(child: Text('Error: ${snapshot.error}')));
                else if (snapshot.data?['data'] != null)
                  return onClicked
                      ? Column(
                          children: [
                            for (var product in snapshot.data!['data'])
                              ViewOrderProductWidget(
                                orderProduct: product,
                              ),
                          ],
                        )
                      : Container();
                else {
                  return Container();
                }
              }
            }),
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: InkWell(
            onTap: () {
              setState(() {
                onClicked = !onClicked;
              });
            },
            child: Container(
              height: 78,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(bottom: BorderSide(color: Colors.grey, width: 2))),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 16, bottom: 16, right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address: ' +
                                widget.orderData['shipping_addr'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Buyer: " +
                                widget.orderData['buyer']['fullname']
                                    .toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 5),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
