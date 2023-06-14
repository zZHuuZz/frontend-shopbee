import 'package:flutter/material.dart';

class MyStoreEmptyWidget extends StatefulWidget {
  @override
  State<MyStoreEmptyWidget> createState() => _MyStoreEmptyWidgetState();
}

class _MyStoreEmptyWidgetState extends State<MyStoreEmptyWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
        ),
        Text(
          'You don\'t have product',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          height: 50,
          width: 220,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFF33907C),
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'AddProductPage');
            },
            child: Center(
              child: Text(
                "Add Product",
                style: TextStyle(
                  color: Color(0xFF33907C),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
