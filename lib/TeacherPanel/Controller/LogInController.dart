import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Services/LoginServices.dart';

class LogInController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<bool> userLogin() async {
    return await loginService(email.text, password.text);
  }
}
