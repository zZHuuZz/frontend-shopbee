// ignore_for_file: file_names

// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrowseItemsWidget extends StatefulWidget {
  const BrowseItemsWidget({super.key});

  @override
  State<BrowseItemsWidget> createState() => _BrowseItemsWidgetState();
}

class _BrowseItemsWidgetState extends State<BrowseItemsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: GridView.count(
        mainAxisSpacing: 15,
        crossAxisSpacing: 12.35,
        childAspectRatio: 0.82,
        primary: true,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        children: [
          for (int i = 0; i < 9; i++)
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
                            foregroundDecoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/book_devonly.png'),
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
                        child: const FractionallySizedBox(
                          widthFactor: 1,
                          child: Column(
                            children: [
                              SizedBox(height: 4),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "!Product Name",
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
                                        "\$9990",
                                        style: TextStyle(
                                          fontSize: 11,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "\$9990",
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
                                        backgroundColor: Color(0xFF33907C),
                                        foregroundColor: Colors.white,
                                        //backgroundImage: NetworkImage("ADD URL HERE"),
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        "!Store name",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
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
      ),
    );
  }
}
