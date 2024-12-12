import 'package:flutter/material.dart';

class RestaurantPage extends StatefulWidget {
  @override
  _RestaurantPageState createState() =>
_RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  double _scrollPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Top Bar
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 24.0),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('4th Floor, Rg Twin Towers'),
                  Icon(Icons.search),
                ],
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LayoutBuilder(
              builder: (context,constraints) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: constraints.maxHeight * (1-_scrollPosition / 300),
                  child: Image.asset(
                    'assets/ruchi.jpg',
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        Positioned(
          top: 300.0,
          left: 0,
          right: 0,
          bottom: 0,
          child: ListView(
            children: [
              _buildMenuItem(
                    
