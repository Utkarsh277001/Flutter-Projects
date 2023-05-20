// import 'dart:convert';
// import 'dart:html';
// import 'package:http/http.dart' as http;
// import 'package:ai_rdio/Utils/Dialog.dart';
// import 'package:ai_rdio/Utils/snackBar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:image_picker/image_picker.dart';
// import '../Utils/Constant.dart';

// class gymDetails {
//   //DailyGym
//   void GymDetails(
//       {required BuildContext context,
//       required String ownerEmail,
//       required String gymName,
//       required String city,
//       required String state,
//       required String dayRate,
//       required String contactDetails,
//       required File image}) async {
//     try {
//       EasyLoading.show(status: 'Adding Details ...');
//       var request = await http.MultipartRequest(
//           'POST', Uri.parse('${Constant.url}/gymDatas'));
//       request.fields["ownerEmail"] = ownerEmail;
//       request.fields["gymName"] = gymName;
//       request.fields["City"] = city;
//       request.fields["State"] = state;
//       request.fields["perDayRate"] = dayRate;
//       request.fields["contactDetails"] = contactDetails;
//       request.files.add(await http.MultipartFile.fromPath('Image', image.path));

//       if (res.statusCode == 200) {
//         EasyLoading.showSuccess('Added Successfully..');
//         EasyLoading.dismiss();
//       } else {
//         EasyLoading.dismiss();
//         msgPop(context, 'Sorry!!', "Gym with Same Credential is already added",
//             DialogType.noHeader, seeHistory, "OK");
//       }
//       // ignore: use_build_context_synchronously
//       httpErrorHandle(
//           response: res,
//           context: context,
//           onSuccess: () {
//             successSnackBar(context,
//                 'Account created Successfully,please login with same credential');
//           });
//     } catch (e) {
//       EasyLoading.dismiss();
//       showSnackBar(context, e.toString());
//     }
//   }

//   void seeHistory() {}
// }
