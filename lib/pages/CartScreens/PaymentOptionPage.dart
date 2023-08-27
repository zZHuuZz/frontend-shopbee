// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shopbee/globals.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:shopbee/widgets/CartScreens/CardWidget.dart';
import 'package:shopbee/widgets/CartScreens/UserLocationWidget.dart';

class PaymentData {
  final String id;
  final int totalPrice;
  final List<String> productName;
  final List<int> price;
  final List<int> quantity;
  final List<String> url;

  PaymentData(this.id, this.productName, this.price, this.quantity, this.url,
      this.totalPrice);
}

class PaymentOptionPage extends StatefulWidget {
  const PaymentOptionPage({super.key});

  @override
  State<PaymentOptionPage> createState() => _PaymentOptionPageState();
}

class _PaymentOptionPageState extends State<PaymentOptionPage> {
  String userName = "";
  String phone = "";
  String address = "";
  String cardHolder = "";
  String cardNumber = "";
  String expiresDate = "";
  String cvc = "";
  int paymentChoice = 0;
  bool addcard = false;
  String? jwtToken;
  Map<String, dynamic> profileData = {};

  Future<Map<String, dynamic>> createPayment(
      String paymentMethod, int amount) async {
    Map<String, dynamic> requestBody = {
      'payment_method': paymentMethod,
      'amount': amount,
    };
    try {
      Response response = await post(
        Uri.parse(apiURL + 'api/v1/payment/create'),
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return responseBody;
      } else {
        print(responseBody);
        print('failed to pay');
      }
    } catch (e) {
      print(e.toString());
    }
    return {};
  }

  Future<Map<String, dynamic>> createOrder(String shopID, paymentID, address,
      totalPrice, List<Map<String, dynamic>> products) async {
    Map<String, dynamic> requestBody = {
      'shop_id': shopID,
      'payment_id': paymentID,
      'shipping_addr': address,
      'total_price': totalPrice,
      'product_list': products,
    };
    try {
      Response response = await post(
        Uri.parse(apiURL + 'api/v1/order/create'),
        body: jsonEncode(requestBody),
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
            content: const Text("Order Successed!"),
            actions: [
              TextButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.pushNamed(context, 'OrderHistoryPage');
                },
              ),
            ],
          ),
        );
        return responseBody;
      } else {
        print(jsonDecode(response.body));
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text("Order Failed!"),
            actions: [
              TextButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.pushNamed(context, 'CartPage');
                },
              ),
            ],
          ),
        );
        print('failed to order');
      }
    } catch (e) {
      print(e.toString());
    }
    return {};
  }

  List<Map<String, dynamic>> makeProduct(List<String> productname,
      List<String> url, List<int> quantity, List<int> price) {
    List<Map<String, dynamic>> products = [];
    for (int i = 0; i < productname.length; i++) {
      Map<String, dynamic> temp = {
        'name': productname[i],
        'price': price[i],
        'quantity': quantity[i],
        'image': url[i],
      };
      products.add(temp);
    }
    return products;
  }

  @override
  void initState() {
    _getToken().then((value) {});
    super.initState();
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
        userName = profileData['data']['fullname'];
        phone = profileData['data']['phone'];
        address = profileData['data']['addr'];
        return responseBody;
      } else {
        print('failed profile');
      }
    } catch (e) {
      print(e.toString());
    }
    return profileData;
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

  Icon chooseIcon(bool check) {
    if (check == true)
      return Icon(Icons.radio_button_checked, color: Color(0xFF33907C));
    else
      return Icon(Icons.radio_button_unchecked, color: Colors.grey);
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as PaymentData;
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
          'Payment Option',
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
            paymentChoice == 0
                ? addcard
                    ? Column(
                        children: [
                          SizedBox(height: 20),
                          CardWidget(
                            name: '',
                            cardNumber: 'xxxx xxxx xxxx xxxx',
                            expiresDate: '',
                            cvc: '',
                          ),
                        ],
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 240,
                        color: Colors.white,
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, 'AddCardPage');
                                  setState(() {
                                    addcard = true;
                                  });
                                },
                                child: DottedBorder(
                                  color: Colors.grey,
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(12),
                                  padding: EdgeInsets.all(12),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24)),
                                    child: Container(
                                      height: 146,
                                      width: 246,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.add,
                                              size: 50,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Add Card',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.grey,
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
                      )
                : Container(),
            SizedBox(height: 6),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 195,
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            paymentChoice = 0;
                          });
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              paymentChoice == 0
                                  ? chooseIcon(true)
                                  : chooseIcon(false),
                              SizedBox(width: 10),
                              Text(
                                "Debit / Credit Card",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFEFEFEF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            paymentChoice = 1;
                          });
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              paymentChoice == 1
                                  ? chooseIcon(true)
                                  : chooseIcon(false),
                              SizedBox(width: 10),
                              Text(
                                "Cash on  Delivery",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFEFEFEF),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6),
            FutureBuilder<Map<String, dynamic>>(
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
                          child:
                              Center(child: Text('Error: ${snapshot.error}')));
                    else
                      return snapshot.data!['data']['addr'] != ""
                          ? UserLocationWidget(
                              address: address,
                              phone: phone,
                              userName: userName,
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              height: 69,
                              child: InkWell(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '+ Add New Address',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, 'AddNewAddressPage');
                                  setState(() {});
                                },
                              ),
                              color: Colors.white,
                            );
                  }
                }),
            SizedBox(height: 6),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Container(
                width: MediaQuery.of(context).size.height,
                height: 80,
                color: Colors.white,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total amount',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          data.totalPrice.toString() + ' đ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: InkWell(
              onTap: () {
                (paymentChoice == 0
                        ? createPayment("card", data.totalPrice)
                        : createPayment("cod", data.totalPrice))
                    .then(
                  (value) {
                    createOrder(
                        data.id,
                        value['data']['id'],
                        address,
                        data.totalPrice,
                        makeProduct(data.productName, data.url, data.quantity,
                            data.price));
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
                    "Checkout",
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
}
