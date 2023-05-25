import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ai_rdio/Utils/Constant.dart';
import 'package:ai_rdio/Utils/Dialog.dart';
import 'package:ai_rdio/Utils/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class DailyGym {
  //DailyGym
  void Dailygym({
    required BuildContext context,
    required String ownerEmail,
    required String userEmail,
    required String image,
    required String gymName,
    required String location,
    required String date,
    required String time,
  }) async {
    try {
      EasyLoading.show(status: 'Adding Details ...');
      http.Response res = await http.post(
        Uri.parse('${Constant.url}/schedule/addDailyGym'),
        body: jsonEncode({
          'ownerEmail': ownerEmail,
          'userEmail': userEmail,
          'Image': image,
          'gymName': gymName,
          'location': location,
          'date': date,
          'time': time,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (res.statusCode == 200) {
        EasyLoading.showSuccess('Added Successfully..');
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        msgPop(
            context,
            'Sorry!!',
            "You have already selected today's gym Schedule.Please check schedule history for more details",
            DialogType.noHeader,
            seeHistory,
            "OK");
      }
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            successSnackBar(context, 'gym Schedule Successfully');
          });
    } catch (e) {
      EasyLoading.dismiss();
      showSnackBar(context, e.toString());
    }
  }

  void seeHistory() {}
}
