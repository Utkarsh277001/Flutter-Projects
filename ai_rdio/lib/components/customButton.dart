import "package:flutter/material.dart";

class customButton extends StatefulWidget {
  const customButton({super.key, required this.text, required this.onpressed});
  final String text;
  final VoidCallback onpressed;
  @override
  State<customButton> createState() => _customButtonState();
}

class _customButtonState extends State<customButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      splashColor: Colors.amber,
      onTap: widget.onpressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.black),
        padding: EdgeInsets.symmetric(vertical: 11, horizontal: 11),
        alignment: Alignment.center,
        child: Text(
          widget.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
          ),
        ),
      ),
    );
  }
}



//this is the Email and password  text field UI Design  
