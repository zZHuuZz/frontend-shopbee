import 'package:flutter/material.dart';

class MyStoreItemWidget extends StatefulWidget {
  @override
  State<MyStoreItemWidget> createState() => _MyStoreItemWidgetState();
}

class _MyStoreItemWidgetState extends State<MyStoreItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        childAspectRatio: 0.68,
        physics: ScrollPhysics(),
        crossAxisCount: 2,
        shrinkWrap: true,
        children: [
          for (int i = 0; i < 9; i++)
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color(0xFF4C53A5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "-30%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "ItemPage");
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Image.asset(
                        "images/logo.png",
                        height: 120,
                        width: 120,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Product name",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF4C53A5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "!Add description here",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF4C53A5),
                        ),
                      )),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$9999",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4C53A5),
                          ),
                        ),
                        Icon(
                          Icons.shopping_cart_checkout,
                          color: Color(0xFF4C53A5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
