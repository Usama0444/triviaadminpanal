import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/UserController.dart';
import 'package:triviaadminpanal/AdminPanel/Services/LoginServices.dart';
import 'package:triviaadminpanal/AdminPanel/views/Login.dart';
import 'package:triviaadminpanal/main.dart';

class LogInController extends GetxController {
  UserController controller = Get.put(UserController());
  userAuth(email, pass) async {
    await userLogin(email, pass);
    await controller.getUser();
  }

  logOut() async {
    FirebaseAuth.instance.signOut();
    pref?.setBool('logedin', false);
    Get.offAll(Login());
  }
}
