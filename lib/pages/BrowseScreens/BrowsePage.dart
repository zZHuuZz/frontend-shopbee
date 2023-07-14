import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopbee/widgets/BrowseScreens/BrowseItemsWidget.dart';

class BrowsePage extends StatefulWidget {
  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  final searchController = TextEditingController();
  late int selectedPage;

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushNamed(context, 'HomePage');
      }
      if (index == 2) {
        Navigator.pushNamed(context, 'MyStorePage');
      }
      if (index == 3) {
        Navigator.pushNamed(context, 'OrderHistoryPage');
      }
      if (index == 4) {
        Navigator.pushNamed(context, 'ProfilePage');
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
        elevation: 0,
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: 56,
              color: Color(0xFF33907C),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 112,
                    height: 31,
                    child: Row(
                      children: [
                        Container(
                          width: 112,
                          height: 31,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.sortAmountDown,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Sort by",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.transparent,
                              border: Border.all(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 112,
                    height: 31,
                    child: Row(
                      children: [
                        Container(
                          width: 112,
                          height: 31,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.mapMarkerAlt,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Location",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.transparent,
                              border: Border.all(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 112,
                    height: 31,
                    child: Row(
                      children: [
                        Container(
                          width: 112,
                          height: 31,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.listSquares,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Catagory",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.transparent,
                              border: Border.all(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            BrowseItemsWidget(),
            SizedBox(height: 30),
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
