import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

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
  late String _id;
  late String _category;
  late String _price;
  late String _size;
  late String _description;
  late String _color;
  late ImagePicker picker;
  File? _productimage;

  @override
  void initState() {
    super.initState();
    picker = ImagePicker();
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _productimage = pickedFile?.path != null ? File(pickedFile!.path) : null;
    });
  }

  void seeHistory() {}

  Future upload() async {
    if (_productimage == null) {
      return;
    }
    // final prefs = await SharedPreferences.getInstance();
    // _ownerEmail = prefs.getString("ownerEmail")!;
    try {
      EasyLoading.show(status: 'Adding Details ...');
      var request = await http.MultipartRequest(
        'POST',
        Uri.parse('${Constant.url}/gymInfo/gymDatas'),
      );
      request.fields["id"] = _id;
      request.fields["category"] = _category;
      request.fields["price"] = _price;
      request.fields["size"] = _size;
      request.fields["description"] = _description;
      request.fields["color"] = _color;
      request.files.add(await http.MultipartFile.fromPath(
        'Photo',
        _productimage!.path,
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
                    child: _productimage != null
                        ? Image.file(_productimage!)
                        : Center(child: Icon(Icons.add_a_photo, size: 50)),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Product Id',
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
                    _id = value!;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _category = value!;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Price';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _price = value!;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Size',
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
                    _size = value!;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Product Description',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Product Description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'color',
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
                    // _latitude = double.parse(value!);
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
