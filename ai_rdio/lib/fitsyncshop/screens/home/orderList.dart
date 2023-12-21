import 'dart:convert';

import 'package:ai_rdio/Utils/Constant.dart';
import 'package:ai_rdio/fitsyncshop/screens/home/orderScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderDetails {
  final String orderNo;
  final String address;
  final String status;
  final String expectedDelivery;
  final String imageUrl;

  OrderDetails({
    required this.orderNo,
    required this.address,
    required this.status,
    required this.expectedDelivery,
    required this.imageUrl,
  });
}

class OrderList extends StatefulWidget {
  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List<orderInfo> _orderlist = [];

  Future<void> _getOrder() async {
    EasyLoading.show(status: 'Loading Addresses');
    final prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString("email")!;
    String url = '${Constant.url}/order/orderHis/' + userEmail;
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // var jsonData = json.decode(response.body);
        EasyLoading.dismiss();
        setState(() {
          _orderlist = (json.decode(response.body) as List)
              .map((data) => orderInfo.fromJson(data))
              .toList();
          print("successfully retrive orders");
        });
      } else {
        EasyLoading.dismiss();
        print('Failed to load order: ${response.statusCode}');
      }
    } catch (error) {
      EasyLoading.dismiss();
      print('Error loading order: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _getOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        backgroundColor: Colors.black,
      ),
      body: _orderlist.isEmpty
          ? Center(
              child: Text(
                'No order is present..',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            )
          : ListView.builder(
              itemCount: _orderlist.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      // Handle click response
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => OrderHistory(
                                orderId: _orderlist[index].orderId,
                                status: _orderlist[index].status,
                                remarks: _orderlist[index].remarks,
                              )));
                    },
                    child: Card(
                      elevation: 8.0,
                      color: Color.fromARGB(255, 166, 193, 240),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order No: ${_orderlist[index].orderId}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                      'Product Id : ${_orderlist[index].productid}'),
                                  SizedBox(height: 4),
                                  Text(
                                      'Order Price : ₹${_orderlist[index].price}'),
                                  SizedBox(height: 4),
                                  Text('Order Date : ${_orderlist[index].doo}'),
                                  SizedBox(height: 4),
                                  Text(
                                    'For more update Click here ',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class orderInfo {
  var orderId;

  var productid;

  final String price;

  final String status;

  final String remarks;

  final String doo;

  orderInfo({
    required this.orderId,
    required this.productid,
    required this.price,
    required this.status,
    required this.remarks,
    required this.doo,
  });

  factory orderInfo.fromJson(Map<String, dynamic> json) {
    return orderInfo(
        orderId: json['_id'],
        productid: json['productids'],
        price: json['price'],
        status: json['status'],
        remarks: json['remarks'],
        doo: json['OrderDate']);
  }
  double getPriceValue() {
    return double.tryParse(price) ?? 0.0;
  }
}
