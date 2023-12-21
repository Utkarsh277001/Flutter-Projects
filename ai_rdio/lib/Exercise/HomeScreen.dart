import 'package:ai_rdio/Exercise/legs.dart';
import 'package:ai_rdio/Exercise/shoulder.dart';
import 'package:flutter/material.dart';
import 'package:ai_rdio/Exercise/meditation.dart';
import 'cardio.dart';
import 'pilates.dart';
import 'pull-up.dart';

import 'const.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Data> data = [
    Data(
      imageUrl: "assets/exercise/cycling.gif",
      heading: "Cardio",
      time: "1 Hours",
      exercises: "4 exercises",
    ),
    Data(
      imageUrl: "assets/exercise/wristcurl.gif",
      heading: "Arms",
      time: "1 Hours",
      exercises: "4 exercises",
    ),
    Data(
      imageUrl: "assets/exercise/benchpress.gif",
      heading: "Chest",
      time: "1 Hours",
      exercises: "4 exercises",
    ),
    Data(
      imageUrl: "assets/exercise/pull.gif",
      heading: "Back",
      time: "1 Hours",
      exercises: "4 exercises",
    ),
    Data(
      imageUrl: "assets/exercise/jumpsquat.gif",
      heading: "Legs",
      time: "1 Hours",
      exercises: "4 exercises",
    ),
    Data(
      imageUrl: "assets/exercise/dumbbelllateralraise.gif",
      heading: "Shoulder",
      time: "1 Hours",
      exercises: "4 exercises",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          // header(size),

          Container(
            width: size.width / 1.15,
            child: Text(
              "Find Your",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              width: size.width / 1.15,
              child: Text(
                "Favourite Workout",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          listViewBuilder(size),
        ],
      ),
    );
  }

  Widget listViewBuilder(Size size) {
    return Container(
      height: size.height / 1.29,
      width: size.width,
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return items(size, index);
        },
      ),
    );
  }

  Widget items(Size size, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
          child: Container(
            height: size.height / 3.8,
            width: size.width / 1.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: size.height / 3.8,
                  width: size.width / 2.2,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height / 30,
                      ),
                      Container(
                        width: size.width / 2.8,
                        child: Text(
                          data[index].heading,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Container(
                          height: size.height / 12,
                          width: size.width / 2.8,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    data[index].exercises,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.timelapse,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    data[index].time,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: size.width / 2.8,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: size.height / 13.5,
                          width: size.width / 13.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: InkWell(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: size.height / 4,
                  width: size.width / 2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(data[index].imageUrl),
                  )),
                ),
              ],
            ),
          ),
          onTap: () {
            if (index == 0) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => CardioExercisePage()));
            } else if (index == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => BicepsExercisePage()));
            } else if (index == 2) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => PullExercisePage()));
            } else if (index == 3) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => MeditationExercisePage()));
              ;
            } else if (index == 4) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => LegsExercisePage()));
              ;
            } else if (index == 5) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ShoulderExercisePage()));
              ;
            }
          }),
    );
  }

  // Widget header(Size size) {
  //   return Container(
  //     height: size.height / 12,
  //     width: size.width,
  //     child: Row(
  //       children: [
  //         Padding(
  //           padding: EdgeInsets.all(20),
  //           child: Icon(
  //             Icons.menu,
  //             color: color[2],
  //           ),
  //         ),
  //         SizedBox(
  //           width: size.width / 1.85,
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(10.0),
  //           child: Icon(
  //             Icons.search,
  //             color: color[2],
  //           ),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.all(5),
  //           child: Icon(
  //             Icons.notifications,
  //             color: color[2],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}

class Data {
  final String heading, imageUrl, exercises, time;
  Data({
    required this.exercises,
    required this.heading,
    required this.imageUrl,
    required this.time,
  });
}
