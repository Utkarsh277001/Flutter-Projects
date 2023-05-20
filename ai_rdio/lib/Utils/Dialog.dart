import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void msgPop(BuildContext context, String title, String msg, DialogType dg,
    VoidCallback ontap, String txt) {
  AwesomeDialog(
          context: context,
          dialogType: dg,
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 104, 102, 102),
            width: 2,
          ),
          width: 580,
          buttonsBorderRadius: const BorderRadius.all(
            Radius.circular(2),
          ),
          dismissOnTouchOutside: true,
          dismissOnBackKeyPress: false,
          // onDismissCallback: (type) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text('Dismissed by $type'),
          //     ),
          //   );
          // },
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: title,
          titleTextStyle: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
          desc: msg,
          descTextStyle: TextStyle(color: Colors.black, fontSize: 14),
          btnOkColor: Colors.black,
          btnOkOnPress: ontap,
          btnOkText: txt)
      .show();
}
