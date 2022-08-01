import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/views/DrawerMenu.dart';

userLogin(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    Get.offAll(DrawerMenu());
  } catch (e) {
    Get.snackbar('Error', '$e');
  }
}
