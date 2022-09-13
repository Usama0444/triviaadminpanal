import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/components/style.dart';

class Reusable {
  Widget buttons(double width, double height, Widget child) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: basicColor,
        borderRadius: BorderRadius.circular(5.h),
      ),
      child: child,
    );
  }

  Widget inputBox(double width, double height, var borderColor, Widget child) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 1.h,
        ),
        borderRadius: BorderRadius.circular(10.h),
      ),
      child: child,
    );
  }
}
