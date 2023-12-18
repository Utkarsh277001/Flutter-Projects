import 'dart:convert';
import 'dart:io';

import 'package:ai_rdio/Exercise/const.dart';
import 'package:ai_rdio/Utils/Constant.dart';
import 'package:ai_rdio/Utils/Dialog.dart';
import 'package:ai_rdio/components/InputBox.dart';
import 'package:ai_rdio/gymOwner/Otpp.dart';
import 'package:ai_rdio/screen/RegLoginUi.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:email_otp/email_otp.dart';
import 'package:http/http.dart' as http;

class ResetPasswordScreen extends StatefulWidget {
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
    final url = "${Constant.url}/api/forgotPass";
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

  void popup() {
    updatePassword();
    msgPop(
        context, 'OTP verified', "", DialogType.success, ontap, "Login Screen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputBox(
              icon: Icons.mail,
              hint: 'Email',
              controller: emailController,
              hide: false,
            ),
            SizedBox(height: 16),
            InputBox(
              icon: Icons.mail,
              hint: 'New Password',
              controller: newPasswordController,
              hide: true,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // print("click register");
                    EasyLoading.show(status: "Sending OTP....");
                    if (newPasswordController.text.isNotEmpty &&
                        newPasswordController.text.length >= 8) {
                      // register();

                      myauth.setConfig(
                          appEmail: "contact@hdevcoder.com",
                          appName: "GymMate Email Verification",
                          userEmail: emailController.text,
                          otpLength: 4,
                          otpType: OTPType.digitsOnly);
                      EasyLoading.dismiss();
                      if (await myauth.sendOTP() == true) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("OTP has been sent"),
                          backgroundColor: Colors.green,
                        ));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Oops, OTP send failed"),
                          backgroundColor: Colors.red,
                        ));
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtpScreen(
                                    myauth: myauth,
                                    callback: popup,
                                    subject: "Forgot Password OTP verification",
                                  )));

                      // Implement logic to send OTP
                      // For simplicity, let's assume OTP is always sent successfully
                    } else {
                      // New password is empty or less than 8 characters
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Please enter a new password with at least 8 characters"),
                        backgroundColor: Colors
                            .red, // Set a custom background color for error
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color.fromARGB(255, 0, 0, 0), // Background color
                    foregroundColor:
                        Color.fromARGB(255, 255, 255, 255), // Text color
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10), // Button padding
                    elevation: 5, // Elevation
                  ),
                  child: Text('Update Password'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
