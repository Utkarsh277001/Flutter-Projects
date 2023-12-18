import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class InputBox extends StatefulWidget {
  const InputBox(
      {Key? key,
      required this.icon,
      required this.hint,
      required this.controller,
      required this.hide})
      : super(key: key);

  final IconData icon;
  final String hint;
  final bool hide;
  final TextEditingController controller;

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      // child: RoundDesign(
      child: Container(
        height: 70,
        width: 300,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(21)),
        child: TextFormField(
          validator: widget.hint == "Email"
              ? MultiValidator([
                  RequiredValidator(errorText: "Required"),
                  PatternValidator(r'^[\w-\.]+@gmail.com',
                      errorText: "invalid Email")
                ])
              : widget.hint == "Password"
                  ? MultiValidator([
                      RequiredValidator(errorText: "Required"),
                      MinLengthValidator(8,
                          errorText: "Password should be more than 8")
                    ])
                  : widget.hint == "New Password"
                      ? MultiValidator([
                          RequiredValidator(errorText: "Required"),
                          MinLengthValidator(8,
                              errorText: "Password should be more than 8")
                        ])
                      : MultiValidator([
                          RequiredValidator(errorText: "Required"),
                        ]),
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(21)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 1.5),
                  borderRadius: BorderRadius.circular(21)),
              prefixIcon: Icon(widget.icon, color: Colors.black),
              filled: true,
              fillColor: Color.fromARGB(255, 247, 246, 246),
              labelText: widget.hint),
          showCursor: true,
          obscureText: widget.hide,
          controller: widget.controller,
        ),
      ),
    );
  }
}
