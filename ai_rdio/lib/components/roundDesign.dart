import 'package:flutter/material.dart';

class RoundDesign extends StatefulWidget {
  const RoundDesign({
    key,
    required this.child,
  });

  final Widget child;

  @override
  State<RoundDesign> createState() => _RoundDesignState();
}

class _RoundDesignState extends State<RoundDesign> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Color.fromARGB(255, 228, 218, 218),
        ),
        child: widget.child);
  }
}
