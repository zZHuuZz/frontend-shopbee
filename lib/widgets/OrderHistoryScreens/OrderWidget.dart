// ignore_for_file: unused_import, file_names

import 'package:flutter/material.dart';
import '../../pages/ProductDetailScreens/ProductDetailPage.dart';
import 'OrderDeliveredStateWidget.dart';
import 'package:shopbee/widgets/OrderHistoryScreens/OrderGeneralStateWidget.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        height: 78,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15, left: 16, bottom: 16, right: 10),
          child: Row(children: [
            Container(
              height: 47,
              width: 47,
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
                InkWell(
                  /*
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'ProductDetailPage',
                      arguments: ProductData(
                        //product id here
                      ),
                    );
                  },*/
                  child: Text(
                    "!Product name",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
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
              ],
            ),
            const Spacer(),
            const Align(
              alignment: Alignment.centerRight,
              child: OrderGeneralStateWidget(),
              //OderDeliveredStateWidget(),

              //change state widget here
            ),
          ]),
        ),
      ),
    );
  }
}
