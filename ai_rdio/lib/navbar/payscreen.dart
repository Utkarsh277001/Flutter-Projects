import 'package:ai_rdio/Services/subscription.dart';
import 'package:ai_rdio/Utils/Dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class BuyServicePlanPage extends StatefulWidget {
  @override
  State<BuyServicePlanPage> createState() => _BuyServicePlanPageState();
}

class _BuyServicePlanPageState extends State<BuyServicePlanPage> {
  Razorpay? _razorpay;

  int Amount = 0;
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
        msg: "SUCCESS PAYMENT: ${response.paymentId}", timeInSecForIosWeb: 4);
    final prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('id')!;
    String email = prefs.getString('email')!;
    Subscription subscr = Subscription();
    DateTime date = DateTime.now();
    String startDate = DateFormat.yMd().format(DateTime.now());

    var price = Amount;
    if (price == 100000) {
      String endDate =
          DateFormat.yMd().format(DateTime.now().add(const Duration(days: 30)));
      subscr.subscribe(
          context: context,
          userId: userId,
          email: email,
          startDate: startDate,
          endDate: endDate);
    } else if (price == 200000) {
      String endDate =
          DateFormat.yMd().format(DateTime.now().add(const Duration(days: 60)));
      subscr.subscribe(
          context: context,
          userId: userId,
          email: email,
          startDate: startDate,
          endDate: endDate);
    } else if (price == 300000) {
      String endDate =
          DateFormat.yMd().format(DateTime.now().add(const Duration(days: 90)));
      subscr.subscribe(
          context: context,
          userId: userId,
          email: email,
          startDate: startDate,
          endDate: endDate);
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
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void dispose() {
    super.dispose();
    _razorpay?.clear();
  }

  //make payment Function
  void openPaymentPortal(int price) async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('id'));
    Amount = price;
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
    var description;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a plan:',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ServicePlanCard(
                    cardImage: 'assets/images/debit-card.png',
                    billAmount: 820,
                    gst: 180,
                    sub_no: 1,
                    total_prize: 1000,
                    callback: openPaymentPortal,
                    plan_name: "Basic",
                    description:
                        "Access to gym equipment and facilities. No additional perks and benefits.",
                  ),
                  ServicePlanCard(
                      cardImage: 'assets/images/debit-card.png',
                      billAmount: 1640,
                      gst: 360,
                      sub_no: 2,
                      total_prize: 2000,
                      plan_name: "Premium",
                      callback: openPaymentPortal,
                      description:
                          "Access to premium services like steam bath , hot tubs , ice bath and other services"),
                  ServicePlanCard(
                      cardImage: 'assets/images/debit-card.png',
                      billAmount: 2460,
                      gst: 540,
                      sub_no: 3,
                      total_prize: 3000,
                      callback: openPaymentPortal,
                      plan_name: "Elite",
                      description:
                          "Access to all exclusive services like private locker room or personal training."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServicePlanCard extends StatelessWidget {
  final String cardImage;
  final double billAmount;
  final double gst;
  final String plan_name;
  final String description;
  final double total_prize;
  final Function callback;
  final int sub_no;

  ServicePlanCard(
      {required this.cardImage,
      required this.billAmount,
      required this.gst,
      required this.total_prize,
      required this.plan_name,
      required this.description,
      required this.callback,
      required this.sub_no});

  void ontap() {}
  @override
  Widget build(BuildContext context) {
    double total;
    return Container(
      width: 285,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  12.0), // Set the desired border radius here
              child: Image.asset(
                cardImage,
                height: 210,
                width: 336,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 12),
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Text(
                  "$plan_name",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 11),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "$description",
                    softWrap:
                        true, //enable text to wrap to next line if it exceeds the container width
                    overflow: TextOverflow
                        .visible, // set to visible to allow text overflow to show
                    style: TextStyle(
                        fontSize: 17, color: Color.fromARGB(255, 99, 84, 84)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            // child: Text(
            //   'Bill amount: Rs$billAmount',
            //   style: TextStyle(fontSize: 16),
            // ),
            child: Row(
              children: [
                Text(
                  "Prize",
                  style: TextStyle(
                      fontSize: 17, color: Color.fromARGB(255, 99, 84, 84)),
                ),
                SizedBox(width: 140.0),
                Text(
                  "Rs$billAmount",
                  style: TextStyle(
                      fontSize: 17, color: Color.fromARGB(255, 99, 84, 84)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  "GST",
                  style: TextStyle(
                      fontSize: 17, color: Color.fromARGB(255, 99, 84, 84)),
                ),
                SizedBox(width: 145.0),
                Text(
                  "Rs$gst",
                  style: TextStyle(
                      fontSize: 17, color: Color.fromARGB(255, 99, 84, 84)),
                ),
              ],
            ),
            // child: Text(
            //   'Tax: Rs$billAmount',
            //   style: TextStyle(fontSize: 16),
            // ),
          ),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  "Total",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 115.0),
                Text(
                  "Rs$total_prize",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 21),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                String check = 'No';
                if (prefs.getString('doesSubs') != null) {
                  check = prefs.getString('doesSubs')!;
                }
                if (check == 'Yes') {
                  msgPop(
                      context,
                      'Premium Equipped !!',
                      'You have already enrolled in premium subscription',
                      DialogType.infoReverse,
                      ontap,
                      "OK");
                } else {
                  int choice;
                  choice = sub_no;
                  if (choice == 1) {
                    callback(100000);
                  }
                  if (choice == 2) {
                    callback(200000);
                  }
                  if (choice == 3) {
                    callback(300000);
                  }
                }
              },
              child: Text(
                'Pay Now',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(21.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                minimumSize: Size(250, 30),
              ),
            ),
          ),
          SizedBox(height: 11),
        ],
      ),
    );
  }
}
