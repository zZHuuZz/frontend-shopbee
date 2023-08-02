// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  final int RID;
  final String name, URL;
  CategoryWidget(
      {Key? key, required this.RID, required this.name, required this.URL})
      : super(key: key);
  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 1, bottom: 1),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "CategoryPage");
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.URL),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.only(right: 1, bottom: 1),
            height: MediaQuery.of(context).size.width / 4 - 1,
            width: MediaQuery.of(context).size.width / 4 - 1,
            decoration: BoxDecoration(
              color: const Color.fromARGB(65, 0, 0, 0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${widget.name}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
