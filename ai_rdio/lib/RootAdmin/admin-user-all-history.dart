import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Utils/Constant.dart';

class GymUserHistoryPage extends StatefulWidget {
  final String userEmail;
  final String name;

  GymUserHistoryPage({required this.userEmail, required this.name});

  @override
  _GymUserHistoryPageState createState() => _GymUserHistoryPageState();
}

class _GymUserHistoryPageState extends State<GymUserHistoryPage> {
  List<dynamic> gymList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGymData();
  }

  Future<void> fetchGymData() async {
    print("API CAlled-2");
    print(widget.userEmail);
    var response = await http.get(Uri.parse(
        "${Constant.url}/super/UserRecordForSuperAdmin/${widget.userEmail}"));
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        gymList = json.decode(response.body)['gym'];
        isLoading = false; // set to false when data has been loaded
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
      setState(() {
        isLoading = false; // still set to false even if there's an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("User history is called");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('${widget.name} History',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : gymList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images2/no-data.jpg"),
                      SizedBox(height: 16.0),
                      Text("No data available",
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: gymList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        leading: Image.network(gymList[index]['Image']),
                        title: Text(gymList[index]['gymName']),
                        subtitle: Text(
                            "${gymList[index]['location']}\n${gymList[index]['date']}"),

                        // Text(${gymList[index]['location']}\n${gymList[index]['date']}),
                        trailing: gymList[index]['Visited']
                            ? ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 206, 206, 206)),
                                ),
                                child: Text(
                                  'Visited',
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                ),
                                child: Text(
                                  'Not Visited',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                      ),
                    );
                  },
                ),
    );
  }
}
