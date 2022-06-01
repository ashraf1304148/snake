import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake/control_panel.dart';
import 'package:snake/directoin.dart';
import 'package:snake/utils/dimension.dart';
import 'package:snake/widgets/control_panel_2.dart';
import 'package:snake/widgets/peice.dart';
// import 'package:flutter/rendering.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late int upperBoundX, upperBoundY, lowerBoundX, lowerBoundY;
  late double screenWidth, screenHeight;
  int step = Dimensions.step;
  int length = 5;
  late Offset foodPosition = getRandomPosition();
  late Piece food;
  int _score = 0;
  double speed = 1;
  // Direction direction = Controller.direction;
  List<Offset> positions = [];
  int getNearestTens(int num) {
    int output = (num ~/ step) * step;
    if (output == 0) {
      output += step;
    }
    return output;
  }

  void drowFood() {
    if (foodPosition == null) {
      foodPosition = getRandomPosition();
    }
    if (foodPosition == positions[0]) {
      _score += 5;
      speed += .25;
      foodPosition = getRandomPosition();
      length++;
      changSpeed();
    }

    food = Piece(
      posX: foodPosition.dx.toInt(),
      posY: foodPosition.dy.toInt(),
      isAnimated: true,
    );
  }

  Offset getRandomPosition() {
    Offset position;
    int posX = Random().nextInt(upperBoundX) + lowerBoundX;
    int posY = Random().nextInt(upperBoundY) + lowerBoundY;
    position = Offset(
        getNearestTens(posX).toDouble(), getNearestTens(posY).toDouble());
    return position;
  }

  Future<Offset> getNextPosition(Offset position) async {
    Offset nextPosition;
    switch (Dimensions.direction) {
      case Direction.up:
        nextPosition = Offset(position.dx, position.dy - Dimensions.step);
        break;
      case Direction.right:
        nextPosition = Offset(position.dx + Dimensions.step, position.dy);
        break;
      case Direction.down:
        nextPosition = Offset(position.dx, position.dy + Dimensions.step);
        break;
      case Direction.left:
        nextPosition = Offset(position.dx - Dimensions.step, position.dy);
        break;
    }
    if (position.dx > screenWidth - step) {
      nextPosition = Offset(step.toDouble(), position.dy);
    } else if (position.dx < step) {
      nextPosition = Offset(
          getNearestTens(screenWidth.toInt() - step).toDouble(), position.dy);
    }
    if (position.dy > screenHeight - step) {
      nextPosition = Offset(position.dx, step.toDouble());
    } else if (position.dy < step) {
      nextPosition = Offset(
          position.dx, getNearestTens(screenHeight.toInt() - step).toDouble());
    }
    // if (detectColision(position)) {
    //   if (timer != null && timer.isActive) {
    //     timer.cancel();
    //   }
    //   await Future.delayed(
    //       Duration(microseconds: 200), () => showGameOverDialog());
    //   return position;
    // }
    return nextPosition;
  }

  void showGameOverDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.blue,
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(10.0)),
          title: Text("Game Over", style: TextStyle(color: Colors.white)),
          content: Text(
              "Your game is over but you palyed well. your score is: $_score",
              style: TextStyle(color: Colors.white, fontSize: 20)),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                restart();
              },
              child: Text("Restart",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
            )
          ],
        );
      },
    );
  }

  bool detectColision(Offset position) {
    if (position.dx >= upperBoundX && Dimensions.direction == Direction.right) {
      return true;
    } else if (position.dx <= lowerBoundX &&
        Dimensions.direction == Direction.left) {
      return true;
    } else if (position.dy >= upperBoundY &&
        Dimensions.direction == Direction.down) {
      return true;
    } else if (position.dy <= lowerBoundY &&
        Dimensions.direction == Direction.up) {
      return true;
    }

    return false;
  }

  Future<void> draw() async {
    if (positions.length == 0) {
      positions.add(getRandomPosition());
    }

    // draw();
    while (length > positions.length) {
      positions.add(positions[positions.length - 1]);
    }
    for (int i = positions.length - 1; i > 0; i--) {
      if (positions[0].dx == positions[i].dx &&
          positions[0].dy == positions[i].dy &&
          positions.length > 5) {
        if (timer != null && timer.isActive) timer.cancel();
        await Future.delayed(
            Duration(milliseconds: 200), () => showGameOverDialog());
      }
      positions[i] = positions[i - 1];
    }
    positions[0] = await getNextPosition(positions[0]);
  }

  List<Piece> getPieces() {
    final List<Piece> pieces = [];

    draw();
    drowFood();

    positions.forEach((element) {
      // if(i>=positions.length)continue;
      pieces.add(Piece(
        posX: element.dx.toInt(),
        posY: element.dy.toInt(),
        size: Dimensions.pieceSize,
        // color: Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
        //     Random().nextInt(255), 1),
        color: Colors.red,
        // isAnimated: true,
      ));
    });

    return pieces;
  }

  Timer timer = Timer(Duration(milliseconds: 200), () {});
  void changSpeed() {
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
    timer = Timer.periodic(Duration(milliseconds: 200 ~/ speed), (timer) {
      setState(() {
        //  print(
        //    "screen width: ${Dimensions.screenWidth}\t screen height: ${Dimensions.secreenHeight}");
      });
    });
  }

  void restart() {
    _score = 0;
    length = 5;
    speed = 1;
    positions = [];
    getRandomDirection();
    changSpeed();
  }

  Widget get score {
    return Positioned(
        top: 80.0,
        right: 50,
        child: Text(
          "Score: $_score",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ));
  }

  void getRandomDirection() {
    Dimensions.setDirection(Direction.values[Random().nextInt(4)]);
  }

  @override
  void initState() {
    super.initState();
    // Dimensions.initial(
    //  height: MediaQuery.of(context).size.height,
    // width: MediaQuery.of(context).size.width,
    // );
    restart();
    // drowFood();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    lowerBoundX = lowerBoundY = step;
    upperBoundX = getNearestTens(screenWidth.toInt() - step);
    upperBoundY = getNearestTens(screenHeight.toInt() - step);
    // direction = Dimensions.direction;
    // print("$screenHeight\t$screenWidth");
    return Scaffold(
        body: Container(
      color: Colors.amber[600],
      child: Stack(
        children: [
          score,
          // piecies
          Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Stack(
                children: getPieces(),
              )),
          ControlPanel(),
          food,
        ],
      ),
    ));
  }
}
