import 'package:flutter/material.dart';

class EmptyStorePage extends StatefulWidget {
  @override
  State<EmptyStorePage> createState() => _EmptyStorePageState();
}

class _EmptyStorePageState extends State<EmptyStorePage> {
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
          Container(
            width: MediaQuery.of(context).size.height,
            height: 232,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Color(0xFF33907C),
                  foregroundColor: Colors.white,
                  //backgroundImage: NetworkImage("ADD URL HERE"),
                ),
                SizedBox(height: 16),
                Text(
                  'USER NAME HERE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 25,
                      width: 110,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF33907C),
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'EditStorePage');
                        },
                        child: Center(
                          child: Text(
                            "Edit Store",
                            style: TextStyle(
                              color: Color(0xFF33907C),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 17),
                    Container(
                      height: 25,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Color(0xFF33907C),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: InkWell(
                        onTap: () {
                          //Navigate to ViewStorePage
                        },
                        child: Center(
                          child: Text(
                            "View Store",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 27,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      //remove store button
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Remove Store',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Text(
            'You don\'t have product',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            height: 50,
            width: 220,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFF33907C),
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'AddProductPage');
              },
              child: Center(
                child: Text(
                  "Add Product",
                  style: TextStyle(
                    color: Color(0xFF33907C),
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
