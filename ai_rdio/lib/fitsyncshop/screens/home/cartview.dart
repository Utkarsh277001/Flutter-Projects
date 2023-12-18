import 'dart:convert';

import 'package:ai_rdio/Utils/Constant.dart';
import 'package:ai_rdio/fitsyncshop/screens/home/addressScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductCartScreen extends StatefulWidget {
  @override
  State<ProductCartScreen> createState() => _ProductCartScreenState();
}

class _ProductCartScreenState extends State<ProductCartScreen> {
  List<cartInfo> _cartData = [];
  String productIds = '';

  Future<void> _getcart() async {
    EasyLoading.show(status: 'Loading your Cart...');
    final prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString("email")!;
    String url = '${Constant.url}/cart/userCart/' + userEmail;
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // var jsonData = json.decode(response.body);
        EasyLoading.dismiss();
        setState(() {
          _cartData = (json.decode(response.body) as List)
              .map((data) => cartInfo.fromJson(data))
              .toList();
          print("successfully retrive");
          for (int i = 0; i < _cartData.length; i++) {
            cartInfo cartItem = _cartData[i];
            if (i == 0) {
              productIds = cartItem.id;
            } else {
              productIds = productIds + "," + cartItem.id;
            }
          }
          print("all Ids :" + productIds);
          print(_cartData);
        });
      } else {
        print('Failed to load gyms: ${response.statusCode}');
      }
    } catch (error) {
      print('Error loading gyms: $error');
    }
  }

  double calculateTotalPrice() {
    return _cartData
        .map((cart) => cart.getPriceValue())
        .fold(0, (value, element) => value + element);
  }

  // A flag to determine whether to show the card or not
  bool showCard = true;
  Key cardKey = UniqueKey();
  // Function to remove the card and trigger a refresh
  void removeCard() {
    setState(() {
      showCard = false;
      cardKey = UniqueKey();
    });
  }

  @override
  void initState() {
    super.initState();
    _getcart();
    // Concatenate the product IDs

    // Print the concatenated IDs for verification
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('FitSync-Cart',
                style: TextStyle(color: Colors.black, letterSpacing: 1)),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: _cartData.isEmpty
              ? Center(
                  child: Text(
                    'Your cart is empty!',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                )
              : Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: _cartData.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: _cartData[index],
                            onRemove: removeCard,
                            key: cardKey,
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Cart Value: ₹${calculateTotalPrice().toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => AddressScreen(
                                    productids: productIds,
                                    price: calculateTotalPrice()
                                        .toStringAsFixed(2),
                                  )));

                          // Handle the "Buy Now" action
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 0, 0, 0),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                        child: Text('          Buy Now          '),
                      ),
                    ),
                  ],
                ),
        ));
  }
}

class ProductCard extends StatelessWidget {
  final cartInfo product;
  final VoidCallback onRemove;
  Future<void> removeItem() async {
    EasyLoading.show(status: 'Removing cart item :' + product.name);
    final prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString("email")!;
    String productid = product.id;
    try {
      EasyLoading.show(status: 'Adding Details ...');
      http.Response res = await http.post(
        Uri.parse('${Constant.url}/cart/removeItem'),
        body: jsonEncode({'useremail': userEmail, 'productid': productid}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if (res.statusCode == 200) {
        EasyLoading.showSuccess('Removed Successfully..');
        EasyLoading.dismiss();
      } else {
        EasyLoading.showError('error in removing...');
        EasyLoading.dismiss();
      }
    } catch (error) {
      print('Error : $error');
    }
  }

  ProductCard({required this.product, required this.onRemove, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 255, 254, 254),
      borderOnForeground: true,
      shadowColor: Color.fromRGBO(231, 229, 229, 0.98),
      elevation: 35, // Adjust elevation for shadow
      margin: EdgeInsets.all(20), // Add margin for spacing
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end, // Align to the bottom
        children: [
          // Left side with image
          Expanded(
            child: Container(
              width: 300, // Set the desired width for the small box
              height: 150, // Set the desired height for the small box
              child: Hero(
                tag: "${product.id}",
                child: Image.network(
                  product.pic,
                  fit: BoxFit.cover, // You can adjust the fit as needed
                ),
              ),
            ),
          ),
          // Right side with text and button
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    product.id,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '₹' + product.price,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle adding to cart or any other action
                        onRemove();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ProductCartScreen()));
                        removeItem();
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

class cartInfo {
  var id;

  final String price;

  final String name;

  final String pic;

  cartInfo({
    required this.id,
    required this.price,
    required this.name,
    required this.pic,
  });

  factory cartInfo.fromJson(Map<String, dynamic> json) {
    return cartInfo(
      id: json['productid'],
      price: json['price'],
      name: json['productname'],
      pic: json['image'],
    );
  }
  double getPriceValue() {
    return double.tryParse(price) ?? 0.0;
  }
}
