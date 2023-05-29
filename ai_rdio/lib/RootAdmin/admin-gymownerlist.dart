import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Utils/Constant.dart';
import 'admin-gym-all-user-history.dart';

class GymOwnersPage extends StatefulWidget {
  @override
  _GymOwnersPageState createState() => _GymOwnersPageState();
}

class _GymOwnersPageState extends State<GymOwnersPage> {
  List<dynamic> ownersList = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    final response =
        await http.get(Uri.parse('${Constant.url}/super/gymOwners'));
    if (response.statusCode == 200) {
      setState(() {
        ownersList = json.decode(response.body)['owners'];
        isLoading = false;
      });
    } else {
      setState(() {
        errorMessage = 'An error occurred while fetching data.';
        isLoading = false;
      });
    }
  }

  void _onOwnerSelected(String ownerEmail, String ownerName) async {
    final response = await http.get(
        Uri.parse('${Constant.url}/super/RegisterGymofOwner/${ownerEmail}'));
    if (response.statusCode == 200) {
      print(response.body);
      var gymList = json.decode(response.body)['gym'];
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                GymListPage(gymList: gymList, ownerName: ownerName)),
      );
    } else {
      // Handle error here
    }
  }

  Widget _buildBody() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (errorMessage.isNotEmpty) {
      return Center(
        child: Text(errorMessage),
      );
    } else {
      return ListView.builder(
        itemCount: ownersList.length,
        itemBuilder: (BuildContext context, int index) {
          var owner = ownersList[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            padding: EdgeInsets.all(11.0),
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
              leading: CircleAvatar(
                child: Text(owner['name'][0]),
              ),
              title: InkWell(
                child: Text(owner['name']),
              ),
              subtitle: Text('${owner['email']}'),
              onTap: () => _onOwnerSelected(owner['email'], owner['name']),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Gym Owners', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchData,
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: _buildBody(),
    );
  }
}

class GymListPage extends StatelessWidget {
  final List<dynamic> gymList;
  final String ownerName;

  GymListPage({required this.gymList, required this.ownerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            Text('Gyms of $ownerName', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: gymList.isNotEmpty
          ? ListView.builder(
              itemCount: gymList.length,
              itemBuilder: (BuildContext context, int index) {
                var gym = gymList[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4, // added elevation to show a proper shadow
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        // added ClipRRect to round the corners of the image
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: Image.network(
                          gym['Image'],
                          fit: BoxFit
                              .cover, // added fit property to cover the entire image area
                          height: 210,
                          width: double
                              .infinity, // added width property to make the image fill the entire width of the card
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(gym['gymName'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text(
                              'City: ${gym['City']}, State: ${gym['State']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Per Day Rate: ${gym['perDayRate']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Contact Details: ${gym['contactDetails']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            TextButton(
                              onPressed: () {
                                print(gym['gymName']);
                                print(gym['ownerEmail']);
                                var space = " " + "," + " ";
                                var location =
                                    gym['City'] + space + gym['State'];
                                print(location);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GymUserListPage(
                                          ownerEmail: gym['ownerEmail'],
                                          gymName: gym['gymName'],
                                          location: location)),
                                );
                              },
                              child: Text('History'),
                              style: TextButton.styleFrom(
                                primary: Colors.black,
                                backgroundColor: Colors.white,
                                side: BorderSide(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images2/no-gym.jpg',
                  ),
                  SizedBox(height: 16),
                  Text(' No Gym Registered',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
    );
  }
}
