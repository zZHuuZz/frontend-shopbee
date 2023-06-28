import 'package:flutter/material.dart';

class OrderGeneralStateWidget extends StatefulWidget {
  @override
  State<OrderGeneralStateWidget> createState() =>
      _OrderGeneralStateWidgetState();
}

class _OrderGeneralStateWidgetState extends State<OrderGeneralStateWidget> {
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
              "Order State",
              //change state name with api
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Color(0xFF33907C),
              ),
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Color(0xFF33907C)),
        ),
      ),
    );
  }
}
