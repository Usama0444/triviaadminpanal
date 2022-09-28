import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Services/LoginServices.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Categories.dart';

import '../../main.dart';

class LogInController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  CategoryController? cateController;
  Future<bool> checkValidation() async {
    if (email.text.trim().isEmpty && password.text.trim().isEmpty) {
      reusableInstance.toast('Invalid', 'Please enter email and password!');
      return false;
    } else if (email.text.trim().isEmpty) {
      reusableInstance.toast('Invalid', 'Email is empty!');
      return false;
    } else if (password.text.trim().isEmpty) {
      reusableInstance.toast('Invalid', 'Password is empty!');
      return false;
    }
    return true;
  }

  Future<bool> loginBtnClick() async {
    bool isDataValid = await checkValidation();
    if (isDataValid) {
      await pref?.setString('email', email.text.trim());
      var isLogin = await userLogin();
      if (isLogin) {
        cateController = Get.find<CategoryController>();
        bool isCatGet = await cateController!.getCategories();
        if (isCatGet) {
          email.text = '';
          password.text = '';
          return true;
        }
      }
      return false;
    }
    return false;
  }

  Future<bool> userLogin() async {
    return await loginService(email.text, password.text);
  }
}
