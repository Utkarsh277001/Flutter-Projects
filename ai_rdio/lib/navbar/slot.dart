import 'package:flutter/material.dart';

class SlotCounter extends StatefulWidget {
  final int totalSlots;
  final int availableSlots;

  SlotCounter({required this.totalSlots, required this.availableSlots});

  @override
  _SlotCounterState createState() => _SlotCounterState();
}

class _SlotCounterState extends State<SlotCounter>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();

    // Create an AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Adjust the animation duration as needed
    );

    // Create an IntTween
    final int begin = 0;
    final int end = widget.availableSlots;
    _animation = IntTween(begin: begin, end: end).animate(_controller);

    // Start the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Center(
          child: DefaultTextStyle(
            style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0)),
            child: Column(
              children: [
                Text(
                  'Available Slots',
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${_animation.value}',
                      style: TextStyle(
                          fontSize: 36, color: Color.fromARGB(244, 57, 255, 7)),
                    ),
                    Text(
                      ' / ${widget.totalSlots}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
