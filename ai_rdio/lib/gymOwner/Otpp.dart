import 'package:email_otp/email_otp.dart';
import 'package:ai_rdio/Utils/Dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class Otp extends StatelessWidget {
  const Otp({
    Key? key,
    required this.otpController,
  }) : super(key: key);
  final TextEditingController otpController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: otpController,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: const InputDecoration(
          hintText: ('0'),
        ),
        onSaved: (value) {},
      ),
    );
  }
}

class OtpScreen extends StatefulWidget {
  const OtpScreen(
      {Key? key,
      required this.myauth,
      required this.callback,
      required this.subject})
      : super(key: key);
  final EmailOTP myauth;
  final Function callback;
  final String subject;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();

  String otpController = "1234";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        actions: [],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Icon(Icons.security_rounded, size: 50),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Enter Fit-Sync Otp",
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Otp(
                otpController: otp1Controller,
              ),
              Otp(
                otpController: otp2Controller,
              ),
              Otp(
                otpController: otp3Controller,
              ),
              Otp(
                otpController: otp4Controller,
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            '${widget.subject}',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () async {
              if (await widget.myauth.verifyOTP(
                      otp: otp1Controller.text +
                          otp2Controller.text +
                          otp3Controller.text +
                          otp4Controller.text) ==
                  true) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("OTP is verified"),
                  backgroundColor: Colors.green,
                ));
                // widget.onPressed?.call();
                Navigator.pop(context);
                widget.callback();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Invalid OTP...... "),
                  backgroundColor:
                      Colors.red, // Set a custom background color for error
                ));
              }
            },
            child: const Text(
              "Confirm",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}

// import 'dart:ui';
// import 'package:ai_rdio/Utils/Dialog.dart';
// import 'package:email_auth/email_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:email_otp/email_otp.dart';

// class OtpDialog extends StatefulWidget {
//   final String email;
//   final void Function(bool) updateVisitedStatus;

//   const OtpDialog(
//       {Key? key, required this.updateVisitedStatus, required this.email})
//       : super(key: key);

//   @override
//   State<OtpDialog> createState() => _OtpDialogState();
// }

// class _OtpDialogState extends State<OtpDialog> {
//   late EmailAuth emailAuth;
//   String otp = "";

//   void _updateVisitedStatus() {
//     widget.updateVisitedStatus(true); // Call the callback function here
//   }

//   void verifyOtp() async {
//     var res = emailAuth.validateOtp(recipientMail: widget.email, userOtp: otp);
//     if (res) {
//       _updateVisitedStatus();
//     } else {
//       msgPop(context, "Otp Invalid", "Please Enter correct otp",
//           DialogType.error, () {}, "ok");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<TextEditingController> controllers = List.generate(
//       6,
//       (index) => TextEditingController(),
//     );

//     return BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//       child: AlertDialog(
//         title: Text('Enter OTP'),
//         contentPadding: EdgeInsets.only(left: 24, right: 24, top: 12),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 OtpTextField(
//                   controller: controllers[0],
//                   onChanged: (value) {
//                     setState(() {
//                       otp = controllers.map((c) => c.text).join('');
//                     });
//                   },
//                 ),
//                 OtpTextField(
//                   controller: controllers[1],
//                   onChanged: (value) {
//                     setState(() {
//                       otp = controllers.map((c) => c.text).join('');
//                     });
//                   },
//                 ),
//                 OtpTextField(
//                   controller: controllers[2],
//                   onChanged: (value) {
//                     setState(() {
//                       otp = controllers.map((c) => c.text).join('');
//                     });
//                   },
//                 ),
//                 OtpTextField(
//                   controller: controllers[3],
//                   onChanged: (value) {
//                     setState(() {
//                       otp = controllers.map((c) => c.text).join('');
//                     });
//                   },
//                 ),
//                 OtpTextField(
//                   controller: controllers[4],
//                   onChanged: (value) {
//                     setState(() {
//                       otp = controllers.map((c) => c.text).join('');
//                     });
//                   },
//                 ),
//                 OtpTextField(
//                   controller: controllers[5],
//                   onChanged: (value) {
//                     setState(() {
//                       otp = controllers.map((c) => c.text).join('');
//                     });
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 print(otp);
//                 verifyOtp();
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OtpTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final ValueChanged<String> onChanged;

//   const OtpTextField({
//     required this.controller,
//     required this.onChanged,
//   });

//   @override
//   _OtpTextFieldState createState() => _OtpTextFieldState();
// }

// class _OtpTextFieldState extends State<OtpTextField> {
//   @override
//   void initState() {
//     super.initState();
//     // Set the maximum character length of the text field to 1.
//     // This ensures that only one digit can be entered at a time.
//     widget.controller.addListener(() {
//       if (widget.controller.text.length > 1) {
//         widget.controller.text = widget.controller.text.substring(0, 1);
//       }
//       widget.onChanged(widget.controller.text);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 35,
//       height: 35,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: TextField(
//         keyboardType: TextInputType.number,
//         textAlign: TextAlign.center,
//         style: TextStyle(fontSize: 20),
//         controller: widget.controller,
//         decoration: InputDecoration(border: InputBorder.none),
//       ),
//     );
//   }
// }
//   @override
//   Widget build(BuildContext context) {
//     List<TextEditingController> controllers = List.generate(
//       6,
//       (index) => TextEditingController(),
//     );
//     otp = controllers.join('');

//     return BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//       child: AlertDialog(
//         title: Text('Enter OTP'),
//         contentPadding: EdgeInsets.only(left: 24, right: 24, top: 12),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 OtpTextField(),
//                 OtpTextField(),
//                 OtpTextField(),
//                 OtpTextField(),
//                 OtpTextField(),
//                 OtpTextField(),
//               ],
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 print(otp);
//                 verifyOtp();
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OtpTextField extends StatefulWidget {
//   @override
//   _OtpTextFieldState createState() => _OtpTextFieldState();
// }

// class _OtpTextFieldState extends State<OtpTextField> {
//   TextEditingController _controller = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Set the maximum character length of the text field to 1.
//     // This ensures that only one digit can be entered at a time.
//     _controller.addListener(() {
//       if (_controller.text.length > 1) {
//         _controller.text = _controller.text.substring(0, 1);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 35,
//       height: 35,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: TextField(
//         keyboardType: TextInputType.number,
//         textAlign: TextAlign.center,
//         style: TextStyle(fontSize: 20),
//         controller: _controller,
//         decoration: InputDecoration(border: InputBorder.none),
//       ),
//     );
//   }
// }
