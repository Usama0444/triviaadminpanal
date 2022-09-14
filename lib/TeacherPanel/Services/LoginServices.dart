import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Future<bool> loginService(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    Get.snackbar(
      'Error',
      '$e',
      margin: EdgeInsets.only(left: 900, right: 100.w, bottom: 50.h),
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 1),
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
    return false;
  }
}
