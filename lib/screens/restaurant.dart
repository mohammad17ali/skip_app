import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product({required this.name, required this.price, required this.imageUrl});
}

class DynamicShopPage extends StatefulWidget {
  final String headerImageUrl;

  const DynamicShopPage({Key? key, required this.headerImageUrl}) : super(key: key);

  @override
  _DynamicShopPageState createState() => _DynamicShopPageState();
}

class _DynamicShopPageState extends State<DynamicShopPage> {
  final ScrollController _scrollController = ScrollController();
  double _headerOpacity = 1.0;

  final List<Product> _products = [
    Product(
      name: 'Deluxe Thai',
      price: 120,
      imageUrl: 'https://via.placeholder.com/100',
    ),
    Product(
      name: 'Super Saver Thai',
      price: 120,
      imageUrl: 'https://via.placeholder.com/100',
    ),
    Product(
      name: 'Red Sauce Pasta',
      price: 100,
      imageUrl: 'https://via.placeholder.com/100',
    ),
    Product(
      name: 'White Sauce Pasta',
      price: 100,
      imageUrl: 'https://via.placeholder.com/100',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    setState(() {
      _headerOpacity = 1.0 - (_scrollController.offset / 200).clamp(0.0, 1.0);
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
        title: const Text('RCP, Ghansoli, Navi Mumbai',
                         style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),),
        backgroundColor: Colors.green,
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Opacity(
                      opacity: _headerOpacity,
                      child: Image.network(
                        'https://via.placeholder.com/600x250',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Opacity(
                        opacity: _headerOpacity,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Ruchi's",
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search in restaurant',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final product = _products[index];
                return Card(
                  color: Colors.green[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    tileColor: Colors.white,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        product.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(product.name),
                    subtitle: Text('Rs ${product.price.toStringAsFixed(2)}'),
                    trailing: StatefulBuilder(
                      builder: (context, setState) {
                        bool isAdded = false;
                        return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isAdded = !isAdded;
                            });
                          },
                          child: Text(isAdded ? 'Added' : 'Add'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isAdded ? Colors.lightBlue : Colors.green,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              childCount: _products.length, // Fixed placement of childCount
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DynamicShopPage(
      headerImageUrl: 'https://via.placeholder.com/600x250',
    ),
  ));
}
