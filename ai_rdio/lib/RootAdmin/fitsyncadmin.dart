import 'package:ai_rdio/RootAdmin/adminproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../Utils/Constant.dart';

class fitsyncadmin extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<fitsyncadmin> {
  bool _hasRegisteredGym = true;
  List<productInfo> _productData = [];
  String ownerName = '';
  String ownerEmail = '';
  String totalgym = '';

  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: 'Loading Gym details...');
    _getGyms();
  }

  Future<void> delete(String id) async {
    EasyLoading.show(status: "removing ptoduct Id :" + id);
    String url = '${Constant.url}/shop/remove/' + id;
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // var jsonData = json.decode(response.body);

        setState(() {
          EasyLoading.dismiss();
        });
      } else {
        print('Failed to load gyms: ${response.statusCode}');
      }
      setLen();
    } catch (error) {
      print('Error loading gyms: $error');
    }
  }

  Future<void> _getGyms() async {
    String url = '${Constant.url}/shop/getProduct';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // var jsonData = json.decode(response.body);
        EasyLoading.dismiss();
        setState(() {
          _productData = (json.decode(response.body) as List)
              .map((data) => productInfo.fromJson(data))
              .toList();
          print("successfully retrive");
          print(_productData);
          print(_productData.length);
          _hasRegisteredGym = true;
        });
      } else {
        _hasRegisteredGym = false;
        print('Failed to load gyms: ${response.statusCode}');
      }
      setLen();
    } catch (error) {
      print('Error loading gyms: $error');
    }
  }

  Future<void> setLen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('len', _productData.length.toString());
    totalgym = prefs.getString('len') ?? '';
    print("total Gym");
    print(totalgym);
  }

  @override
  Widget build(BuildContext context) {
    print(ownerEmail);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Fitsync Products",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
        ),
        actions: [
          Container(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // Navigate to gym registration screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => productRegistration()));
                EasyLoading.dismiss();
              },
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: _hasRegisteredGym
          ? ListView.builder(
              itemCount: _productData.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => GymOwnerPage(
                    //               gymData: _gymData[index],
                    //             )));
                    // print(_gymData[index]);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    height: MediaQuery.of(context).size.width *
                        0.4, // set the height to be more than width
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(_productData[index].pic),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    // _gymData[index]["gymName"] as String,
                                    _productData[index].id,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.category,
                                      size: 18, color: Colors.white),
                                  SizedBox(width: 5),
                                  Text(
                                    // _gymData[index]["City"] as String,
                                    _productData[index].category,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 3,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.currency_rupee_sharp,
                                      size: 16, color: Colors.white),
                                  SizedBox(width: 0),
                                  Text(
                                    // _gymData[index]["gymName"] as String,
                                    _productData[index].price,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.shape_line,
                                      size: 18, color: Colors.white),
                                  SizedBox(width: 5),
                                  Text(
                                    // _gymData[index]["City"] as String,
                                    _productData[index].size,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        delete(_productData[index].id);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    fitsyncadmin()));

                                        // Handle adding to cart or any other action
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromARGB(255,
                                            216, 57, 57), // Background color
                                        foregroundColor: const Color.fromARGB(
                                            255, 43, 38, 38), // Text color
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 5), // Button padding
                                        elevation: 5, // Elevation
                                      ),
                                      child: Text(
                                        'Remove',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    )
                                  ])
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images2/no-gym.jpg'),
                Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        'You have not registered any gym!',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          print("logout");

                          // TODO: Implement logout functionality
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => GymRegistrationPage()));
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.app_registration, color: Colors.white),
                            SizedBox(width: 12),
                            Text('Register Now',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 10.0),
                          minimumSize: Size(300, 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class productInfo {
  var id;
  final String category;
  final String price;

  final String size;

  final String description;

  var color;
  final String pic;

  productInfo({
    required this.id,
    required this.category,
    required this.price,
    required this.size,
    required this.description,
    required this.color,
    required this.pic,
  });

  factory productInfo.fromJson(Map<String, dynamic> json) {
    return productInfo(
      id: json['productid'],
      category: json['category'],
      price: json['price'],
      size: json['size'],
      description: json['description'],
      color: json['color'],
      pic: json['image'],
    );
  }
}
