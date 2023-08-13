import 'package:flutter/material.dart';

class CartPriceDetailsWidget extends StatefulWidget {
  final List<int> quantity;
  final List<int> price;
  final int initPrice;
  const CartPriceDetailsWidget(
      {super.key,
      required this.quantity,
      required this.price,
      required this.initPrice});

  @override
  State<CartPriceDetailsWidget> createState() => _CartPriceDetailsWidgetState();
}

class _CartPriceDetailsWidgetState extends State<CartPriceDetailsWidget> {
  @override
  void initState() {
    super.initState();
  }

  int calculate() {
    int total = 0;
    for (int i = 0; i < widget.quantity.length; i++) {
      total = total + widget.quantity[i] * widget.price[i];
      print(widget.price[i]);
      print(widget.quantity[i]);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2),
      child: Container(
        width: MediaQuery.of(context).size.height,
        height: 183,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 11, left: 16, right: 16),
              child: Text(
                'Price Details',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text(
                    (widget.price.every((element) => element == 0)
                                ? widget.initPrice
                                : calculate())
                            .toString() +
                        ' đ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Delivery Fee',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '20000 đ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
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
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
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
                          (widget.price.every((element) => element == 0)
                                      ? widget.initPrice + 20000
                                      : calculate() + 20000)
                                  .toString() +
                              ' đ',
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
    );
  }
}
