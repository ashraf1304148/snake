
import 'package:snake/directoin.dart';

class Dimensions {
  static late final double secreenHeight;
  static late final double screenWidth;

  static int step = 30;
  static const int pieceSize = 30;
  static Direction _direction = Direction.up;
  static void initial({required double width, required double height}) {
    screenWidth = width;
    secreenHeight = height;
  }

  static Direction get direction => _direction;
  static void setDirection(Direction d) {
    switch (_direction) {
      case Direction.down:
      case Direction.up:
        if (d == Direction.left || d == Direction.right) {
          _direction = d;
        }
        break;

      case Direction.right:
      case Direction.left:
        if (d == Direction.up || d == Direction.down) {
          _direction = d;
        }
        break;
    }
  }
}
