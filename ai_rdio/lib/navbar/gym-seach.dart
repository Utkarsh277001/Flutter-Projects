import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Utils/Constant.dart';
import 'datetime copy.dart';
import 'datetime.dart';

class Gym {
  final String name;
  final String location;
  final String imageUrl;

  Gym({required this.name, required this.location, required this.imageUrl});
}

class GymListScreen extends StatefulWidget {
  @override
  _GymListScreenState createState() => _GymListScreenState();
}

class _GymListScreenState extends State<GymListScreen> {
  List<gymData> _gyms = [];
  bool _loading = true;
  String _searchText = '';

  // void fetchGyms() async {
  //   setState(() {
  //     _loading = true;
  //   });

  // Replace the URL with the actual API endpoint

  Future<void> gymSearch(String searchText) async {
    // EasyLoading.show(status: "Retriving User's History..");
    final response = await http
        .get(Uri.parse('${Constant.url}/gymInfo/searchGym/' + searchText));

    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.statusCode);
      setState(() {
        _gyms = (json.decode(response.body) as List)
            .map((data) => gymData.fromJson(data))
            .toList();

        // var res = json.decode(response.body);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void search(String searchText) async {
    setState(() {
      _searchText = searchText;
      _loading = true;
    });
    await gymSearch(_searchText);

    setState(() {
      _loading = false;
    });
  }
  // Replace the URL with the actual API endpoint and query parameters
  // http
  //     .get(Uri.parse('${Constant.url}/searchGym/$searchText'))
  //     .then((response) {
  //   if (response.statusCode == 200) {
  //     final decoded = jsonDecode(response.body);
  //     final List<Gym> gyms = (decoded['gyms'] as List<dynamic>).map((gym) {
  //       return Gym(
  //         name: gym['gymName'],
  //         location: gym['City'],
  //         imageUrl: gym['Image'],
  //       );
  //     }).toList();

  //       setState(() {
  //         _gyms = gyms;
  //         _loading = false;
  //       });
  //     } else {
  //       throw Exception('Failed to load gyms');
  //     }
  //   });
  // }

  // List<Gym> get filteredGyms {
  //   if (_searchText.isEmpty) {
  //     return [];
  //   } else {
  //     return _gyms.where((gym) {
  //       return gym.location.toLowerCase().contains(_searchText.toLowerCase());
  //     }).toList();
  //   }
  // }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'Search by location',
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              suffixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            onSubmitted: search,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: _searchText.isEmpty
          ? SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Image.asset(
                      'assets/images/search-gym.png',
                      height: size.height * 0.5,
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 247, 246, 246),
                        borderRadius: BorderRadius.circular(21),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: size.width / 1.15,
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    "Find the Gyms",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "by location",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : _loading
              ? Center(child: CircularProgressIndicator())
              : _gyms.isEmpty
                  ? Center(child: Text('No gyms found'))
                  : ListView.builder(
                      itemCount: _gyms.length,
                      itemBuilder: (context, index) {
                        var gym = _gyms[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GymPageDate3(
                                          gymDetail: gym,
                                        )));
                          },
                          child: Container(
                            margin: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image(
                                  image: NetworkImage(gym.image),
                                  width: 500,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        gym.gymName,
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        gym.location,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}

class gymData {
  final String ownerEmail;
  final String image;
  final String gymName;
  final String location;
  // Add this line

  gymData({
    // required this.image,
    required this.ownerEmail,
    required this.gymName,
    required this.location,
    required this.image, // Add this line
  });

  factory gymData.fromJson(Map<String, dynamic> json) {
    return gymData(
      // image: json[''],
      ownerEmail: json['ownerEmail'],
      gymName: json['gymName'], // Change this line to match your response key
      location: '${json['City'] ?? " "} , ${json['State'] ?? " "}',
      image: json['Image'] ?? "0",
      // Add this line and set default value to empty string if null
    );
  }
}
