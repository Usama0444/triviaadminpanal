import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:triviaadminpanal/main.dart';

import '../Views/Categories.dart';

Future<bool> loginService(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    Get.back();
    reusableInstance.toast('Error', '$e');
    return false;
  }
}

Future<bool> userLogOut() async {
  try {
    await pref?.clear();
    await FirebaseAuth.instance.signOut();
    return true;
  } catch (e) {
    reusableInstance.toast('Error', '$e');
    return false;
  }
}
