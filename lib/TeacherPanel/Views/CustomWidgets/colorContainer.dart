import 'package:flutter/cupertino.dart';

Widget colorContainer(Color bgColor, Widget child, double width, double height, double radius) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(radius),
    ),
    child: child,
  );
}
