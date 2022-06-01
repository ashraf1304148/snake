import 'package:flutter/material.dart';

import 'package:snake/directoin.dart';
import 'package:snake/widgets/control_button.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 30,
      right: 30,
      bottom: 50,
      child: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              // Expanded(child: Container()),
              ControlButton(
                direction: Direction.left,
                icon: Icons.keyboard_arrow_left_sharp,
              ),
              Expanded(
                child: Column(
                  children: [
                    ControlButton(
                      direction: Direction.up,
                      icon: Icons.keyboard_arrow_up_sharp,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    ControlButton(
                      direction: Direction.down,
                      icon: Icons.keyboard_arrow_down_sharp,
                    ),
                  ],
                ),
              ),
              ControlButton(
                direction: Direction.right,
                icon: Icons.keyboard_arrow_right_sharp,
              ),
            ],
          ))
        ],
      ),
    );
  }
}
