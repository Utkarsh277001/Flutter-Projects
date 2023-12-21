import 'dart:convert';

import 'package:ai_rdio/Utils/Constant.dart';
import 'package:ai_rdio/Utils/snackBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class AddressScreen extends StatefulWidget {
  final String productids;
  final String price;

  AddressScreen({
    required this.productids,
    required this.price,
  });

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  int selectedAddressIndex = -1;
  List<userAddress> _addressData = [];

  Future<void> _getAddress() async {
    EasyLoading.show(status: 'Loading Addresses');
    final prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString("email")!;
    String url = '${Constant.url}/address/userAddress/' + userEmail;
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // var jsonData = json.decode(response.body);
        EasyLoading.dismiss();
        setState(() {
          _addressData = (json.decode(response.body) as List)
              .map((data) => userAddress.fromJson(data))
              .toList();
          print("successfully retrive");
        });
      } else {
        EasyLoading.dismiss();
        print('Failed to load address: ${response.statusCode}');
      }
    } catch (error) {
      EasyLoading.dismiss();
      print('Error loading gyms: $error');
    }
  }

  Razorpay? _razorpay;

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
        msg: "SUCCESS PAYMENT: ${response.paymentId}", timeInSecForIosWeb: 4);

    final prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString("email")!;
    try {
      EasyLoading.show(status: 'Adding Address');
      var request = await http.MultipartRequest(
        'POST',
        Uri.parse('${Constant.url}/order/saveOrder'),
      );
      request.fields["useremail"] = userEmail;
      request.fields["address"] = "Address: " +
          _addressData[selectedAddressIndex].address +
          " , house no. + City: " +
          _addressData[selectedAddressIndex].houseno +
          " & " +
          _addressData[selectedAddressIndex].city +
          " ,State & pincode " +
          _addressData[selectedAddressIndex].state +
          " & " +
          _addressData[selectedAddressIndex].pincode;
      request.fields["productids"] = widget.productids;
      request.fields["price"] = widget.price;
      request.fields["status"] = "0";
      request.fields["remarks"] = "Tracking Details will be available soon";

      var res = await request.send();
      if (res.statusCode == 200) {
        EasyLoading.showSuccess(' Address Added Successfully..');

        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        // msgPop(
        //   context,
        //   'Sorry!!',
        //   "Product with same id already exist",
        //   DialogType.noHeader,
        //   seeHistory,
        //   "OK",
        // );
      }
    } catch (e) {
      EasyLoading.dismiss();
      showSnackBar(context, e.toString());
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR HERE: ${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET IS : ${response.walletName}",
        timeInSecForIosWeb: 4);
  }

  @override
  void initState() {
    super.initState();
    _getAddress();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // Concatenate the product IDs

    // Print the concatenated IDs for verification
  }

  void dispose() {
    super.dispose();
    _razorpay?.clear();
  }

  void openPaymentPortal() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('id'));
    double amount = double.tryParse(widget.price) ?? 0.0;
    int amt = amount.toInt();
    String price = (amt * 100).toString();
    print("price " + price);
    var options = {
      'key': 'rzp_test_YjOu38M2dxdNJ5',
      'amount': price,
      'name': prefs.getString('name'),
      'description': 'Payment',
      'prefill': {'contact': '', 'email': prefs.getString('email')},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select your address ',
            style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0), letterSpacing: 1)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: List.generate(
            _addressData.length,
            (index) => AddressCard(
              address: _addressData[index],
              isSelected: selectedAddressIndex == index,
              onSelect: () {
                setState(() {
                  selectedAddressIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAddressForm(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ElevatedButton(
          onPressed: selectedAddressIndex == 0
              ? () {
                  openPaymentPortal();
                  // Add your logic for the "Proceed" button on the AddressScreen
                  print('Proceed button pressed!');
                }
              : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  // Change the color when the button is disabled
                  return Colors
                      .grey; // You can replace this with your desired color
                }
                return const Color.fromARGB(
                    255, 0, 0, 0); // Default color when enabled
              },
            ),
          ),
          child: Text('Proceed to Pay', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  final userAddress address;
  final bool isSelected;
  final VoidCallback onSelect;

  AddressCard({
    required this.address,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 10 : 1,
      color: isSelected ? Color.fromARGB(255, 241, 241, 240) : Colors.white,
      child: InkWell(
        onTap: onSelect,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Radio(
                value: isSelected,
                groupValue: true,
                onChanged: (value) => onSelect(),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Address: ${address.address}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      'House No. : ${address.houseno}',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'City : ${address.city}',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'State : ${address.state}',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Pincode : ${address.pincode}',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Address {
  final String houseNo;
  final String address;
  final String city;
  final String state;
  final String pincode;

  Address({
    required this.houseNo,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
  });
}

class AddAddressForm extends StatefulWidget {
  @override
  _AddAddressFormState createState() => _AddAddressFormState();
}

class _AddAddressFormState extends State<AddAddressForm> {
  final _houseNoController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future addAddress() async {
    final prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString("email")!;
    try {
      EasyLoading.show(status: 'Adding Address');
      var request = await http.MultipartRequest(
        'POST',
        Uri.parse('${Constant.url}/address/saveAddress'),
      );
      request.fields["useremail"] = userEmail;
      request.fields["address"] = _addressController.text;
      request.fields["houseno"] = _houseNoController.text;
      request.fields["city"] = _cityController.text;
      request.fields["state"] = _stateController.text;
      request.fields["pincode"] = _pincodeController.text;

      var res = await request.send();
      if (res.statusCode == 200) {
        EasyLoading.showSuccess(' Address Added Successfully..');

        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        // msgPop(
        //   context,
        //   'Sorry!!',
        //   "Product with same id already exist",
        //   DialogType.noHeader,
        //   seeHistory,
        //   "OK",
        // );
      }
    } catch (e) {
      EasyLoading.dismiss();
      showSnackBar(context, e.toString());
    }
  }

  // Dummy list of states for auto-suggest
  final List<String> states = [
    'State1',
    'State2',
    'State3',
    // Add more states as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Address'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFormField(
                  controller: _houseNoController,
                  label: 'House No.',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter House No.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buildFormField(
                  controller: _addressController,
                  label: 'Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buildFormField(
                  controller: _cityController,
                  label: 'City',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter City';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buildAutoCompleteField(
                  controller: _stateController,
                  label: 'State',
                  suggestions: states,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter State';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                _buildFormField(
                  controller: _pincodeController,
                  label: 'Pin Code',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a pin code';
                    } else if (value.length != 6) {
                      return 'Pin code must be 6 digits';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Process the form data (e.g., save the address)
                      // For simplicity, we just print the values here
                      print('House No.: ${_houseNoController.text}');
                      print('Address: ${_addressController.text}');
                      print('City: ${_cityController.text}');
                      print('State: ${_stateController.text}');
                      print('Pin Code: ${_pincodeController.text}');
                      addAddress();
                      // Navigate back to the address screen
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.all(12),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildAutoCompleteField({
    required TextEditingController controller,
    required String label,
    required List<String> suggestions,
    String? Function(String?)? validator,
  }) {
    return SimpleAutoCompleteTextField(
      key: GlobalKey(),
      controller: controller,
      suggestions: suggestions,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.all(12),
      ),
      textChanged: (text) {
        // Perform actions on text change if needed
      },
      textSubmitted: (text) {
        setState(() {
          controller.text = text;
        });
      },
      clearOnSubmit: false,
      // validator: validator,
    );
  }
}

// // Dummy addresses for testing
// List<Address> addresses = [
//   Address(
//     houseNo: '123',
//     address: 'Near Park',
//     city: 'Cityville',
//     state: 'Stateville',
//     pincode: '123456',
//   ),
//   Address(
//     houseNo: '456',
//     address: 'Next to School',
//     city: 'Townsville',
//     state: 'Stateville',
//     pincode: '789012',
//   ),
//   // Add more addresses as needed
// ];

class userAddress {
  var address;

  final String houseno;

  final String city;

  final String state;
  final String pincode;

  userAddress({
    required this.address,
    required this.houseno,
    required this.city,
    required this.state,
    required this.pincode,
  });

  factory userAddress.fromJson(Map<String, dynamic> json) {
    return userAddress(
      address: json['address'],
      houseno: json['houseno'],
      city: json['city'],
      state: json['state'],
      pincode: json['pincode'],
    );
  }
}
