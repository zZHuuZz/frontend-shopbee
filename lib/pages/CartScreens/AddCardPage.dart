// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final cardNumberController = TextEditingController();
  final nameController = TextEditingController();
  final expiresDateController = TextEditingController();
  final cvcController = TextEditingController();

  void initState() {
    cardNumberController
      ..addListener(() {
        setState(() {});
      });
    nameController
      ..addListener(() {
        setState(() {});
      });
    expiresDateController
      ..addListener(() {
        setState(() {});
      });
    cvcController
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    nameController.dispose();
    expiresDateController.dispose();
    cvcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F9FF),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        backgroundColor: Color(0xFF33907C),
        title: Text(
          'Add Card',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Container(
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
                        '${nameController.text}',
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
                    '${cardNumberController.text}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Text(
                        'Expires Date:',
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                      Text(
                        '${expiresDateController.text}',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                      Spacer(),
                      Text(
                        'CVC:',
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                      Text(
                        '${cvcController.text}',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 9),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 430,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Card Number',
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
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'\d|\s')),
                          CustomInputFormatter(inputLength: 16),
                        ],
                        keyboardType: TextInputType.number,
                        controller: cardNumberController,
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
                          'Name',
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
                        maxLength: 19,
                        keyboardType: TextInputType.text,
                        controller: nameController,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Expires Dates',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Container(
                                width: 200,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: TextField(
                                  inputFormatters: [
                                    DateTextFormatter(),
                                  ],
                                  keyboardType: TextInputType.number,
                                  controller: expiresDateController,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'CVC',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Container(
                                width: 98,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  maxLength: 3,
                                  controller: cvcController,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: "",
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 9),
                  ],
                ),
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
                    "Save",
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

class CustomInputFormatter extends TextInputFormatter {
  final int? inputLength;
  //inputLength = 16 -> if input == 'XXXX XXXX XXXX XXXX'(16 characters)
  //inputLength = 12 -> if input == 'XXXX XXXX XXXX'(12 characters)
  //inputLength is optional.

  CustomInputFormatter({this.inputLength});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String left = oldValue.text
        .substring(0, min(oldValue.selection.start, newValue.selection.end));
    String right = oldValue.text.substring(oldValue.selection.end);
    String inserted =
        newValue.text.substring(left.length, newValue.selection.end);
    String modLeft = left.replaceAll(" ", "");
    String modRight = right.replaceAll(" ", "");
    String modInserted = inserted.replaceAll(" ", "");
    if (inputLength != null) {
      modInserted = modInserted.substring(
          0,
          min(inputLength! - modLeft.length - modRight.length,
              modInserted.length));
    }
    final regEx = RegExp(r'\d{1,4}');
    String updated = regEx
        .allMatches((modLeft + modInserted + modRight).toUpperCase())
        .map((e) => e.group(0))
        .join(" ");
    int cursorPosition = regEx
        .allMatches(modLeft + modInserted)
        .map((e) => e.group(0))
        .join(" ")
        .length;
    return TextEditingValue(
        text: updated,
        selection: TextSelection.collapsed(offset: cursorPosition));
  }
}

class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 4;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = _format(newValue.text, '/');
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String seperator) {
    value = value.replaceAll(seperator, '');
    var newString = '';

    for (int i = 0; i < min(value.length, _maxChars); i++) {
      newString += value[i];
      if ((i == 1 || i == 4) && i != value.length - 1) {
        newString += seperator;
      }
    }

    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
