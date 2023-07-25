// ignore_for_file: file_names

import 'package:flutter/material.dart'
    show
        Align,
        Alignment,
        AssetImage,
        BorderRadius,
        BoxDecoration,
        BoxFit,
        BuildContext,
        Color,
        Colors,
        Column,
        Container,
        DecorationImage,
        EdgeInsets,
        FontWeight,
        InkWell,
        MediaQuery,
        Navigator,
        Padding,
        Row,
        State,
        StatefulWidget,
        Text,
        TextStyle,
        Widget;

class Category3Widget extends StatefulWidget {
  const Category3Widget({super.key});

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
              padding: const EdgeInsets.only(right: 1, bottom: 1),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "CategoryPage");
                },
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/book_devonly.png"),
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
                    child: const Align(
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
              padding: const EdgeInsets.only(right: 1, bottom: 1),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "CategoryPage");
                },
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/book_devonly.png"),
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
                    child: const Align(
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
              padding: const EdgeInsets.only(right: 1, bottom: 1),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "CategoryPage");
                },
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/book_devonly.png"),
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
                    child: const Align(
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
              padding: const EdgeInsets.only(right: 1, bottom: 1),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "CategoryPage");
                },
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/book_devonly.png"),
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
                    child: const Align(
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
              padding: const EdgeInsets.only(right: 1, bottom: 1),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "CategoryPage");
                },
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/book_devonly.png"),
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
                    child: const Align(
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
              padding: const EdgeInsets.only(right: 1, bottom: 1),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "CategoryPage");
                },
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/book_devonly.png"),
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
                    child: const Align(
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
              padding: const EdgeInsets.only(right: 1, bottom: 1),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "CategoryPage");
                },
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/book_devonly.png"),
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
                    child: const Align(
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
              padding: const EdgeInsets.only(right: 1, bottom: 1),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "CategoryPage");
                },
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/book_devonly.png"),
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
                    child: const Align(
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
