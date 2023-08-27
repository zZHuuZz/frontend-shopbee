// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shopbee/pages/ProductDetailScreens/ProductDetailPage.dart';

class HomePageProductWidget extends StatefulWidget {
  final String id, name;
  final int price;
  final String store, url;

  HomePageProductWidget(
      {Key? key,
      required this.id,
      required this.name,
      required this.price,
      required this.store,
      required this.url})
      : super(key: key);
  @override
  State<HomePageProductWidget> createState() => _HomePageProductWidgetState();
}

class _HomePageProductWidgetState extends State<HomePageProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromARGB(106, 158, 158, 158),
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            'ProductDetailPage',
            arguments: ProductData(
              widget.id,
            ),
          );
        },
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            Align(
                alignment: const Alignment(0, -1),
                child: FractionallySizedBox(
                  heightFactor: .67,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    ),
                    child: Container(
                      foregroundDecoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.url), fit: BoxFit.fill),
                      ),
                    ),
                  ),
                )),
            Align(
              alignment: const Alignment(-1, 1),
              child: FractionallySizedBox(
                heightFactor: .33,
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
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 12, right: 12, bottom: 4),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text(
                                  widget.price.toString() + ' đ',
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
                          padding:
                              EdgeInsets.only(left: 12, right: 12, bottom: 1),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Color(0xFF33907C),
                                  foregroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      "http://d1851nciml9u0m.cloudfront.net/user/default-1691832193326062897.png"),
                                ),
                                SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    widget.store,
                                    overflow: TextOverflow.ellipsis,
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
    );
  }
}
