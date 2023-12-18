import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:provider/provider.dart';

class OrderUpdate {
  final String status;
  final String details;
  final DateTime time;

  OrderUpdate({
    required this.status,
    required this.details,
    required this.time,
  });
}

class CurrentOrderStage extends ChangeNotifier {
  int _currentStage = 1;

  int get currentStage => _currentStage;

  void updateCurrentStage(int stage) {
    _currentStage = stage;
    notifyListeners();
  }
}

class OrderHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => CurrentOrderStage(),
        child: OrderTimelineScreen(),
      ),
    );
  }
}

class OrderTimelineScreen extends StatelessWidget {
  final List<OrderUpdate> orderUpdates = [
    OrderUpdate(
      status: 'Order Placed',
      details: 'Your order has been placed successfully.',
      time: DateTime.now().subtract(Duration(hours: 2)),
    ),
    OrderUpdate(
      status: 'Processing',
      details: 'We are processing your order.',
      time: DateTime.now().subtract(Duration(hours: 1, minutes: 30)),
    ),
    OrderUpdate(
      status: 'Shipped',
      details: 'Your order has been shipped.',
      time: DateTime.now().subtract(Duration(minutes: 45)),
    ),
    OrderUpdate(
      status: 'Delivered',
      details: 'Your order has been delivered.',
      time: DateTime.now(),
    ),
  ];

  final List<IconData> statusIcons = [
    Icons.shopping_cart,
    Icons.access_time,
    Icons.local_shipping,
    Icons.check_circle,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Update'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Designed card showing order ID and remarks
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order ID: 123456',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Remarks: Special instructions or comments can be displayed here.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // Timeline
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(25),
              itemCount: orderUpdates.length,
              itemBuilder: (context, index) {
                return TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.1,
                  isFirst: index == 0,
                  isLast: index == orderUpdates.length - 1,
                  indicatorStyle: IndicatorStyle(
                    width: 40,
                    color: _getIndicatorColor(context, index),
                    indicatorXY: 0.5,
                    iconStyle: IconStyle(
                      color: Colors.white,
                      iconData: statusIcons[index],
                    ),
                  ),
                  endChild: Card(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      title: Text(orderUpdates[index].status),
                      subtitle: Text(orderUpdates[index].details),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getIndicatorColor(BuildContext context, int index) {
    return index <= context.read<CurrentOrderStage>().currentStage
        ? Colors.green
        : const Color.fromARGB(255, 54, 56, 58);
  }

  String _formattedTime(DateTime time) {
    return "${time.hour}:${time.minute}";
  }
}
