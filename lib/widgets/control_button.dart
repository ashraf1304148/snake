import 'package:flutter/material.dart';
import 'package:snake/directoin.dart';
import 'package:snake/utils/dimension.dart';

class ControlButton extends StatelessWidget {
  final Direction direction;
  final IconData icon;
  const ControlButton({required this.direction, required this.icon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .5,
      child: Container(
        width: 80,
        height: 80,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            elevation: 0,
            onPressed: () {
              // print(icon);
              Dimensions.setDirection(direction);
            },
            child: Icon(this.icon),
          ),
        ),
      ),
    );
  }
}
