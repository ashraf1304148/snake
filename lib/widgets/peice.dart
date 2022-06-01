import 'package:flutter/material.dart';
import 'package:snake/utils/dimension.dart';

class Piece extends StatefulWidget {
  final int posX, posY;
  int size;
  final bool isAnimated;
  final Color color;
  Piece(
      {required this.posX,
      required this.posY,
      this.size = Dimensions.pieceSize,
      this.color = Colors.deepPurple,
      this.isAnimated = false,
      Key? key})
      : super(key: key);

  @override
  State<Piece> createState() => _PieceState();
}

class _PieceState extends State<Piece> {
  // late AnimationController _animationController;
  /* @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      lowerBound: 0.25,
      upperBound: 1.0,
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
        // widget.size = (widget.size / 2).toInt();
      }
    });
    // widget.size = (widget.size / 2).toInt();
    _animationController.forward();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.posY.toDouble(),
      left: widget.posX.toDouble(),
      child: Opacity(
        // opacity: widget.isAnimated ? _animationController.value : 1,
        opacity: 1,

        child: Container(
          height: widget.size.toDouble(),
          width: widget.size.toDouble(),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(widget.size / 3),
            border: Border.all(width: 2, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
