import 'package:ai_rdio/Services/subscription.dart';
import 'package:ai_rdio/Utils/Constant.dart';
import 'package:ai_rdio/Utils/snackBar.dart';
import 'package:ai_rdio/gymOwner/owner-login.dart';
import 'package:ai_rdio/gymOwner/ownermain.dart';
import 'package:ai_rdio/navbar/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class gymOwner {
  //SignUp
  void ownerSignUp(
      {required BuildContext context,
      required String name,
      required String email,
      required String password,
      required String age,
      required String gender}) async {
    try {
      EasyLoading.show(status: 'Signing Up ...');
      http.Response res = await http.post(
        Uri.parse('${Constant.url}/gymOwner/Register'),
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'age': age,
          'gender': gender
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if (res.statusCode == 200) {
        EasyLoading.showSuccess('Signing Up SucessFully');
        EasyLoading.dismiss();
      } else {
        EasyLoading.showError('Error occured...');
        EasyLoading.dismiss();
      }
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            successSnackBar(context,
                'Account created Successfully,please login with same credential');
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => OwnerRegLoginUi()));
          });
    } catch (e) {
      EasyLoading.dismiss();
      showSnackBar(context, e.toString());
    }
  }

  //Login
  void ownerLogin(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      EasyLoading.show(status: 'Logging In...');
      http.Response res = await http.post(
        Uri.parse('${Constant.url}/gymOwner/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (res.statusCode == 200) {
        EasyLoading.showSuccess('Login Successfully');
        EasyLoading.dismiss();
      } else {
        EasyLoading.showError('Error occured...');
        EasyLoading.dismiss();
      }

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const OwnerMainPage()),
                (route) => false);
            successSnackBar(context, 'login Sucessfully');
            final prefs = await SharedPreferences.getInstance();
            // String jsonString = jsonEncode(res);
            // prefs.setString('Verified', jsonString);
            prefs.setString('ownerId', jsonDecode(res.body)['id']);
            prefs.setString('ownerName', jsonDecode(res.body)['username']);
            prefs.setString('ownerEmail', jsonDecode(res.body)['Email']);
            prefs.setString('ownerAge', jsonDecode(res.body)['age']);
            prefs.setString('ownerGender', jsonDecode(res.body)['gender']);

            //Calling subsCheck for profile
            Subscription subscr = Subscription();
            String str = prefs.getString('email')!;
            subscr.subscribeCheck(context: context, email: str);
          });
    } catch (e) {
      EasyLoading.dismiss();
      showSnackBar(context, e.toString());
    }
  }
}
