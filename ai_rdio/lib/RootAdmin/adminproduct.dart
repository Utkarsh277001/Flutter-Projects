import 'dart:io';
import 'dart:math';
import 'package:ai_rdio/RootAdmin/fitsyncadmin.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:http/http.dart' as http;
import '../Utils/Constant.dart';
import '../Utils/Dialog.dart';
import 'package:hex/hex.dart';
import '../Utils/snackBar.dart';

String generateProductID() {
  const String chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final Random random = Random();
  final int idLength = 5;
  String result = '';

  for (int i = 0; i < idLength; i++) {
    final int randomIndex = random.nextInt(chars.length);
    result += chars[randomIndex];
  }

  return "FS-" + result;
}

class productRegistration extends StatefulWidget {
  @override
  _GymRegistrationPageState createState() => _GymRegistrationPageState();
}

class _GymRegistrationPageState extends State<productRegistration> {
  String _id = generateProductID();
  final _formKey = GlobalKey<FormState>();

  late String _category;
  late String _price;
  late String _name;
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

  Future uploadproduct() async {
    if (_productimage == null) {
      return;
    }
    // final prefs = await SharedPreferences.getInstance();
    // _ownerEmail = prefs.getString("ownerEmail")!;
    try {
      EasyLoading.show(status: 'Adding Details ...');
      var request = await http.MultipartRequest(
        'POST',
        Uri.parse('${Constant.url}/shop/saveProduct'),
      );
      request.fields["productId"] = _id;
      request.fields["productname"] = _name;
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
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => fitsyncadmin()));
        EasyLoading.dismiss();
      } else {
        print(_color);
        print(res);
        EasyLoading.dismiss();
        msgPop(
          context,
          'Sorry!!',
          "Product with same id already exist",
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

  Color _selectedColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Register Fit-Sync Products",
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
                  readOnly: true, // Make it read-only to prevent user input
                  initialValue:
                      _id, // Set the initial value to the generated ID
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Product Name',
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
                    _name = value!;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    hintText: 'Protein , Shaker , Sneaker...',
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
                      return 'Enter size of the product';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _size = value!;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.text,
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
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: _selectedColor,
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Pick a color'),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: _selectedColor,
                                    onColorChanged: (color) {
                                      setState(() {
                                        _selectedColor = color;
                                        _color = '#' +
                                            HEX.encode([
                                              _selectedColor.red,
                                              _selectedColor.green,
                                              _selectedColor.blue
                                            ]);
                                      });
                                    },
                                    showLabel: true,
                                    pickerAreaHeightPercent: 0.8,
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          height: 40,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            'Select Color',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      uploadproduct();
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
