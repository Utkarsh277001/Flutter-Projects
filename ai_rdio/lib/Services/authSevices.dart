import 'package:ai_rdio/Services/subscription.dart';
import 'package:ai_rdio/Utils/Constant.dart';
import 'package:ai_rdio/Utils/snackBar.dart';
import 'package:ai_rdio/navbar/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class authAervices {
  //SignUp
  void signUp(
      {required BuildContext context,
      required String name,
      required String email,
      required String password,
      required String age,
      required String gender}) async {
    try {
      EasyLoading.show(status: 'Signing Up ...');
      http.Response res = await http.post(
        Uri.parse('${Constant.url}/api/signup'),
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
          });
    } catch (e) {
      EasyLoading.dismiss();
      showSnackBar(context, e.toString());
    }
  }

  //Login
  void login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      // String url = dotenv.get('url');
      EasyLoading.show(status: 'Logging In...');
      http.Response res = await http.post(
        Uri.parse('${Constant.url}/api/login'),
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
                MaterialPageRoute(builder: (context) => const MainPage()),
                (route) => false);
            successSnackBar(context, 'login Sucessfully');
            final prefs = await SharedPreferences.getInstance();
            // String jsonString = jsonEncode(res);
            // prefs.setString('Verified', jsonString);
            prefs.setString('id', jsonDecode(res.body)['id']);
            prefs.setString('name', jsonDecode(res.body)['username']);
            prefs.setString('email', jsonDecode(res.body)['Email']);
            prefs.setString('age', jsonDecode(res.body)['age']);
            prefs.setString('gender', jsonDecode(res.body)['gender']);

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
