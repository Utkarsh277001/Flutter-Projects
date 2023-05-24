import 'dart:convert';
import 'dart:io';
import 'package:ai_rdio/gymOwner/ownermain.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Utils/Constant.dart';

class Gymupdate extends StatefulWidget {
  var id;
  Gymupdate({required this.id});
  @override
  _GymupdateState createState() => _GymupdateState();
}

class _GymupdateState extends State<Gymupdate> {
  final _formKey = GlobalKey<FormState>();
  late String _gymName;
  late String _City;
  late String _State;
  late String _Expenses;
  late String _dayRate;
  late String _ContactDetails;
  late ImagePicker picker;

  @override
  void initState() {
    super.initState();
    picker = ImagePicker();
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      // Display the selected image
      if (pickedFile != null) {
        gymPicture = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  File? gymPicture; // Hold the selected image file

  Future updateGymData() async {
    EasyLoading.show(status: 'Editing Gym Data...');
    final url = "${Constant.url}/gymInfo/updateGymData/${widget.id}";
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final body = json.encode({
      'gymName': _gymName,
      'City': _City,
      'State': _State,
      'perDayRate': _dayRate,
      'contactDetails': _ContactDetails,
    });

    try {
      final response =
          await http.put(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == HttpStatus.ok) {
        EasyLoading.showSuccess('Gym Data Edited Successfully..');
        EasyLoading.dismiss();
        print("Data updated successfully");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OwnerMainPage()));
      } else if (response.statusCode == HttpStatus.notFound) {
        print("No data found with the given ID");
      } else {
        throw Exception("Failed to update data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error while updating gym data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Gym Registration'),
        //   backgroundColor: Colors.deepPurple,
        // ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Update Gym",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Gym Picture input
                // GestureDetector(
                //   onTap: () {
                //     getImage(); // Open gallery when tapped
                //   },
                //   child: Container(
                //     height: 200,
                //     width: MediaQuery.of(context).size.width,
                //     decoration: BoxDecoration(
                //       color: Colors.grey[300],
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: gymPicture != null
                //         ? Image.file(gymPicture!)
                //         : Center(child: Icon(Icons.add_a_photo, size: 50)),
                //   ),
                // ),

                SizedBox(height: 20),

                // Gym Name input
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Gym Name',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your gym name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _gymName = value!;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                // City Name input
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your gym City';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _City = value!;
                  },
                ),

                SizedBox(height: 20),

                // Email input
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'State',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Gym State';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _State = value!;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                // Expenses  input
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Per-Day Expenses',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your gym Per-Day Expenses';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _dayRate = value!;
                  },
                ),

                SizedBox(height: 20),

                // Contact Details input
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Contact Details',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Contact details';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _ContactDetails = value!;
                  },
                ),

                SizedBox(height: 20),

                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      // save data to database or API call here

                      // Navigator.pop(context);
                    }
                    print(widget.id);
                    updateGymData();
                    // print(_gymName);
                    // print(gymPicture);
                  },
                  child: Text('Update', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 9, 9, 9),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
