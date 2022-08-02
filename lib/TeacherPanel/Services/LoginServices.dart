import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/DrawerMenu.dart';

import '../Controller/CategoryController.dart';

userLogin(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    Get.offAll(TeacherDrawerMenu());
  } catch (e) {
    Get.snackbar('Error', '$e');
  }
}
