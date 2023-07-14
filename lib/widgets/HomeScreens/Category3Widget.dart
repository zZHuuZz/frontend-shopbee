import 'package:flutter/material.dart';

class Category3Widget extends StatefulWidget {
  @override
  State<Category3Widget> createState() => _Category3WidgetState();
}

class _Category3WidgetState extends State<Category3Widget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 1, bottom: 1),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "CategoryPage");
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/book_devonly.png"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(right: 1, bottom: 1),
                    height: MediaQuery.of(context).size.width / 4 - 1,
                    width: MediaQuery.of(context).size.width / 4 - 1,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(65, 0, 0, 0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Information \nTechnology',
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
            ),
            Padding(
              padding: EdgeInsets.only(right: 1, bottom: 1),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "CategoryPage");
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/book_devonly.png"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(right: 1, bottom: 1),
                    height: MediaQuery.of(context).size.width / 4 - 1,
                    width: MediaQuery.of(context).size.width / 4 - 1,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(65, 0, 0, 0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Physics',
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
            ),
            Padding(
              padding: EdgeInsets.only(right: 1, bottom: 1),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "CategoryPage");
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/book_devonly.png"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(right: 1, bottom: 1),
                    height: MediaQuery.of(context).size.width / 4 - 1,
                    width: MediaQuery.of(context).size.width / 4 - 1,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(65, 0, 0, 0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Phylosophy',
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
            ),
            Padding(
              padding: EdgeInsets.only(right: 1, bottom: 1),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "CategoryPage");
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/book_devonly.png"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(right: 1, bottom: 1),
                    height: MediaQuery.of(context).size.width / 4 - 1,
                    width: MediaQuery.of(context).size.width / 4 - 1,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(65, 0, 0, 0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Chemistry',
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
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 1, bottom: 1),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "CategoryPage");
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/book_devonly.png"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(right: 1, bottom: 1),
                    height: MediaQuery.of(context).size.width / 4 - 1,
                    width: MediaQuery.of(context).size.width / 4 - 1,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(65, 0, 0, 0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Electronics',
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
            ),
            Padding(
              padding: EdgeInsets.only(right: 1, bottom: 1),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "CategoryPage");
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/book_devonly.png"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(right: 1, bottom: 1),
                    height: MediaQuery.of(context).size.width / 4 - 1,
                    width: MediaQuery.of(context).size.width / 4 - 1,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(65, 0, 0, 0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Economics',
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
            ),
            Padding(
              padding: EdgeInsets.only(right: 1, bottom: 1),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "CategoryPage");
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/book_devonly.png"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(right: 1, bottom: 1),
                    height: MediaQuery.of(context).size.width / 4 - 1,
                    width: MediaQuery.of(context).size.width / 4 - 1,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(65, 0, 0, 0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Biology',
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
            ),
            Padding(
              padding: EdgeInsets.only(right: 1, bottom: 1),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "CategoryPage");
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/book_devonly.png"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(right: 1, bottom: 1),
                    height: MediaQuery.of(context).size.width / 4 - 1,
                    width: MediaQuery.of(context).size.width / 4 - 1,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(65, 0, 0, 0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Mathematics',
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
            ),
          ],
        ),
      ],
    );
  }
}
