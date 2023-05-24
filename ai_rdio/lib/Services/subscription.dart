import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ai_rdio/Utils/Constant.dart';
import 'package:ai_rdio/Utils/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Subscription {
  //DailyGym
  void subscribe(
      {required BuildContext context,
      required String userId,
      required String email,
      required String startDate,
      required String endDate}) async {
    try {
      EasyLoading.show(status: 'Adding Details ...');
      http.Response res = await http.post(
        Uri.parse('${Constant.url}/subscription/new'),
        body: jsonEncode({
          'userId': userId,
          'Email': email,
          'startDate': startDate,
          'endDate': endDate
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if (res.statusCode == 200) {
        EasyLoading.showSuccess('Added Successfully..');
        EasyLoading.dismiss();
        final prefs = await SharedPreferences.getInstance();
        subscribeCheck(context: context, email: prefs.getString('email')!);
      } else {
        EasyLoading.showError('Already Added..');
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

  void subscribeCheck({
    required BuildContext context,
    required String email,
  }) async {
    try {
      http.Response res = await http.get(
        Uri.parse('${Constant.url}/subscription/' + email),
      );
      if (res.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('doesSubs', "Yes");
        prefs.setString('sDate', jsonDecode(res.body)['sDate']);
        prefs.setString('eDate', jsonDecode(res.body)['eDate']);
      } else {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('doesSubs', "No");
      }
      // ignore: use_build_context_synchronously
      //   httpErrorHandle(
      //       response: res,
      //       context: context,
      //       onSuccess: () {
      //         successSnackBar(context,
      //             'Account created Successfully,please login with same credential');
      //       });
    } catch (e) {
      //   EasyLoading.dismiss();
      showSnackBar(context, e.toString());
    }
  }
}
