// import 'package:flutter/material.dart';

// class HistoryPage extends StatelessWidget {
//   final String username = "John Doe";
//   final List<HistoryItem> historyItems = [
//     HistoryItem(
//       image: "assets/images/Gym-1.jpg",
//       gymName: "Gym A",
//       location: "123 Main Street",
//       date: "April 25th, 2023",
//     ),
//     HistoryItem(
//       image: "assets/images/Gym-1.jpg",
//       gymName: "Gym B",
//       location: "456 Oak Avenue",
//       date: "April 20th, 2023",
//     ),
//     HistoryItem(
//       image: "assets/images/Gym-1.jpg",
//       gymName: "Gym C",
//       location: "789 Elm Boulevard",
//       date: "April 15th, 2023",
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("History"),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               "$username's History",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: historyItems.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         blurRadius: 5,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: Image.asset(
//                           historyItems[index].image,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       SizedBox(width: 16),
//                       Expanded(
//                         flex: 3,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               historyItems[index].gymName,
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               historyItems[index].location,
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               historyItems[index].date,
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class HistoryItem {
//   final String image;
//   final String gymName;
//   final String location;
//   final String date;

//   HistoryItem({
//     required this.image,
//     required this.gymName,
//     required this.location,
//     required this.date,
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../Utils/Constant.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String username = "";
  var useremail = '';
  var gym = {
    '1': 'Gym-1.jpg',
    '2': 'Gym-2.jpg',
    '3': 'Gym-3.jpg',
    '4': 'Gym-4.jpg',
    '5': 'Gym-5.jpg',
    '6': 'Gym-6.jpg',
    '7': 'Gym-7.jpg',
  };
  List<HistoryItem> historyItems = [];

  Future<void> getHistoryData() async {
    final prefs = await SharedPreferences.getInstance();
    useremail = prefs.getString('email')!;
    username = prefs.getString('name')!;

    var url = Uri.parse('${Constant.url}/schedule/getDailyGymUser/' +
        useremail); // Replace with your backend URL
    var response = await http.get(url);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print(response.statusCode);
      setState(() {
        historyItems = (json.decode(response.body) as List)
            .map((data) => HistoryItem.fromJson(data))
            .toList();
        historyItems = historyItems.reversed.toList();
        // var res = json.decode(response.body);
        print(historyItems);
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: "Retriving User's History..");
    getHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "$username History",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Text(
          //     "$username's History",
          //     style: TextStyle(
          //       fontSize: 24,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: historyItems.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  padding: EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              11.0), // Adjust the radius as per your requirement
                          child: Image(
                            image: NetworkImage(historyItems[index].image),
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 21),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              historyItems[index].gymName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              historyItems[index].location,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              historyItems[index].date,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              historyItems[index].time,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
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
}

class HistoryItem {
  final String ownerEmail;
  final String image;
  final String gymName;
  final String location;
  final String date;
  final String time; // Add this line

  HistoryItem({
    // required this.image,
    required this.ownerEmail,
    required this.gymName,
    required this.location,
    required this.date,
    required this.time,
    required this.image, // Add this line
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      // image: json[''],
      ownerEmail: json['ownerEmail'],
      gymName: json['gymName'], // Change this line to match your response key
      location: json['location'] ?? " ",
      date: json['date'] ?? " ",
      time: json['time'] ?? " ",
      image: json['Image'] ?? "0",
      // Add this line and set default value to empty string if null
    );
  }
}
