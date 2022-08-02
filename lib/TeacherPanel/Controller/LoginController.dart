import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Login.dart';

import '../../main.dart';
import '../Services/CategoryServices.dart';
import '../Services/LoginServices.dart';

class LogInController extends GetxController {
  userAuth(email, pass) async {
    await userLogin(email, pass);
  }

  logOut() async {
    FirebaseAuth.instance.signOut();
    pref?.setBool('logedin', false);
    Get.offAll(TeacherLogin());
  }
}
