// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:shopbee/widgets/ProductDetailWidget.dart/ProductDetailWidget.dart';

class ProductData {
  final String id;

  ProductData(this.id);
}

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as ProductData;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFF6F9FF),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 12),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(65, 255, 255, 255),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(65, 255, 255, 255),
              ),
              child: IconButton(
                icon: Icon(Icons.favorite, color: Colors.white, size: 30),
                onPressed: () => {},
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(65, 255, 255, 255),
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white, size: 30),
                onPressed: () => {},
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
      ),
      body: ProductDetailWidget(id: data.id),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: InkWell(
              onTap: () {
                //payment button
              },
              child: Container(
                height: 49,
                width: 84,
                decoration: BoxDecoration(
                  color: Color(0xFF33907C),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    "Add To Cart",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
