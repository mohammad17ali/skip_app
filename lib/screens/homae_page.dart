import 'package:flutter/material.dart';

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
        title: Text(
          'Reliance Corporate Park, Ghansoli, Thane - 400701',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: const Color(0xFF008000),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Color(0xFF008000), width: 2.0),
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
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF008000), // Green background for food court container
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
                          color: Colors.white, // White text for food court name
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
                            return Container(
                              margin: const EdgeInsets.only(right: 8.0),
                              width: 150.0,
                              decoration: BoxDecoration(
                                color: Colors.white, // White background for outlet box
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
                                  Text(
                                    outlet['name'],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFF008000), // Green text for outlet name
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        backgroundColor: const Color(0xFF008000),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
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
