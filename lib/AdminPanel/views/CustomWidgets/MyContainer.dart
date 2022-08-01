import 'package:flutter/cupertino.dart';
import 'package:triviaadminpanal/AdminPanel/views/components/style.dart';

Widget MyContainer(double width, double height, double radius, Widget child) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: whiteColor,
      border: Border.all(color: basicColor, width: 0.5),
      borderRadius: BorderRadius.circular(radius),
    ),
    child: child,
  );
}

Widget MyCategory(double width, double height, double radius, Color color, Widget child) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: color,
      border: Border.all(color: basicColor, width: 0.5),
      borderRadius: BorderRadius.circular(radius),
    ),
    child: child,
  );
}
