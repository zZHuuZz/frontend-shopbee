import 'package:flutter/material.dart';

class UncreatedStorePage extends StatefulWidget {
  @override
  State<UncreatedStorePage> createState() => _UncreatedStorePageState();
}

class _UncreatedStorePageState extends State<UncreatedStorePage> {
  int _selectedIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushNamed(context, 'HomePage');
      }
      if (index == 1) {
        //Navigator.pushNamed(context, 'BrowsePage');
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        backgroundColor: Color(0xFF33907C),
        title: Row(
          children: [
            Text(
              'My Store',
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
      ),
      body: Column(
        children: [
          SizedBox(height: 80),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "images/mystore.png",
            ),
          ),
          SizedBox(height: 30),
          Text(
            'You Don\'t Have a Store',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 40),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'CreateStorePage');
            },
            child: Container(
              height: 50,
              width: 210,
              decoration: BoxDecoration(
                color: Color(0xFF33907C),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  "Create store",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
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
