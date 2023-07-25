// ignore_for_file: unnecessary_import, file_names, avoid_unnecessary_containers

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyStoreViewWidget extends StatefulWidget {
  const MyStoreViewWidget({super.key});

  @override
  State<MyStoreViewWidget> createState() => _MyStoreViewWidgetState();
}

class _MyStoreViewWidgetState extends State<MyStoreViewWidget> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 31),
          Padding(
            padding: const EdgeInsets.only(left: 23, right: 17),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: TextFormField(
                autofocus: false,
                keyboardType: TextInputType.text,
                controller: searchController,
                style: const TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF13B58C),
                  ),
                  hintText: "Search Product",
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 27),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Text(
                "Products",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
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
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "AddProductPage");
                  },
                  child: DottedBorder(
                    color: Colors.grey,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    padding: const EdgeInsets.all(12),
                    dashPattern: const [6, 6, 6, 6],
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      child: Container(
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                'Add Product',
                                style: TextStyle(
                                  fontSize: 22,
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
                              heightFactor: .67,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  topLeft: Radius.circular(12),
                                ),
                                child: Container(
                                  foregroundDecoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'images/book_devonly.png'),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                            )),
                        Align(
                          alignment: const Alignment(0, -0.3),
                          child: Row(
                            children: [
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  //add edit product api here
                                  Navigator.pushNamed(
                                      context, "EditProductPage");
                                },
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Color.fromARGB(85, 0, 0, 0),
                                  child: Icon(Icons.border_color,
                                      color:
                                          Color.fromARGB(115, 255, 255, 255)),
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Delete Product"),
                                      content: const Text(
                                          "Are you sure you want to delete this product?"),
                                      actions: [
                                        TextButton(
                                          child: const Text("Cancel"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        TextButton(
                                          child: const Text(
                                            "Delete",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onPressed: () {
                                            // add delete product funtion here
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Color.fromARGB(85, 0, 0, 0),
                                  child: Icon(Icons.delete,
                                      color:
                                          Color.fromARGB(115, 255, 255, 255)),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
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
                              child: const FractionallySizedBox(
                                widthFactor: 1,
                                child: Column(
                                  children: [
                                    SizedBox(height: 14),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 12),
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
                                    SizedBox(height: 16),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 12, right: 12, bottom: 12),
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
                                            Text(
                                              "!Store name",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Spacer(),
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
          ),
        ],
      ),
    );
  }
}
