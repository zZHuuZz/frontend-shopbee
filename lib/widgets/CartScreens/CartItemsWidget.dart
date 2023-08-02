import 'package:flutter/material.dart';

class CartItemsWidget extends StatefulWidget {
  const CartItemsWidget({super.key});

  @override
  State<CartItemsWidget> createState() => _CartItemsWidgetState();
}

class _CartItemsWidgetState extends State<CartItemsWidget> {
  int num = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
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
                    foregroundDecoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/book_devonly.png'),
                          fit: BoxFit.fill),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 22),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "!Product name",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "\$5",
                                style: TextStyle(
                                  color: Color(0xFF33907C),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "50%",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 2),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Off",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
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
                                if (num >= 1) num = num - 1;
                              });
                            },
                          ),
                          Text(
                            num.toString(),
                            style: TextStyle(fontSize: 14, color: Colors.grey),
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
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  //remove item button
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
  }
}
