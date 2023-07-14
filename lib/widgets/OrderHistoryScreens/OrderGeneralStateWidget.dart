// ignore_for_file: file_names, sort_child_properties_last

import 'package:flutter/material.dart';

class OrderGeneralStateWidget extends StatefulWidget {
  const OrderGeneralStateWidget({super.key});

  @override
  State<OrderGeneralStateWidget> createState() =>
      _OrderGeneralStateWidgetState();
}

class _OrderGeneralStateWidgetState extends State<OrderGeneralStateWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        child: const Padding(
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
          border: Border.all(color: const Color(0xFF33907C)),
        ),
      ),
    );
  }
}
