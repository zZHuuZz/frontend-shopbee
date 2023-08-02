import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final String name, cardNumber, expiresDate, cvc;
  CardWidget(
      {Key? key,
      required this.name,
      required this.cardNumber,
      required this.expiresDate,
      required this.cvc})
      : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 309,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/creditcard_devonly.png'),
            fit: BoxFit.cover),
      ),
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Spacer(),
                Text(
                  'Card Holder',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
            Row(
              children: [
                Spacer(),
                Text(
                  widget.name,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Card Number',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
              widget.cardNumber,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Row(
              children: [
                Text(
                  'Expires Date:',
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
                Text(
                  widget.expiresDate,
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
                Spacer(),
                Text(
                  'CVC:',
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
                Text(
                  widget.cvc,
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
