import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shopbee/globals.dart';

class ProductDetailWidget extends StatefulWidget {
  final String id;
  const ProductDetailWidget({super.key, required this.id});
  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  Map<String, dynamic> categoryData = {};
  Future<Map<String, dynamic>> getProductDetail() async {
    try {
      Response response = await get(
        Uri.parse(apiURL + 'api/v1/product/view/${widget.id}'),
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

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: getProductDetail(), // function where you call your api
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          // AsyncSnapshot<Your object type>
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            if (snapshot.hasError)
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 165,
                  color: Colors.white,
                  child: Center(child: Text('Error: ${snapshot.error}')));
            else
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      height: 326,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              snapshot.data?['data']['image']['url'],
                            ),
                            fit: BoxFit.fill),
                        color: const Color.fromARGB(65, 0, 0, 0),
                      ),
                    ),
                    Container(
                      height: 95,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding:
                                  EdgeInsets.only(top: 16, left: 16, right: 16),
                              child: Text(
                                snapshot.data?['data']['name'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              )),
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  child: Text(
                                    snapshot.data!['data']['price'].toString() +
                                        ' đ',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF33907C),
                                    ),
                                  )),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: Text(
                                  'Qty: ' +
                                      snapshot.data!['data']['quantity']
                                          .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6),
                    Container(
                      height: 72,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor: Color(0xFF33907C),
                              ),
                            ),
                            SizedBox(width: 11),
                            Text(
                              snapshot.data!['data']['shop']['fullname'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: InkWell(
                                onTap: () {
                                  //add follow store button
                                },
                                child: Container(
                                  width: 87,
                                  height: 23,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: const Color(0xFF33907C),
                                  ),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Follow",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      constraints: const BoxConstraints(
                        maxWidth: 500,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                        child: Text(
                          snapshot.data!['data']['description'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 16, top: 10),
                                    child: Text(
                                      'Condition',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16, top: 16),
                                    child: Text(
                                      'Category',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          SizedBox(width: 32),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 16, top: 10),
                                  child: Text(
                                    snapshot.data!['data']['condition'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16, top: 16),
                                  child: Text(
                                    snapshot.data!['data']['category']['name'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                    ),
                                  ),
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
        });
  }
}
