import 'package:flutter/material.dart';
import 'package:shopbee/widgets/HomeScreens/FollowStoreWidget.dart';
import 'package:shopbee/widgets/HomeScreens/CategoryWidget.dart';
import 'package:shopbee/widgets/HomeScreens/HomePageProductWidget.dart';
import 'package:shopbee/globals.dart';
import 'dart:convert';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? jwtToken;
  final searchController = TextEditingController();
  Map<String, dynamic> categoryData = {};
  Map<String, dynamic> newBookData = {};
  Map<String, dynamic> popularBookData = {};
  Map<String, dynamic> storeListData = {};
  Map<String, dynamic> profileData = {};
  bool switchable = false;
  @override
  void initState() {
    _getToken().then((value) {
      getProfile().then((result) {
        setState(() {
          profileData = result;
          switchable = true;
        });
      });
    });
    super.initState();
  }

  Future<Map<String, dynamic>> getCategory() async {
    try {
      Response response = await get(
        Uri.parse(apiURL + 'api/v1/category/list'),
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

  Future<Map<String, dynamic>> getNewBook() async {
    try {
      Response response = await get(
        Uri.parse(apiURL + 'api/v1/product/list?limit=3'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        categoryData = responseBody;
        return responseBody;
      } else {
        print('failed new book');
      }
    } catch (e) {
      print(e.toString());
    }
    return categoryData;
  }

  Future<Map<String, dynamic>> getPopularBook() async {
    try {
      Response response = await get(
        Uri.parse(apiURL + 'api/v1/product/list?limit=3'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        categoryData = responseBody;
        return responseBody;
      } else {
        print('failed popular book');
      }
    } catch (e) {
      print(e.toString());
    }
    return categoryData;
  }

  Future<Map<String, dynamic>> getStoreList() async {
    try {
      Response response = await get(
        Uri.parse(apiURL + 'api/v1/user/list?role=retailer'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        storeListData = responseBody;
        return responseBody;
      } else {
        print('failed store list');
      }
    } catch (e) {
      print(e.toString());
    }
    return storeListData;
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (switchable)
      setState(() {
        _selectedIndex = index;
        if (index == 1) {
          Navigator.pushNamed(context, 'BrowsePage');
        }
        if (index == 2) {
          if (profileData['data']['role'] == 'buyer')
            Navigator.pushNamed(context, 'UncreatedStorePage');
          else {
            Navigator.pushNamed(context, 'MyStorePage');
          }
        }
        if (index == 3) {
          Navigator.pushNamed(context, 'OrderHistoryPage');
        }
        if (index == 4) {
          Navigator.pushNamed(context, 'ProfilePage');
        }
      });
  }

  Future<Map<String, dynamic>> getProfile() async {
    try {
      Response response = await get(
        Uri.parse(apiURL + 'api/v1/user/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        profileData = responseBody;
        return responseBody;
      } else {
        print('failed profile');
      }
    } catch (e) {
      print(e.toString());
    }
    return profileData;
  }

  // Function to set the JWT token
  Future<void> _setToken(String token) async {
    await setToken(token);
    setState(() {
      jwtToken = token;
    });
    print(jwtToken.toString());
  }

  // Function to get the JWT token
  Future<void> _getToken() async {
    String? token = await getToken();
    setState(() {
      jwtToken = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        backgroundColor: const Color(0xFF33907C),
        title: Column(
          children: [
            Row(
              children: [
                const Text(
                  'ShopBee',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    size: 30,
                  ),
                  onPressed: () {
                    //favorite shop button
                  },
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                  onPressed: () {
                    //navigate to cart button
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 11),
            FutureBuilder<Map<String, dynamic>>(
                future: getNewBook(), // function where you call your api
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  // AsyncSnapshot<Your object type>
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      color: Colors.grey,
                    );
                  } else {
                    if (snapshot.hasError)
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 165,
                          color: Colors.white,
                          child:
                              Center(child: Text('Error: ${snapshot.error}')));
                    else
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var adData in snapshot.data?['data'])
                              Container(
                                padding: const EdgeInsets.only(left: 16),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(adData['image']['url']),
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
                                      const SizedBox(height: 51),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 17),
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
                                      const SizedBox(height: 17),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 17),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, 'BrowsePage');
                                            },
                                            child: Container(
                                              width: 190,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                color: Colors.transparent,
                                                border: Border.all(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              child: const Align(
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
                      );
                  }
                }),
            const SizedBox(height: 16),
            FutureBuilder<Map<String, dynamic>>(
              future: getCategory(), // function where you call your api
              builder: (BuildContext context,
                  AsyncSnapshot<Map<String, dynamic>> snapshot) {
                // AsyncSnapshot<Your object type>
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    color: Colors.grey,
                  );
                } else {
                  if (snapshot.hasError)
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        color: Colors.white,
                        child: Center(child: Text('Error: ${snapshot.error}')));
                  else if (snapshot.data != null)
                    return Container(
                      height: MediaQuery.of(context).size.width / 2,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  for (int i = 0; i <= 3; i++)
                                    Center(
                                      child: CategoryWidget(
                                          rid: snapshot.data?['data'][i]['rid'],
                                          name: snapshot.data?['data'][i]
                                              ['name'],
                                          url: snapshot.data?['data'][i]
                                              ['image']['url']),
                                    ),
                                ],
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      for (int i = 4; i <= 7; i++)
                                        Center(
                                          child: CategoryWidget(
                                              rid: snapshot.data?['data'][i]
                                                  ['rid'],
                                              name: snapshot.data?['data'][i]
                                                  ['name'],
                                              url: snapshot.data?['data'][i]
                                                  ['image']['url']),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  else
                    return Text('No data');
                }
              },
            ),
            const SizedBox(height: 27),
            Row(
              children: [
                const SizedBox(width: 20),
                const Align(
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
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 22),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'BrowsePage');
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
            const SizedBox(height: 16),
            FutureBuilder<Map<String, dynamic>>(
                future: getNewBook(), // function where you call your api
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  // AsyncSnapshot<Your object type>
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 268,
                      color: Colors.grey,
                    );
                  } else {
                    if (snapshot.hasError)
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          color: Colors.white,
                          child:
                              Center(child: Text('Error: ${snapshot.error}')));
                    else
                      return Container(
                        height: 268,
                        child: GridView.count(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 12.35,
                          childAspectRatio: 1.219512,
                          primary: true,
                          physics: const ScrollPhysics(),
                          crossAxisCount: 1,
                          children: [
                            for (var product in snapshot.data?['data'])
                              HomePageProductWidget(
                                  id: product['id'],
                                  name: product['name'],
                                  price: product['price'],
                                  store: product['shop']['fullname'],
                                  url: product['image']['url']),
                          ],
                        ),
                      );
                  }
                }),
            const SizedBox(height: 27),
            Row(
              children: [
                const SizedBox(width: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Popular Product',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 22),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'BrowsePage');
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
            const SizedBox(height: 16),
            FutureBuilder<Map<String, dynamic>>(
                future: getPopularBook(), // function where you call your api
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  // AsyncSnapshot<Your object type>
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 268,
                      color: Colors.grey,
                    );
                  } else {
                    if (snapshot.hasError)
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          color: Colors.white,
                          child:
                              Center(child: Text('Error: ${snapshot.error}')));
                    else
                      return Container(
                        height: 268,
                        child: GridView.count(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 12.35,
                          childAspectRatio: 1.219512,
                          primary: true,
                          physics: const ScrollPhysics(),
                          crossAxisCount: 1,
                          children: [
                            for (var product in snapshot.data?['data'])
                              HomePageProductWidget(
                                  id: product['id'],
                                  name: product['name'],
                                  price: product['price'],
                                  store: product['shop']['fullname'],
                                  url: product['image']['url']),
                          ],
                        ),
                      );
                  }
                }),
            const SizedBox(height: 27),
            Container(
              height: 363,
              child: Stack(
                children: [
                  Container(
                    height: 210,
                    width: MediaQuery.of(context).size.width,
                    color: const Color(0xFF33907C),
                    child: Row(
                      children: [
                        const Padding(
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
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
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
                                child: const Align(
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
                  FutureBuilder<Map<String, dynamic>>(
                      future:
                          getStoreList(), // function where you call your api
                      builder: (BuildContext context,
                          AsyncSnapshot<Map<String, dynamic>> snapshot) {
                        // AsyncSnapshot<Your object type>
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 210,
                            color: Colors.grey,
                            child: Center(
                                child: Text('Please wait its loading...')),
                          );
                        } else {
                          if (snapshot.hasError)
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                height: 210,
                                color: Colors.white,
                                child: Center(
                                    child: Text('Error: ${snapshot.error}')));
                          else
                            return Padding(
                              padding: const EdgeInsets.only(top: 60),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: 268,
                                  child: GridView.count(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 12.35,
                                    childAspectRatio: 1.219512,
                                    primary: true,
                                    physics: const ScrollPhysics(),
                                    crossAxisCount: 1,
                                    children: [
                                      for (var storeData
                                          in snapshot.data?['data'])
                                        FollowStoreWidget(
                                            name: storeData['fullname'],
                                            id: storeData['id']),
                                    ],
                                  ),
                                ),
                              ),
                            );
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF33907C),
        items: const <BottomNavigationBarItem>[
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
        selectedItemColor: const Color(0xFF33907C),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
