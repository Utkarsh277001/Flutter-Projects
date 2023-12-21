// // import 'dart:convert';
// // import 'dart:io';

// // import 'package:ai_rdio/Exercise/const.dart';
// // import 'package:ai_rdio/Utils/Constant.dart';
// // import 'package:ai_rdio/Utils/Dialog.dart';
// // import 'package:ai_rdio/components/InputBox.dart';
// // import 'package:ai_rdio/gymOwner/Otpp.dart';
// // import 'package:ai_rdio/screen/RegLoginUi.dart';
// // import 'package:awesome_dialog/awesome_dialog.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_easyloading/flutter_easyloading.dart';
// // import 'package:email_otp/email_otp.dart';
// // import 'package:http/http.dart' as http;

// // class ResetPasswordScreen extends StatefulWidget {
// //   @override
// //   _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
// // }

// // class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
// //   TextEditingController emailController = TextEditingController();
// //   TextEditingController newPasswordController = TextEditingController();
// //   TextEditingController otpController = TextEditingController();
// //   EmailOTP myauth = EmailOTP();

// //   bool isOtpVerified = false;

// //   void updatePassword() async {
// //     final url = "${Constant.url}/api/forgotPass";
// //     final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
// //     final body = json.encode({
// //       'email': emailController.text,
// //       'newPassword': newPasswordController.text,
// //     });

// //     try {
// //       final response =
// //           await http.post(Uri.parse(url), headers: headers, body: body);
// //       if (response.statusCode == HttpStatus.ok) {
// //         print("Data updated successfully");
// //       } else if (response.statusCode == HttpStatus.notFound) {
// //         print("No data found with the given ID");
// //       } else {
// //         throw Exception("Failed to update data: ${response.statusCode}");
// //       }
// //     } catch (error) {
// //       print("Error while updating gym data: $error");
// //     }
// //   }

// //   void ontap() {
// //     Navigator.push(
// //         context, MaterialPageRoute(builder: (context) => RegLoginUi()));
// //   }

// //   void popup() {
// //     updatePassword();
// //     msgPop(
// //         context, 'OTP verified', "", DialogType.success, ontap, "Login Screen");
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(
// //           'Reset Password',
// //           style: TextStyle(color: Colors.white),
// //         ),
// //         backgroundColor: Colors.black,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             InputBox(
// //               icon: Icons.mail,
// //               hint: 'Email',
// //               controller: emailController,
// //               hide: false,
// //             ),
// //             SizedBox(height: 16),
// //             InputBox(
// //               icon: Icons.mail,
// //               hint: 'New Password',
// //               controller: newPasswordController,
// //               hide: true,
// //             ),
// //             SizedBox(height: 16),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //               children: [
// //                 ElevatedButton(
// //                   onPressed: () async {
// //                     // print("click register");
// //                     EasyLoading.show(status: "Sending OTP....");
// //                     if (newPasswordController.text.isNotEmpty &&
// //                         newPasswordController.text.length >= 8) {
// //                       // register();

// //                       myauth.setConfig(
// //                           appEmail: "contact@hdevcoder.com",
// //                           appName: "GymMate Email Verification",
// //                           userEmail: emailController.text,
// //                           otpLength: 4,
// //                           otpType: OTPType.digitsOnly);
// //                       EasyLoading.dismiss();
// //                       if (await myauth.sendOTP() == true) {
// //                         ScaffoldMessenger.of(context)
// //                             .showSnackBar(const SnackBar(
// //                           content: Text("OTP has been sent"),
// //                           backgroundColor: Colors.green,
// //                         ));
// //                       } else {
// //                         ScaffoldMessenger.of(context)
// //                             .showSnackBar(const SnackBar(
// //                           content: Text("Oops, OTP send failed"),
// //                           backgroundColor: Colors.red,
// //                         ));
// //                       }
// //                       // ignore: use_build_context_synchronously
// //                       Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                               builder: (context) => OtpScreen(
// //                                     myauth: myauth,
// //                                     callback: popup,
// //                                     subject: "Forgot Password OTP verification",
// //                                   )));

// //                       // Implement logic to send OTP
// //                       // For simplicity, let's assume OTP is always sent successfully
// //                     } else {
// //                       // New password is empty or less than 8 characters
// //                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
// //                         content: Text(
// //                             "Please enter a new password with at least 8 characters"),
// //                         backgroundColor: Colors
// //                             .red, // Set a custom background color for error
// //                       ));
// //                     }
// //                   },
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor:
// //                         Color.fromARGB(255, 0, 0, 0), // Background color
// //                     foregroundColor:
// //                         Color.fromARGB(255, 255, 255, 255), // Text color
// //                     padding: EdgeInsets.symmetric(
// //                         horizontal: 20, vertical: 10), // Button padding
// //                     elevation: 5, // Elevation
// //                   ),
// //                   child: Text('Update Password'),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';
// import 'dart:io';

// import 'package:ai_rdio/Exercise/const.dart';
// import 'package:ai_rdio/Utils/Constant.dart';
// import 'package:ai_rdio/Utils/Dialog.dart';
// import 'package:ai_rdio/components/InputBox.dart';
// import 'package:ai_rdio/gymOwner/Otpp.dart';
// import 'package:ai_rdio/screen/RegLoginUi.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:email_otp/email_otp.dart';
// import 'package:http/http.dart' as http;

// class ResetPasswordScreen extends StatefulWidget {
//   @override
//   _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
// }

// class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController newPasswordController = TextEditingController();
//   TextEditingController otpController = TextEditingController();
//   EmailOTP myauth = EmailOTP();

//   bool isOtpVerified = false;

//   void updatePassword() async {
//     final url = "${Constant.url}/api/forgotPass";
//     final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
//     final body = json.encode({
//       'email': emailController.text,
//       'newPassword': newPasswordController.text,
//     });

//     try {
//       final response =
//           await http.post(Uri.parse(url), headers: headers, body: body);
//       if (response.statusCode == HttpStatus.ok) {
//         print("Data updated successfully");
//       } else if (response.statusCode == HttpStatus.notFound) {
//         print("No data found with the given ID");
//       } else {
//         throw Exception("Failed to update data: ${response.statusCode}");
//       }
//     } catch (error) {
//       print("Error while updating gym data: $error");
//     }
//   }

//   void ontap() {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => RegLoginUi()));
//   }

//   void popup() {
//     updatePassword();
//     msgPop(
//         context, 'OTP verified', "", DialogType.success, ontap, "Login Screen");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             height: 500, // Adjust the height as needed
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(
//                     'assets/images2/reset.jpg'), // Replace with your image asset
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               margin: EdgeInsets.all(16),
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(21),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 5,
//                     blurRadius: 12,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   InputBox(
//                     icon: Icons.mail,
//                     hint: 'Email',
//                     controller: emailController,
//                     hide: false,
//                   ),
//                   SizedBox(height: 16),
//                   InputBox(
//                     icon: Icons.mail,
//                     hint: 'New Password',
//                     controller: newPasswordController,
//                     hide: true,
//                   ),
//                   SizedBox(height: 12),
//                   ElevatedButton(
//                     onPressed: () async {
//                       EasyLoading.show(status: "Sending OTP....");
//                       if (newPasswordController.text.isNotEmpty &&
//                           newPasswordController.text.length >= 8) {
//                         myauth.setConfig(
//                             appEmail: "contact@hdevcoder.com",
//                             appName: "GymMate Email Verification",
//                             userEmail: emailController.text,
//                             otpLength: 4,
//                             otpType: OTPType.digitsOnly);
//                         EasyLoading.dismiss();
//                         if (await myauth.sendOTP() == true) {
//                           ScaffoldMessenger.of(context)
//                               .showSnackBar(const SnackBar(
//                             content: Text("OTP has been sent"),
//                             backgroundColor: Colors.green,
//                           ));
//                         } else {
//                           ScaffoldMessenger.of(context)
//                               .showSnackBar(const SnackBar(
//                             content: Text("Oops, OTP send failed"),
//                             backgroundColor: Colors.red,
//                           ));
//                         }

//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => OtpScreen(
//                               myauth: myauth,
//                               callback: popup,
//                               subject: "Forgot Password OTP verification",
//                             ),
//                           ),
//                         );
//                       } else {
//                         ScaffoldMessenger.of(context)
//                             .showSnackBar(const SnackBar(
//                           content: Text(
//                               "Please enter a new password with at least 8 characters"),
//                           backgroundColor: Colors.red,
//                         ));
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color.fromARGB(255, 0, 0, 0),
//                       foregroundColor: Color.fromARGB(255, 255, 255, 255),
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 40, vertical: 10),
//                       elevation: 5,
//                     ),
//                     child: Text('Update Password'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:ai_rdio/Exercise/const.dart';
import 'package:ai_rdio/Utils/Constant.dart';
import 'package:ai_rdio/Utils/Dialog.dart';
import 'package:ai_rdio/components/InputBox.dart';
import 'package:ai_rdio/gymOwner/Otpp.dart';
import 'package:ai_rdio/gymOwner/owner-login.dart';
import 'package:ai_rdio/screen/RegLoginUi.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:email_otp/email_otp.dart';
import 'package:http/http.dart' as http;

class ResetPasswordScreen extends StatefulWidget {
  final int call;

  ResetPasswordScreen({required this.call});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  EmailOTP myauth = EmailOTP();

  bool isOtpVerified = false;

  void updatePassword() async {
    String url = "";
    if (widget.call == 1) {
      url = "${Constant.url}/api/forgotPass";
    } else if (widget.call == 0) {
      url = '${Constant.url}/gymOwner/forgotPass';
    }
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final body = json.encode({
      'email': emailController.text,
      'newPassword': newPasswordController.text,
    });

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == HttpStatus.ok) {
        print("Data updated successfully");
      } else if (response.statusCode == HttpStatus.notFound) {
        print("No data found with the given ID");
      } else {
        throw Exception("Failed to update data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error while updating gym data: $error");
    }
  }

  void ontap() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegLoginUi()));
  }

  void ontapp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OwnerRegLoginUi()));
  }

  void popup() {
    updatePassword();
    if (widget.call == 1) {
      msgPop(context, 'OTP verified', "", DialogType.success, ontap,
          "Login Screen");
    } else if (widget.call == 0) {
      msgPop(context, 'OTP verified', "", DialogType.success, ontapp,
          "Login Screen");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 500, // Adjust the height as needed
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images2/reset.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(21),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 12,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                InputBox(
                  icon: Icons.mail,
                  hint: 'Email',
                  controller: emailController,
                  hide: false,
                ),
                SizedBox(height: 12),
                InputBox(
                  icon: Icons.mail,
                  hint: 'New Password',
                  controller: newPasswordController,
                  hide: true,
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () async {
                    EasyLoading.show(status: "Sending OTP....");
                    if (newPasswordController.text.isNotEmpty &&
                        newPasswordController.text.length >= 8) {
                      myauth.setConfig(
                          appEmail: "contact@hdevcoder.com",
                          appName:
                              "Fit-Sync Forget Password Email Verification",
                          userEmail: emailController.text,
                          otpLength: 4,
                          otpType: OTPType.digitsOnly);

                      if (await myauth.sendOTP() == true) {
                        EasyLoading.dismiss();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("OTP has been sent"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Oops, OTP send failed"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpScreen(
                            myauth: myauth,
                            callback: popup,
                            subject: "Forgot Password OTP verification",
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please enter a new password with at least 8 characters",
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 0, 0),
                    foregroundColor: Color.fromARGB(255, 255, 255, 255),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    elevation: 5,
                  ),
                  child: Text('Update Password'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
