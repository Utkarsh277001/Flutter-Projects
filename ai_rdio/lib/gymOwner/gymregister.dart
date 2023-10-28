// import 'dart:ffi';
// import 'dart:io';
// import 'package:ai_rdio/gymOwner/gmap.dart';
// import 'package:ai_rdio/navbar/gmap.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:ai_rdio/Services/gymDetails.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import '../Utils/Constant.dart';
// import '../Utils/Dialog.dart';
// import '../Utils/snackBar.dart';

// class GymRegistrationPage extends StatefulWidget {
//   // GymRegistrationPage({required this.selectedLocation});
//   @override
//   _GymRegistrationPageState createState() => _GymRegistrationPageState();
// }

// class _GymRegistrationPageState extends State<GymRegistrationPage> {
//   final _formKey = GlobalKey<FormState>();
//   late String _ownerEmail;
//   late String _gymName;
//   late String _City;
//   late String _State;
//   late String _dayRate;
//   late String _ContactDetails;
//   late ImagePicker picker;
//   File? gymPicture;

//   get latitude => null;

//   @override
//   void initState() {
//     super.initState();

//     picker = ImagePicker();
//   }

//   Future getImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       // Display the selected image

//       gymPicture = pickedFile?.path != null ? File(pickedFile!.path) : null;
//     });
//   }

//   void seeHistory() {}

//   Future upload() async {

//     if (gymPicture == null) {
//       return;
//     }
//     final prefs = await SharedPreferences.getInstance();
//     _ownerEmail = prefs.getString("ownerEmail")!;
//     try {
//       EasyLoading.show(status: 'Adding Details ...');
//       var request = await http.MultipartRequest(
//           'POST', Uri.parse('${Constant.url}/gymInfo/gymDatas'));
//       request.fields["ownerEmail"] = _ownerEmail;
//       request.fields["gymName"] = _gymName;
//       request.fields["City"] = _City;
//       request.fields["State"] = _State;
//       request.fields["perDayRate"] = _dayRate;
//       request.fields["contactDetails"] = _ContactDetails;
//       request.files
//           .add(await http.MultipartFile.fromPath('Photo', gymPicture!.path));

//       var res = await request.send();
//       if (res.statusCode == 200) {
//         EasyLoading.showSuccess('Added Successfully..');
//         EasyLoading.dismiss();
//       } else {
//         EasyLoading.dismiss();
//         msgPop(context, 'Sorry!!', "Gym with Same Credential is already added",
//             DialogType.noHeader, seeHistory, "OK");
//       }
//       // ignore: use_build_context_synchronously
//       // httpErrorHandle(
//       //     response: ,
//       //     context: context,
//       //     onSuccess: () {
//       //       successSnackBar(context,
//       //           'Account created Successfully,please login with same credential');
//       //     });
//     } catch (e) {
//       EasyLoading.dismiss();
//       showSnackBar(context, e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // appBar: AppBar(
//         //   title: Text('Gym Registration'),
//         //   backgroundColor: Colors.deepPurple,
//         // ),
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           title: Text(
//             "Gym Registration",
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 24,
//             ),
//           ),
//           iconTheme: IconThemeData(color: Colors.black),
//         ),
//         body: SingleChildScrollView(
//             child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Gym Picture input
//                 GestureDetector(
//                   onTap: () {
//                     getImage(); // Open gallery when tapped
//                   },
//                   child: Container(
//                     height: 200,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: gymPicture != null
//                         ? Image.file(gymPicture!)
//                         : Center(child: Icon(Icons.add_a_photo, size: 50)),
//                   ),
//                 ),

//                 SizedBox(height: 20),

//                 // Gym Name input
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Gym Name',
//                     border: OutlineInputBorder(),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.deepPurple),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your gym name';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _gymName = value!;
//                   },
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 // City Name input
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'City',
//                     border: OutlineInputBorder(),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.deepPurple),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your gym City';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _City = value!;
//                   },
//                 ),

//                 SizedBox(height: 20),

//                 // Email input
//                 TextFormField(
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     labelText: 'State',
//                     border: OutlineInputBorder(),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.deepPurple),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter Gym State';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _State = value!;
//                   },
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 // Expenses  input
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Per-Day Expenses',
//                     border: OutlineInputBorder(),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.deepPurple),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your gym Per-Day Expenses';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _dayRate = value!;
//                   },
//                 ),

//                 SizedBox(height: 20),

//                 // Contact Details input
//                 TextFormField(
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     labelText: 'Contact Details',
//                     border: OutlineInputBorder(),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your Contact details';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _ContactDetails = value!;
//                   },
//                 ),

//                 SizedBox(height: 20),

//                 // Declare selectedLocation as a string

// // // ...
// //
//                 SizedBox(height: 20),

//                 // Submit Button
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();

//                       // save data to database or API call here
//                     }

//                     upload();
//                   },
//                   child: Text('Register', style: TextStyle(fontSize: 18)),
//                   style: ElevatedButton.styleFrom(
//                     primary: Color.fromARGB(255, 9, 9, 9),
//                     padding: EdgeInsets.symmetric(vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )));
//   }
// }

import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Utils/Constant.dart';
import '../Utils/Dialog.dart';
import '../Utils/snackBar.dart';

class GymRegistrationPage extends StatefulWidget {
  @override
  _GymRegistrationPageState createState() => _GymRegistrationPageState();
}

class _GymRegistrationPageState extends State<GymRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  late String _ownerEmail;
  late String _gymName;
  late String _City;
  late String _State;
  late String _dayRate;
  late String _ContactDetails;
  late int _capacity;
  late double _latitude; // Modified
  late double _longitude; // Modified
  late ImagePicker picker;
  File? gymPicture;

  @override
  void initState() {
    super.initState();
    picker = ImagePicker();
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      gymPicture = pickedFile?.path != null ? File(pickedFile!.path) : null;
    });
  }

  void seeHistory() {}

  Future upload() async {
    if (gymPicture == null) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    _ownerEmail = prefs.getString("ownerEmail")!;
    try {
      EasyLoading.show(status: 'Adding Details ...');
      var request = await http.MultipartRequest(
        'POST',
        Uri.parse('${Constant.url}/gymInfo/gymDatas'),
      );
      request.fields["ownerEmail"] = _ownerEmail;
      request.fields["gymName"] = _gymName;
      request.fields["City"] = _City;
      request.fields["State"] = _State;
      request.fields["perDayRate"] = _dayRate;
      request.fields["contactDetails"] = _ContactDetails;
      request.fields["totalCapacity"] = _capacity.toString();
      request.fields["latitude"] = _latitude.toString(); // Modified
      request.fields["longitude"] = _longitude.toString(); // Modified
      request.files.add(await http.MultipartFile.fromPath(
        'Photo',
        gymPicture!.path,
      ));

      var res = await request.send();
      if (res.statusCode == 200) {
        EasyLoading.showSuccess('Added Successfully..');
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        msgPop(
          context,
          'Sorry!!',
          "Gym with Same Credential is already added",
          DialogType.noHeader,
          seeHistory,
          "OK",
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Gym Registration",
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
                GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: gymPicture != null
                        ? Image.file(gymPicture!)
                        : Center(child: Icon(Icons.add_a_photo, size: 50)),
                  ),
                ),
                SizedBox(height: 20),
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
                SizedBox(height: 20),
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
                SizedBox(height: 20),
                TextFormField(
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Gym Capacity',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter gym capacity/slot available per hour';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _capacity = int.parse(value!);
                  },
                ),
                SizedBox(height: 20),
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
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Latitude',
                    hintText: 'e.g., 40.7128',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter latitude';
                    }

                    final double latitude = double.tryParse(value) ?? 0.0;

                    if (latitude < -90.0 || latitude > 90.0) {
                      return 'Please enter a valid latitude value';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _latitude = double.parse(value!);
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Longitude',
                    hintText: 'e.g., -74.0060',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter longitude';
                    }

                    final double longitude = double.tryParse(value) ?? 0.0;

                    if (longitude < -180.0 || longitude > 180.0) {
                      return 'Please enter a valid longitude value';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _longitude = double.parse(value!);
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      upload();
                    }
                  },
                  child: Text('Register', style: TextStyle(fontSize: 18)),
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
        ),
      ),
    );
  }
}
