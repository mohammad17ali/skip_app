//for code that has been uppdated in other pages, kept here for reference

import 'package:flutter/material.dart';
import 'restaurant.dart';
import 'dashboard.dart';
import 'cart_screen.dart';
import 'discover_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FoodCourt {
  final String name;
  final List<FoodOutlet> outlets;

  FoodCourt({required this.name, required this.outlets});

  factory FoodCourt.fromJson(Map<String, dynamic> json, List<FoodOutlet> outlets) {
    return FoodCourt(
      name: json['Location'] ?? 'Unknown',
      outlets: outlets,
    );
  }
}

class FoodOutlet {
  final String name;
  final String image;
  final String description;

  FoodOutlet({required this.name, required this.image, required this.description});

  factory FoodOutlet.fromJson(Map<String, dynamic> json) {
    return FoodOutlet(
      name: json['Name'] ?? 'Unknown',
      image: json['Image'][0]['url'] ?? '', 
      description: json['Email'] ?? 'No Description', 
    );
  }
}

class ApiService {
  final String baseUrl = "https://api.airtable.com/v0/appWaAdFLtWA1IAZM";
  final String apiKey = "patzNvGWYxouHH7jg.b49f04a995fcfa59000d900f4cb99194420f8be7682035a50d9713737cabf01a";

  Future<List<FoodCourt>> fetchFoodCourts() async {
    final url = Uri.parse('$baseUrl/Locations');
    final headers = {"Authorization": "Bearer $apiKey"};
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<FoodCourt> foodCourts = [];

      for (var record in data['records']) {
        var location = record['fields'];
        List<FoodOutlet> outlets = await fetchFoodOutlets(location['Location_ID']);
        foodCourts.add(FoodCourt.fromJson(location, outlets));
      }

      return foodCourts;
    } else {
      throw Exception('Failed to load food courts');
    }
  }

  Future<List<FoodOutlet>> fetchFoodOutlets(String locationId) async {
    final url = Uri.parse('$baseUrl/Outlets?filterByFormula=Location_ID="$locationId"');
    final headers = {"Authorization": "Bearer $apiKey"};
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<FoodOutlet> outlets = [];

      for (var record in data['records']) {
        outlets.add(FoodOutlet.fromJson(record['fields']));
      }

      return outlets;
    } else {
      throw Exception('Failed to load food outlets');
    }
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<FoodCourt>> foodCourts;

  @override
  void initState() {
    super.initState();
    foodCourts = ApiService().fetchFoodCourts();
  }

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
      body: FutureBuilder<List<FoodCourt>>(
        future: foodCourts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No food courts available'));
          } else {
            final foodCourts = snapshot.data!;

            return Container(
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
                                foodCourt.name,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white, 
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              SizedBox(
                                height: 150.0,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: foodCourt.outlets.length,
                                  itemBuilder: (context, outletIndex) {
                                    final outlet = foodCourt.outlets[outletIndex];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => RestaurantPage(
                                              restaurantName: outlet.name,
                                              headerImageUrl: outlet.image,
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
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: Text(
                                                outlet.name,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.white, 
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Image.network(
                                              outlet.image,
                                              width: 130.0,
                                              height: 90.0,
                                              fit: BoxFit.cover,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 2.0),
                                              child: Text(
                                                outlet.description,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.white, 
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
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.teal,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xFF005151),
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
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


//main
import 'package:flutter/material.dart';
import 'screens/intro.dart'; // I

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skip App',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const IntroScreen(), 
    );
  }
}

//krbr
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(const RestaurantHomePage());
  });
}
