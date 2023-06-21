import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:shopbee/widgets/Category2Widget.dart';
import 'package:shopbee/widgets/Category3Widget.dart';
import 'package:shopbee/widgets/FollowStoreWidget.dart';
import 'package:shopbee/widgets/ProductWidget.dart';
import 'package:shopbee/widgets/category1Widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  late int selectedPage;
  late final PageController _categoryController;
  @override
  void initState() {
    selectedPage = 0;
    _categoryController = PageController(initialPage: selectedPage);

    super.initState();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        //Navigator.pushNamed(context, 'BrowsePage');
      }
      if (index == 2) {
        Navigator.pushNamed(context, 'MyStorePage');
      }
      if (index == 3) {
        //Navigator.pushNamed(context, 'OrderHistoryPage');
      }
      if (index == 4) {
        //Navigator.pushNamed(context, 'ProfilePage');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F9FF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
        backgroundColor: Color(0xFF33907C),
        title: Column(
          children: [
            Row(
              children: [
                Text(
                  'ShopBee',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    size: 30,
                  ),
                  onPressed: () {
                    //favorite shop button
                  },
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                  onPressed: () {
                    //navigate to cart button
                  },
                ),
              ],
            ),
            SizedBox(height: 23),
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: TextFormField(
                autofocus: false,
                keyboardType: TextInputType.text,
                controller: searchController,
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFF13B58C),
                  ),
                  hintText: "Search Product",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 11),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < 3; i++)
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/book_devonly.png"),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      child: Container(
                        height: 165,
                        width: 302,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(65, 0, 0, 0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 51),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 17),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "READY TO DELIVER TO \nYOUR HOME",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 17),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 17),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: InkWell(
                                  onTap: () {
                                    //add start shopping function
                                  },
                                  child: Container(
                                    width: 147,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "START SHOPPING",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  PageView(
                    onPageChanged: (page) {
                      setState(() {
                        selectedPage = page;
                      });
                    },
                    controller: _categoryController,
                    children: <Widget>[
                      Center(
                        child: Category1Widget(),
                      ),
                      Center(
                        child: Category2Widget(),
                      ),
                      Center(
                        child: Category3Widget(),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 5),
                      child: PageViewDotIndicator(
                        currentItem: selectedPage,
                        count: 3,
                        unselectedColor: Colors.black26,
                        selectedColor: Colors.white,
                        duration: Duration(milliseconds: 200),
                        boxShape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 27),
            Row(
              children: [
                SizedBox(width: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'New Book',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 22),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: InkWell(
                      onTap: () {
                        //add start shopping function
                      },
                      child: Container(
                        width: 87,
                        height: 23,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Color(0xFF33907C),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "See All",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              height: 268,
              child: GridView.count(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                mainAxisSpacing: 15,
                crossAxisSpacing: 12.35,
                childAspectRatio: 1.219512,
                primary: true,
                physics: ScrollPhysics(),
                crossAxisCount: 1,
                children: [
                  for (int i = 0; i < 6; i++) ProductWidget(),
                ],
              ),
            ),
            SizedBox(height: 27),
            Row(
              children: [
                SizedBox(width: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Poppular Product',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 22),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: InkWell(
                      onTap: () {
                        //add start shopping function
                      },
                      child: Container(
                        width: 87,
                        height: 23,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Color(0xFF33907C),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "See All",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              height: 268,
              child: GridView.count(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                mainAxisSpacing: 15,
                crossAxisSpacing: 12.35,
                childAspectRatio: 1.219512,
                primary: true,
                physics: ScrollPhysics(),
                crossAxisCount: 1,
                children: [
                  for (int i = 0; i < 6; i++) ProductWidget(),
                ],
              ),
            ),
            SizedBox(height: 27),
            Container(
              height: 363,
              child: Stack(
                children: [
                  Container(
                    height: 210,
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xFF33907C),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 22, horizontal: 20),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Store to follow',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 22, horizontal: 16),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                //add start shopping function
                              },
                              child: Container(
                                width: 93,
                                height: 23,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.white,
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                      color: Color(0xFF33907C),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: 268,
                        child: GridView.count(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 12.35,
                          childAspectRatio: 1.219512,
                          primary: true,
                          physics: ScrollPhysics(),
                          crossAxisCount: 1,
                          children: [
                            for (int i = 0; i < 6; i++) FollowStoreWidget(),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF33907C),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subject),
            label: 'Order History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF33907C),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
