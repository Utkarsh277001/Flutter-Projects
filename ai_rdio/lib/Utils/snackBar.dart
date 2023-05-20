import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void showSnackBar(BuildContext context, String text) {
  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  Get.snackbar(
    'Error',
    text,
    dismissDirection: DismissDirection.horizontal,
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.all(15),
    icon: Icon(
      Icons.error,
      color: Colors.red,
    ),
  );
}

void successSnackBar(BuildContext context, String text) {
  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  Get.snackbar(
    'Wooho',
    text,
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.all(15),
    icon: Icon(
      Icons.cabin,
      color: Color.fromARGB(255, 2, 231, 2),
    ),
  );
}

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}
