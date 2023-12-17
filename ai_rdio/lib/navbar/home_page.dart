import 'dart:convert';

import 'package:ai_rdio/navbar/datetime.dart';
import 'package:ai_rdio/navbar/search_page.dart';
import 'package:flutter/material.dart';

import 'package:ai_rdio/widgets/app_large_text.dart';
import 'package:ai_rdio/widgets/app_text.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ai_rdio/navbar/NavBar.dart';

import 'package:http/http.dart' as http;

import '../Exercise/cardio.dart';
import '../Utils/Constant.dart';
import 'gym-seach.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  var images = {
    "cycling.gif": {'name': 'Cardio', 'link': '/CardioExercisePage'},
    "wristcurl.gif": {'name': 'Arms', 'link': '/BicepsExercisePage'},
    "pull.gif": {'name': 'Back', 'link': '/MeditationExercisePage'},
    "benchpress.gif": {'name': 'Chest', 'link': '/PullExercisePage'},
    "jumpsquat.gif": {'name': 'Legs', 'link': '/LegsExercisePage'},
    "dumbbelllateralraise.gif": {
      'name': 'Shoulder',
      'link': '/ShoulderExercisePage'
    }

    // "run-duo.png": "run-duo",
    // "run.png": "run"
  };
  List<gymDetails> gymdetails = [];
  List<Location> location = [];

  Future<Location?> fetchCoordinates() async {
    var url = Uri.parse('${Constant.url}/gymInfo/allGymData');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Location.fromJson(data);
    } else {
      return null; // Handle the error or return a default value
    }
  }

  Future<void> getGymDetails() async {
    var url = Uri.parse('${Constant.url}/gymInfo/allGymData');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      setState(() {
        gymdetails = (json.decode(response.body) as List)
            .map((data) => gymDetails.fromJson(data))
            .toList();
        print(gymdetails);
      });
    } else {
      print('Request failed with ${response.statusCode}.');
    }
  }

  var inspiration = {
    "gaurav-taneja.png": {
      'no': 1,
      "name": "Gaurav Taneja",
      "occupation": "Youtuber",
      "link": "https://www.youtube.com/c/FlyingBeast320"
    },
    "pranit.png": {
      'no': 2,
      "name": "Pranit Shilimkar",
      "occupation": "Youtuber",
      "link": "https://www.youtube.com/channel/UCgCP6fPIE9DHnzNL2Gqffzw"
    },
    "ranveer.png": {
      'no': 3,
      "name": "Ranveer",
      "occupation": "Youtuber",
      "link": "https://www.youtube.com/c/BeerBicepsOfficial"
    },
    "natasha.png": {
      'no': 4,
      "name": "Natasha Noel",
      "occupation": "Youtuber",
      "link": "http://youtube.com/channel/UCAiKzCKUkA217-m_SuZFzjg/"
    },
    "atul.png": {
      'no': 5,
      "name": "Atul Kumar Verma",
      "occupation": "Youtuber",
      "link": "https://www.youtube.com/c/FitnessRockersIndia"
    },
    "yash.png": {
      'no': 6,
      "name": "Yash Sharma",
      "occupation": "Youtuber",
      "link": "https://www.youtube.com/@YashSharmaFitness"
    },
    "sapna.png": {
      'no': 7,
      "name": "Sapna Vyas",
      "occupation": "Youtuber",
      "link": "https://www.youtube.com/c/CoachSapna"
    },
    "luke.png": {
      'no': 8,
      "name": "Luke Coutinho",
      "occupation": "Youtuber",
      "link": "https://www.youtube.com/c/panghalfitness"
    },
    "namrata.png": {
      'no': 9,
      "name": "Namrata Purohit",
      "occupation": "Youtuber",
      "link": "https://www.youtube.com/c/NamrataPurohitOfficial"
    },
    "yasmin.png": {
      'no': 10,
      "name": "Yasmin Karachiwala",
      "occupation": "Youtuber",
      "link": "https://www.youtube.com/user/Yasminbodyimage"
    },
    // 'abhishek.jpeg': 'https://youtu.be/orfo8JAJ-9M',
    // 'nitin.jpeg': 'https://youtu.be/xMj3NwJa6iI',
    // 'jeetshlal.jpeg': 'https://youtu.be/uYkpTWfpFHA',
    // 'yatinder.jfif':
    //     'https://www.youtube.com/watch?v=YJRjyK3Cxlg&ab_channel=YatinderSingh',
    // 'mukeshh.jfif':
    //     'https://www.youtube.com/watch?v=v6GkCsOzEPU&ab_channel=TEDxTalks',
  };

  //Api Inspiration data

  //  Future<void> inspirationapi() async{
  //   final response =await  http.get(Uri.parse())
  //  }

  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: 'Fetching gym...');
    getGymDetails();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      drawer: NavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              toolbarHeight: 55,
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      // color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(60),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/logo-u.png"),
                      )),
                ),
              ],
            ),

            SizedBox(
              height: 12,
            ),
            //Discover text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: AppLargeText(text: "Discover"),
                ),
                Container(
                  // height: 30,
                  // width: 200,
                  height: screenWidth * 0.1, // Adjust according to your needs
                  width: screenWidth * 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GymListScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        Text('Search More gyms',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),

            //tab-bar
            Container(
                child: Align(
              alignment: Alignment.center,
              child: TabBar(
                labelPadding: const EdgeInsets.only(left: 60, right: 60),
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: CircleTabIndicator(color: Colors.black, radius: 4),
                tabs: [
                  Tab(text: "Places"),
                  Tab(text: "Inspiration"),
                  // Tab(text: "Emotions"),
                ],
              ),
            )),
            SizedBox(
              height: 7,
            ),
            //dynamic-data tabbar
            Container(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              // height: 330,
              height: screenWidth * 0.9,
              width: double.infinity,
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    itemCount: gymdetails.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GymPageDate(gymDetail: gymdetails[index]),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 20, top: 10),
                          width: 210,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),

                            // color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(gymdetails[index].image),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          gymdetails[index].gymName as String,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(Icons.location_on,
                                            size: 18, color: Colors.white),
                                        SizedBox(width: 5),
                                        Text(
                                          gymdetails[index].location as String,
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
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  //inspiration
                  ListView.builder(
                    itemCount: inspiration.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () => launch(inspiration.values
                            .elementAt(index)['link'] as String),
                        child: Container(
                          margin: const EdgeInsets.only(right: 20, top: 10),
                          width: 210,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage("assets/images/" +
                                  inspiration.keys.elementAt(index)),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          inspiration.values
                                                  .elementAt(index)['name']
                                              as String,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(Icons.work,
                                            size: 18, color: Colors.white),
                                        SizedBox(width: 5),
                                        Text(
                                          inspiration.values.elementAt(
                                              index)['occupation'] as String,
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
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),

            //Explore text
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppLargeText(
                    text: "Explore",
                    size: 25,
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),

            //explore list
            Container(
                // height: 111,
                height: screenWidth * 0.35,
                width: double.maxFinite,
                margin: const EdgeInsets.only(
                  left: 20,
                ),
                child: ListView.builder(
                    itemCount: images.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return Container(
                          margin: const EdgeInsets.only(right: 30),
                          child: Column(
                            children: [
                              InkWell(
                                child: Container(
                                  // margin: const EdgeInsets.only(right: 50),
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    // color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: AssetImage("assets/exercise/" +
                                          images.keys.elementAt(index)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  var link = images.values
                                      .elementAt(index)['link'] as String;
                                  print(link);
                                  Navigator.pushNamed(context, link);
                                },
                                //                             },
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              Container(
                                child: AppText(
                                  text: images.values.elementAt(index)['name']
                                      as String,
                                  color: Colors.grey.withOpacity(0.9),
                                ),
                              )
                            ],
                          ));
                    }))
          ],
        ),
      ),
    );
  }
}

class Location {
  String type;
  List<double> coordinates;

  Location({required this.type, required this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates: List<double>.from(json['coordinates']),
    );
  }
}

class gymDetails {
  final String image;
  final String ownerEmail;
  final String gymName;
  final String location;
  final String capacity;
  // List<double> coordinates;
  // Add this line
  final double latitude;
  final double longitude;

  gymDetails({
    required this.gymName,
    required this.ownerEmail,
    required this.location,
    required this.image,
    required this.capacity,
    // required this.coordinates,
    // Add this line
    required this.latitude,
    required this.longitude,
  });

  factory gymDetails.fromJson(Map<String, dynamic> json) {
    final locationData = json['location'];
    final coordinates = (locationData != null &&
            locationData['coordinates'] is List &&
            locationData['coordinates'].isNotEmpty)
        ? List<double>.from(locationData['coordinates']
            .map((dynamic value) => value.toDouble()))
        : [0.0, 0.0];

    return gymDetails(
      gymName: json['gymName'],
      ownerEmail: json['ownerEmail'],
      location: "${json['City'] ?? ''} , ${json['State'] ?? ''}".trim(),
      image: json['Image'] ?? "0",
      capacity: json['totalCapacity'] ??
          "0", // coordinates: List<double>.from(json['coordinates']),
      // Add this line and set default value to empty string if null
      longitude: coordinates.isNotEmpty ? coordinates[0] : 0.0,
      latitude: coordinates.isNotEmpty ? coordinates[1] : 0.0,
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;
  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);

    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
