import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/style.dart';

Widget MyContainer(double width, double height, double radius, Widget child) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: whiteColor,
      border: Border.all(color: basicColor, width: 0.5.h),
      borderRadius: BorderRadius.circular(radius),
    ),
    child: child,
  );
}
