import 'package:flutter/material.dart';

class RestaurantPage extends StatefulWidget {
  final String restaurantName;
  final String headerImageUrl;

  const RestaurantPage({
    Key? key,
    required this.restaurantName,
    required this.headerImageUrl,
  }) : super(key: key);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  ScrollController _scrollController = ScrollController();
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    setState(() {
      _opacity = 1 - (_scrollController.offset / 200).clamp(0.0, 1.0);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
        backgroundColor: const Color(0xFF0B885C),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    // Fadeable Display Image and Title
                    SliverAppBar(
                      expandedHeight: 200,
                      pinned: false,
                      flexibleSpace: Opacity(
                        opacity: _opacity,
                        child: FlexibleSpaceBar(
                          background: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                widget.headerImageUrl,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                color: Colors.black38,
                                alignment: Alignment.topLeft, 
                                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0), 
                                child: Text(
                                  widget.restaurantName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 42,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Content with Rounded Corners
                    SliverToBoxAdapter(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),

                            // Search Bar
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 1.5),
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                child: const TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    hintText: 'Search in restaurant',
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Food Items List
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: foodItems.length,
                              itemBuilder: (context, index) {
                                final item = foodItems[index];
                                return FoodItemTile(item: item);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        backgroundColor: const Color(0xFF0B885C),
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

final List<Map<String, dynamic>> foodItems = [
  {
    'image': 'assets/images/deluxe.png',
    'name': 'Deluxe Thali',
    'detail': 'Veg Fried Rice, Butter Naan, Gulab Jamun, Rajma Dal',
    'price': '120',
  },
  {
    'image': 'assets/images/super_ssver.png',
    'name': 'Super Saver Thali',
    'detail': 'Veg Fried Rice, Roti, Jalebi, Rajma Dal',
    'price': '120',
  },
  {
    'image': 'assets/images/red_pasta.png',
    'name': 'Red Sauce Pasta',
    'detail': 'Freshly prepared Red Sauce Pasta',
    'price': '100',
  },
  {
    'image': 'assets/images/white_pasta.png',
    'name': 'White Sauce Pasta',
    'detail': 'Freshly prepared White Sauce Pasta',
    'price': '100',
  },
  {
    'image': 'assets/images/red_pasta.png',
    'name': 'Red Sauce Pasta',
    'detail': 'Freshly prepared Red Sauce Pasta',
    'price': '100',
  },
  {
    'image': 'assets/images/deluxe.png',
    'name': 'Deluxe Thali',
    'detail': 'Veg Fried Rice, Butter Naan, Gulab Jamun, Rajma Dal',
    'price': '120',
  },
  {
  'image': 'assets/images/deluxe.png',
  'name': 'Deluxe Thali',
  'detail': 'Veg Fried Rice, Butter Naan, Gulab Jamun, Rajma Dal',
  'price': '120',
  },
];

// Food Item Widget
class FoodItemTile extends StatelessWidget {
  final Map<String, dynamic> item;

  const FoodItemTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(

              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
              child: Image.asset(
                item['image'],
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
              
            ),


            // Text Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['detail'],
                      style: const TextStyle(
                          fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            // Price and Add Button
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rs ${item['price']}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF0B885C),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
