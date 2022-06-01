import 'package:flutter/material.dart';
import 'package:snake/directoin.dart';
import 'package:snake/utils/dimension.dart';
// import 'package:snake/utils/dimension.dart';
import 'package:snake/widgets/Control_button_2.dart';

class ControlPanel2 extends StatefulWidget {
  const ControlPanel2({Key? key}) : super(key: key);

  @override
  State<ControlPanel2> createState() => _ControlPanel2State();
}

class _ControlPanel2State extends State<ControlPanel2> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      height: screenHeight / 3,
      child: Row(children: [
        //left button
        GestureDetector(
          onTap: (() {
            setState(() {
              Dimensions.setDirection(Direction.left);
            });
          }),
          child: Container(
            height: screenHeight / 3,
            width: screenWidth / 4,
            child: ControlButton2(
                direction: Direction.left, icon: Icons.keyboard_arrow_left),
          ),
        ),
        //
        Container(
          height: screenHeight / 3,
          width: screenWidth / 2,
          child: Column(children: [
            // up button
            GestureDetector(
              onTap: () {
                setState(() {
                  Dimensions.setDirection(Direction.up);
                });
              },
              child: Container(
                height: screenHeight / 6,
                width: screenWidth / 2,
                child: ControlButton2(
                    direction: Direction.up, icon: Icons.keyboard_arrow_up),
              ),
            ),
            // down button
            GestureDetector(
              onTap: () {
                setState(() {
                  Dimensions.setDirection(Direction.down);
                });
              },
              child: Container(
                height: screenHeight / 6,
                width: screenWidth / 2,
                child: ControlButton2(
                    direction: Direction.down, icon: Icons.keyboard_arrow_down),
              ),
            ),
          ]),
        ),
        // right button
        GestureDetector(
          onTap: () {
            setState(() {
              Dimensions.setDirection(Direction.right);
            });
          },
          child: Container(
            height: screenHeight / 3,
            width: screenWidth / 4,
            child: ControlButton2(
                direction: Direction.right, icon: Icons.keyboard_arrow_right),
          ),
        ),
      ]),
    );
  }
}
