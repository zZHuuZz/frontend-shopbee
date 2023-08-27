// ignore_for_file: unused_import, file_names

import 'package:flutter/material.dart';
import '../../pages/ProductDetailScreens/ProductDetailPage.dart';

class OrderProductWidget extends StatefulWidget {
  final Map<String, dynamic> orderProduct;
  const OrderProductWidget({super.key, required this.orderProduct});

  @override
  State<OrderProductWidget> createState() => _OrderProductWidgetState();
}

class _OrderProductWidgetState extends State<OrderProductWidget> {
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
              foregroundDecoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        widget.orderProduct['product_origin']['image']),
                    fit: BoxFit.fill),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(width: 22),
            Expanded(
              child: Column(
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
                      widget.orderProduct['product_origin']['name'],
                      overflow: TextOverflow.ellipsis,
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
                            widget.orderProduct['product_origin']['price']
                                    .toString() +
                                ' đ',
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
                            "Qty: " +
                                widget.orderProduct['product_origin']
                                        ['quantity']
                                    .toString(),
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
            ),
          ]),
        ),
      ),
    );
  }
}
