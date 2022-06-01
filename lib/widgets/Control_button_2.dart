import 'package:flutter/material.dart';
import 'package:snake/directoin.dart';
import 'package:snake/utils/dimension.dart';

class ControlButton2 extends StatefulWidget {
  final Direction direction;
  final IconData icon;
  const ControlButton2({required this.direction, required this.icon, Key? key})
      : super(key: key);

  @override
  State<ControlButton2> createState() => _ControlButton2State();
}

class _ControlButton2State extends State<ControlButton2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 200, 0, .1),
      ),
      child: GestureDetector(
        onTap: (() {
          setState(() {
            Dimensions.setDirection(widget.direction);
          });
        }),
        child: Container(
          child: Icon(widget.icon, color: Colors.white, size: 40),
        ),
      ),
    );
  }
}
