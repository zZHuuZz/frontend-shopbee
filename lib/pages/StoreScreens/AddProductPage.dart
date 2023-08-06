// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';
import 'package:shopbee/globals.dart';
import 'dart:io';
import 'dart:convert';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductState();
}

class _AddProductState extends State<AddProductPage> {
  String? jwtToken;
  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final productDescriptionController = TextEditingController();
  int categoryValue = 1;
  String conditionValue = 'used';
  File? _image;
  final picker = ImagePicker();
  Map<String, dynamic> imageOnCloud = {};
  Map<String, dynamic> categoryData = {};

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<Map<String, dynamic>> getCategory() async {
    try {
      Response response = await get(
        Uri.parse('http://shopbee-api.shop:3055/api/v1/category/list'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        categoryData = responseBody;
        return responseBody;
      } else {
        print('failed category');
      }
    } catch (e) {
      print(e.toString());
    }
    return categoryData;
  }

  Future<bool> addImage(Map<String, String> body, String filepath) async {
    String addimageUrl = 'http://shopbee-api.shop:3055/api/v1/image/upload';
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };
    var request = MultipartRequest('POST', Uri.parse(addimageUrl))
      ..fields.addAll(body)
      ..headers.addAll(headers)
      ..files.add(await MultipartFile.fromPath('file', filepath));
    Response response = await Response.fromStream(await request.send());
    print("Result: ${response.statusCode}");

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      imageOnCloud = responseBody;

      return true;
    } else {
      return false;
    }
  }

  void createProduct(String name, description, condition, int price, quantity,
      Map<String, dynamic> image) async {
    Map<String, dynamic> requestBody = {
      "category_id": categoryValue,
      "name": name,
      "description": description,
      "price": price,
      "quantity": quantity,
      "condition": condition,
      "image": image['data'],
    };

    try {
      Response response = await post(
        Uri.parse('http://shopbee-api.shop:3055/api/v1/product/create'),
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        print(responseBody);
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  // Function to set the JWT token
  Future<void> _setToken(String token) async {
    await setToken(token);
    setState(() {
      jwtToken = token;
    });
  }

  // Function to get the JWT token
  Future<void> _getToken() async {
    String? token = await getToken();
    setState(() {
      jwtToken = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
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
                        _image != null
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: InkWell(
                                  onTap: () {
                                    getImage().then((value) {
                                      Map<String, String> body = {
                                        'folder': 'product'
                                      };
                                      addImage(body, _image!.path)
                                          .then((value) {
                                        setState(() {});
                                      });
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
                                                Icons.refresh,
                                                size: 50,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Change photos',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
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
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      getImage().then((value) {
                                        Map<String, String> body = {
                                          'folder': 'product'
                                        };
                                        addImage(body, _image!.path)
                                            .then((value) {
                                          setState(() {});
                                        });
                                      });
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
                        if (_image != null)
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
                                        image: FileImage(_image!),
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
                                        _image = null;
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
                      'Max. 1 photo per product',
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FutureBuilder<Map<String, dynamic>>(
                          future:
                              getCategory(), // function where you call your api
                          builder: (BuildContext context,
                              AsyncSnapshot<Map<String, dynamic>> snapshot) {
                            // AsyncSnapshot<Your object type>
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container();
                            } else {
                              if (snapshot.hasError)
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 200,
                                    color: Colors.white,
                                    child: Center(
                                        child:
                                            Text('Error: ${snapshot.error}')));
                              else
                                return DropdownButton<int>(
                                  value: categoryValue,
                                  items: [
                                    for (var category in snapshot.data?['data'])
                                      DropdownMenuItem(
                                          child: Text(
                                            category['name'],
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          value: category['rid']),
                                  ],
                                  onChanged: (int? value) {
                                    //get value when changed
                                    setState(() {
                                      categoryValue = value!;
                                    });
                                  },
                                );
                            }
                          }),
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
                                keyboardType: TextInputType.number,
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
                                  'Quantity',
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
                                keyboardType: TextInputType.number,
                                controller: quantityController,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                decoration: InputDecoration(
                                  prefixIconColor: Colors.grey,
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
                        'Condition',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButton<String>(
                        value: conditionValue,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'new',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            value: 'new',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'used',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            value: 'used',
                          ),
                        ],
                        onChanged: (String? value) {
                          //get value when changed
                          setState(() {
                            conditionValue = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
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
              onTap: () {
                createProduct(
                    productNameController.text,
                    productDescriptionController.text,
                    conditionValue,
                    int.parse(priceController.text),
                    int.parse(quantityController.text),
                    imageOnCloud);
                Navigator.pop(context);
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
