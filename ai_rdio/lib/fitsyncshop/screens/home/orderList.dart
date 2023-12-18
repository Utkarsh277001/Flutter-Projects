import 'package:flutter/material.dart';

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

class OrderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OrderDetailsScreen(),
    );
  }
}

class OrderDetailsScreen extends StatelessWidget {
  final List<OrderDetails> orders = [
    OrderDetails(
      orderNo: '123456',
      address: '123 Main St, Cityville',
      status: 'Shipped',
      expectedDelivery: 'November 20, 2023',
      imageUrl:
          'https://example.com/order_image1.jpg', // Replace with your image URL
    ),
    OrderDetails(
      orderNo: '789012',
      address: '456 Oak St, Townsville',
      status: 'Delivered',
      expectedDelivery: 'November 18, 2023',
      imageUrl:
          'http://res.cloudinary.com/dxn2eer5l/image/upload/v1698942828/vvwfbcqfmiudakdyhhs3.jpg', // Replace with your image URL
    ),
    // Add more orders as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                // Handle click response
                print('Card clicked for Order No: ${orders[index].orderNo}');
              },
              child: Card(
                elevation: 4.0,
                child: Row(
                  children: [
                    Image.network(
                      orders[index].imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order No: ${orders[index].orderNo}',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text('Status: ${orders[index].status}'),
                            SizedBox(height: 4),
                            Text(
                                'Expected Delivery: ${orders[index].expectedDelivery}'),
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
  var id;

  final String price;

  final String status;

  final String pic;

  orderInfo({
    required this.id,
    required this.price,
    required this.status,
    required this.pic,
  });

  factory orderInfo.fromJson(Map<String, dynamic> json) {
    return orderInfo(
      id: json['productid'],
      price: json['price'],
      status: json['productname'],
      pic: json['image'],
    );
  }
  double getPriceValue() {
    return double.tryParse(price) ?? 0.0;
  }
}
