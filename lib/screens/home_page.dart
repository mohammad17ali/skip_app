import 'package:flutter/material.dart';
import 'restaurant.dart';
import 'dashboard.dart';
import 'cart_screen.dart';
import 'discover_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> foodCourts = [
    {
      'name': '4th Floor, 9a, Twin Towers',
      'outlets': [
        {'name': 'Ruchi\'s', 'image': 'assets/images/ruchi.png', 'description': 'New Restaurant'},
        {'name': 'Yo Punjab!', 'image': 'assets/images/yo.png', 'description': 'New Restaurant'},
        {'name': 'Zen Chin', 'image': 'assets/images/zen.png', 'description': 'New Restaurant'},
        {'name': 'Zaitoon', 'image': 'assets/images/yo.png', 'description': 'New Restaurant'},
        {'name': 'Anjappar', 'image': 'assets/images/ruchi.png', 'description': 'New Restaurant'},
      ],
    },
    {
      'name': 'Food Court Building 8',
      'outlets': [
        {'name': 'Zomoz', 'image': 'assets/images/red_pasta.png', 'description': 'New Restaurant'},
        {'name': 'Rajdhani', 'image': 'assets/images/red_pasta.png', 'description': 'New Restaurant'},
        {'name': 'Zaibor', 'image': 'assets/images/red_pasta.png', 'description': 'New Restaurant'},
      ],
    },
    {
      'name': '4a Food Court',
      'outlets': [
        {'name': 'Paradise Snacks', 'image': 'assets/images/zen.png', 'description': 'New Restaurant'},
        {'name': 'Siyaram\'s', 'image': 'assets/images/zen.png', 'description': 'New Restaurant'},
        {'name': 'Zingar', 'image': 'assets/images/zen.png', 'description': 'New Restaurant'},
      ],
    },
    {
      'name': 'Food Court Building 8',
      'outlets': [
        {'name': 'Zomoz', 'image': 'assets/images/red_pasta.png', 'description': 'New Restaurant'},
        {'name': 'Rajdhani', 'image': 'assets/images/red_pasta.png', 'description': 'New Restaurant'},
        {'name': 'Zaibor', 'image': 'assets/images/red_pasta.png', 'description': 'New Restaurant'},
      ],
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Row(
          children: const [
            Icon(
              Icons.location_on,
              color: Colors.white,
              size: 20.0,
            ),
            SizedBox(width: 8.0),
            Text(
              'Reliance Corporate Park, Ghansoli, Thane',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.teal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF005151),
                  hintText: 'Search...',
                  hintStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

            ),
            Expanded(
              child: ListView.builder(
                itemCount: foodCourts.length,
                itemBuilder: (context, index) {
                  final foodCourt = foodCourts[index];
                  return Container(
                    margin: const EdgeInsets.only(left: 6.0, right: 6.0, top: 8.0, bottom: 8.0),
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF0E7369),
                      borderRadius: BorderRadius.circular(8.0),

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          foodCourt['name'],
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Text color
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        SizedBox(
                          height: 150.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: foodCourt['outlets'].length,
                            itemBuilder: (context, outletIndex) {
                              final outlet = foodCourt['outlets'][outletIndex];
                              return GestureDetector(
                                onTap: () {

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RestaurantPage(
                                        restaurantName: outlet['name'],
                                        headerImageUrl: outlet['image'],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8.0),
                                  width: 150.0,
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(8.0),

                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4.0,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0), // Add padding above and below
                                        child: Text(
                                          outlet['name'],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white, // Text color
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Image.asset(
                                        outlet['image'],
                                        width: 130.0,
                                        height: 90.0,
                                        fit: BoxFit.cover,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 2.0), // Add padding above and below
                                        child: Text(
                                          outlet['description'],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white, // Text color
                                            fontSize: 10.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Change this based on the page index
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.teal,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xFF005151),
        onTap: (index) {
          if (index == 0) {} else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DiscoverPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.podcasts_rounded), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
