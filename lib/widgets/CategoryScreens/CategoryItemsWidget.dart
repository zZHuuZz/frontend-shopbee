// ignore_for_file: file_names, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

class CategoryItemsWidget extends StatefulWidget {
  final int rid;
  const CategoryItemsWidget({super.key, required this.rid});
  @override
  State<CategoryItemsWidget> createState() => _CategoryItemsWidgetState();
}

class _CategoryItemsWidgetState extends State<CategoryItemsWidget> {
  Map<String, dynamic> categoryData = {};
  Future<Map<String, dynamic>> getProduct() async {
    try {
      Response response = await get(
        Uri.parse(
            'http://shopbee-api.shop:3055/api/v1/product/list?category_id=${widget.rid}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
    return categoryData;
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: FutureBuilder<Map<String, dynamic>>(
        future: getProduct(), // function where you call your api
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          // AsyncSnapshot<Your object type>
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Colors.white,
              child: Center(child: Text('Please wait its loading...')),
            );
          } else {
            if (snapshot.hasError)
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  color: Colors.white,
                  child: Center(child: Text('Error: ${snapshot.error}')));
            else
              return GridView.count(
                mainAxisSpacing: 15,
                crossAxisSpacing: 12.35,
                childAspectRatio: 0.82,
                primary: true,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: [
                  for (var product in snapshot.data?['data'])
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color.fromARGB(106, 158, 158, 158),
                          width: 2,
                        ),
                      ),
                      child: Stack(
                        clipBehavior: Clip.antiAlias,
                        children: [
                          Align(
                              alignment: const Alignment(0, -1),
                              child: FractionallySizedBox(
                                heightFactor: .65,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    topLeft: Radius.circular(12),
                                  ),
                                  child: Container(
                                    foregroundDecoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              product['image']['url']),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                              )),
                          Align(
                            alignment: const Alignment(-1, 1),
                            child: FractionallySizedBox(
                              heightFactor: .35,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                ),
                                child: FractionallySizedBox(
                                  widthFactor: 1,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 4),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            product['name'],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 12, right: 12, bottom: 4),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              Text(
                                                product['price'].toString() +
                                                    ' đ',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xFF33907C),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 12, right: 12, bottom: 1),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 10,
                                                backgroundColor:
                                                    Color(0xFF33907C),
                                                foregroundColor: Colors.white,
                                                //backgroundImage: NetworkImage("ADD URL HERE"),
                                              ),
                                              SizedBox(width: 6),
                                              Flexible(
                                                child: Text(
                                                  product['shop']['fullname'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ); // snapshot.data  :- get your object which is pass from your downloadData() function
          }
        },
      ),
    );
  }
}
