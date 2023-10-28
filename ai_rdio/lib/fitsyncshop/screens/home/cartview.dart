import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Products {
  final String name;
  final String description;
  final String imageUrl;
  final double price;

  Products({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });
}

class ProductCartScreen extends StatelessWidget {
  final List<Products> products = [
    Products(
      name: 'Product 1',
      description: 'Description of Product 1',
      imageUrl: 'assets/images/bag_1.png',
      price: 19.99,
    ),
    Products(
      name: 'Product 1',
      description: 'Description of Product 1',
      imageUrl: 'assets/images/bag_1.png',
      price: 19.99,
    ),
    Products(
      name: 'Product 1',
      description: 'Description of Product 1',
      imageUrl: 'assets/images/bag_1.png',
      price: 19.99,
    ),
    Products(
      name: 'Product 1',
      description: 'Description of Product 1',
      imageUrl: 'assets/images/bag_1.png',
      price: 19.99,
    ),
    Products(
      name: 'Product 1',
      description: 'Description of Product 1',
      imageUrl: 'assets/images/bag_1.png',
      price: 19.99,
    ),
    Products(
      name: 'Product 1',
      description: 'Description of Product 1',
      imageUrl: 'assets/images/bag_1.png',
      price: 19.99,
    ),
    // Add more products here
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('FitSync-Cart',
            style: TextStyle(color: Colors.black, letterSpacing: 1)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                // Handle the "Buy Now" action
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Background color
                onPrimary: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart, // Add your desired buy icon here
                    size: 30, // Adjust the icon size as needed
                    color: Colors.white, // Icon color
                  ),
                  SizedBox(width: 10), // Add space between icon and text
                  Text(
                    'Buy Now',
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class ProductCard extends StatelessWidget {
  final Products product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Adjust elevation for shadow
      margin: EdgeInsets.all(10), // Add margin for spacing
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end, // Align to the bottom
        children: [
          // Left side with image
          Container(
            width: 150, // Adjust the image width as needed
            child: Image.asset(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          // Right side with text and button
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    product.description,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle adding to cart or any other action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(
                            255, 216, 57, 57), // Background color
                        foregroundColor:
                            const Color.fromARGB(255, 43, 38, 38), // Text color
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10), // Button padding
                        elevation: 5, // Elevation
                      ),
                      child: Text('Remove'),
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
}
