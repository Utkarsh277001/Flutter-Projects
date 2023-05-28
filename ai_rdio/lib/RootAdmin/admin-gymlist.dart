import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Utils/Constant.dart';

class Gym {
  final String id;
  final String ownerEmail;
  final String gymName;
  final String city;
  final String state;
  final String perDayRate;
  final String image;
  final String contactDetails;

  Gym({
    required this.id,
    required this.ownerEmail,
    required this.gymName,
    required this.city,
    required this.state,
    required this.perDayRate,
    required this.image,
    required this.contactDetails,
  });
}

class GymList extends StatefulWidget {
  @override
  _GymListState createState() => _GymListState();
}

class _GymListState extends State<GymList> {
  List<Gym> _gyms = [];
  bool _isLoading = true;
  bool _isError = false;

  Future<void> _fetchGyms() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response =
          await http.get(Uri.parse('${Constant.url}/super/getAllGyms'));
      final jsonData = jsonDecode(response.body);
      setState(() {
        _gyms = (jsonData['gyms'] as List)
            .map((gym) => Gym(
                  id: gym['_id'],
                  ownerEmail: gym['ownerEmail'],
                  gymName: gym['gymName'],
                  city: gym['City'],
                  state: gym['State'],
                  perDayRate: gym['perDayRate'],
                  image: gym['Image'],
                  contactDetails: gym['contactDetails'],
                ))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        _isError = true;
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchGyms();
  }

  void _showGymDetails(BuildContext context, Gym gym) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GymDetailsDialog(gym: gym);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBarTitle = _isLoading
        ? Text(
            'Loading...',
            style: TextStyle(color: Colors.black),
          )
        : Text(
            'Gym List',
            style: TextStyle(color: Colors.black),
          );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: appBarTitle,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchGyms,
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _isError
              ? Center(
                  child: Text('Failed to load gyms.'),
                )
              : ListView.builder(
                  itemCount: _gyms.length,
                  itemBuilder: (context, index) {
                    final gym = _gyms[index];
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
                        leading: Image.network(gym.image),
                        title: Text(gym.gymName),
                        subtitle: Text('${gym.city}, ${gym.state}'),
                        trailing: Text('Rs${gym.perDayRate}/day'),
                        onTap: () {
                          _showGymDetails(context, gym);
                        },
                      ),
                    );
                  },
                ),
    );
  }
}

class GymDetailsDialog extends StatelessWidget {
  final Gym gym;

  const GymDetailsDialog({required this.gym});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(gym.image),
          SizedBox(height: 10),
          Text(
            gym.gymName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 5),
          Text("Email : ${gym.ownerEmail}"),
          SizedBox(height: 5),
          Text('Location : ${gym.city}, ${gym.state}'),
          SizedBox(height: 5),
          Text('Prize : Rs. ${gym.perDayRate}/day'),
          SizedBox(height: 5),
          Text("Contact : ${gym.contactDetails}"),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.black, //set the background color to black
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
