import 'package:flutter/material.dart';

class Order {
  final String orderId;
  final DateTime date;
  final String product;

  Order({
    required this.orderId,
    required this.date,
    required this.product,
  });
}

class orderScreen extends StatelessWidget {
  final List<Order> orders = [
    Order(orderId: '1', date: DateTime(2023, 11, 14), product: 'Product A'),
    Order(orderId: '2', date: DateTime(2023, 11, 15), product: 'Product B'),
    Order(orderId: '3', date: DateTime(2023, 11, 15), product: 'Product C'),
    // Add more sample orders as needed
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Order List'),
        ),
        body: OrderListScreen(orders: orders),
      ),
    );
  }
}

class OrderListScreen extends StatefulWidget {
  final List<Order> orders;

  OrderListScreen({required this.orders});

  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  Map<DateTime, List<Order>> ordersByDate = {};
  Map<String, int?> selectedRadioMap = {};
  Map<String, TextEditingController> commentControllerMap = {};

  @override
  void initState() {
    super.initState();

    // Group orders by date
    for (var order in widget.orders) {
      if (ordersByDate.containsKey(order.date)) {
        ordersByDate[order.date]!.add(order);
      } else {
        ordersByDate[order.date] = [order];
      }
    }

    // Initialize radio group and comment controller for each order
    for (var dateOrders in ordersByDate.values) {
      for (var order in dateOrders) {
        selectedRadioMap[order.orderId] = null;
        commentControllerMap[order.orderId] = TextEditingController();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ordersByDate.length,
      itemBuilder: (context, dateIndex) {
        var date = ordersByDate.keys.toList()[dateIndex];
        var dateOrders = ordersByDate[date]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Date: ${_formattedDate(date)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: dateOrders.map((order) {
                return Card(
                  margin: EdgeInsets.all(20.0),
                  elevation: 8,
                  color: Colors.amberAccent,
                  child: ListTile(
                    title: Text('Order ID: ${order.orderId}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Product: ${order.product}'),
                        Text('Date: ${_formattedDate(order.date)}'),
                        SizedBox(height: 8),
                        Text('Select Rating:'),
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: selectedRadioMap[order.orderId],
                              onChanged: (value) {
                                setState(() {
                                  selectedRadioMap[order.orderId] =
                                      value as int?;
                                });
                              },
                            ),
                            Text('1'),
                            Radio(
                              value: 2,
                              groupValue: selectedRadioMap[order.orderId],
                              onChanged: (value) {
                                setState(() {
                                  selectedRadioMap[order.orderId] =
                                      value as int?;
                                });
                              },
                            ),
                            Radio(
                              value: 3,
                              groupValue: selectedRadioMap[order.orderId],
                              onChanged: (value) {
                                setState(() {
                                  selectedRadioMap[order.orderId] =
                                      value as int?;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('Add Comment:'),
                        TextField(
                          controller: commentControllerMap[order.orderId],
                          decoration: InputDecoration(
                            hintText: 'Type your comment here...',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Implement logic to save the rating and comment
                        // You can use 'selectedRadioMap[order.orderId]' variable for rating
                        // and 'commentControllerMap[order.orderId].text' for comments
                      },
                      child: Text('Save'),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  String _formattedDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
