import 'package:flutter/material.dart';

class OrderDeliveredStateWidget extends StatefulWidget {
  @override
  State<OrderDeliveredStateWidget> createState() =>
      _OrderDeliveredStateWidgetState();
}

class _OrderDeliveredStateWidgetState extends State<OrderDeliveredStateWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23, vertical: 4),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Delivered",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Color(0xFF33907C),
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
