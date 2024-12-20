import 'package:flutter/material.dart';
import 'restaurant.dart'; // Import the RestaurantPage
import 'dashboard.dart';
import 'cart_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> foodCourts = [
    {
      'name': '4th Floor, 9a, Twin Towers',
      'outlets': [
        {'name': 'Ruchi\'s', 'image': 'assets/images/ruchi.png'},
        {'name': 'Yo Punjab!', 'image': 'assets/images/yo.png'},
        {'name': 'Zen Chin', 'image': 'assets/images/zen.png'},
        {'name': 'Zaitoon', 'image': 'assets/images/yo.png'},
        {'name': 'Anjappar', 'image': 'assets/images/ruchi.png'},
      ],
    },
    {
      'name': '4a Food Court',
      'outlets': [
        {'name': 'Paradise Snacks', 'image': 'assets/images/zen.png'},
        {'name': 'Siyaram\'s', 'image': 'assets/images/zen.png'},
        {'name': 'Zingar', 'image': 'assets/images/zen.png'},
      ],
    },
    {
      'name': 'Food Court Building 8',
      'outlets': [
        {'name': 'Zomoz', 'image': 'assets/images/red_pasta.png'},
        {'name': 'Rajdhani', 'image': 'assets/images/red_pasta.png'},
        {'name': 'Zaibor', 'image': 'assets/images/red_pasta.png'},
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
            SizedBox(width: 8.0), // Spacing between the icon and text
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
        color: Colors.teal, // Set body background color to teal
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF127272), // Search bar background color
                  hintText: 'Search...',
                  hintStyle: const TextStyle(color: Colors.white), // Change hint text color to teal
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0), // Rounded corners
                    borderSide: BorderSide.none, // Removes the border
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide.none, // Removes the border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide.none, // Removes the border on focus
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
                      color: Colors.white, // Food court container background
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Colors.teal, // Teal border for each food outlet box
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          foodCourt['name'],
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal, // Text color
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
                                  // Navigate to the restaurant page on outlet click
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
                                    color: Colors.white, // Outlet box background
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: Colors.teal, // Border for outlet box
                                      width: 1.0,
                                    ),
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
                                      Text(
                                        outlet['name'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.teal, // Text color
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Image.asset(
                                        outlet['image'],
                                        width: 130.0,
                                        height: 90.0,
                                        fit: BoxFit.cover,
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
        currentIndex: 1, // Change this based on the page index
        backgroundColor: Colors.teal, // Navigation bar background
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        onTap: (index) {
          if (index == 0) {
            // Navigate to the Cart Screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          } else if (index == 1) {
            // Navigate to Home Page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 2) {
            // Navigate to Dashboard (replace DashboardPage with your screen)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Dashboard',
          ),
        ],
      ),
    );
  }
}
