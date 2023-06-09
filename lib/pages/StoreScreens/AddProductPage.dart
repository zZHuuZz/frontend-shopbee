import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  @override
  State<AddProductPage> createState() => _AddProductState();
}

class _AddProductState extends State<AddProductPage> {
  final productNameController = TextEditingController();
  final categoryProductController = TextEditingController();
  final priceController = TextEditingController();
  final offerPriceController = TextEditingController();
  final locationDetailsController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final priceTypeController = TextEditingController();
  final additionalDetailsController = TextEditingController();
  int photoController = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Color(0xFF33907C),
        title: Text(
          'Add Product',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 40,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            width: MediaQuery.of(context).size.width,
            color: Color(0xFFF6F9FF),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (photoController < 4) photoController++;
                              });
                            },
                            child: DottedBorder(
                              color: Colors.grey,
                              borderType: BorderType.RRect,
                              radius: Radius.circular(12),
                              padding: EdgeInsets.all(12),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                                child: Container(
                                  height: 105,
                                  width: 150,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.add,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Add photos',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '1600 x 1200 for high res',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        for (int i = 0; i < photoController; i++)
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                height: 123,
                                width: 168,
                                color: Colors.transparent,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Container(
                                    height: 105,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(24)),
                                      image: DecorationImage(
                                        image: AssetImage('images/logo.png'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(80, 0, 0, 0),
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (photoController > 0)
                                          photoController--;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                      size: 10,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Max. 4 photos per product',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Product Name',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: productNameController,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Category Product',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: categoryProductController,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Price',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: priceController,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: InputDecoration(
                                  prefixIconColor: Colors.grey,
                                  prefixIcon: Icon(Icons.attach_money),
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Offer Price',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: offerPriceController,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: InputDecoration(
                                  prefixIconColor: Colors.grey,
                                  prefixIcon: Icon(Icons.attach_money),
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Location Details',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: locationDetailsController,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Product Desciption',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 99,
                      keyboardType: TextInputType.multiline,
                      controller: productDescriptionController,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Price Type',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: priceTypeController,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Additional Details',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: additionalDetailsController,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 49,
                width: 84,
                decoration: BoxDecoration(
                  color: Color(0xFF33907C),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    "Add Product",
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
