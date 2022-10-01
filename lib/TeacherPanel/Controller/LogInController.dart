import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Services/LoginServices.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Categories.dart';

import '../../main.dart';

class LogInController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  CategoryController? cateController;
  bool isLoading = true;
  double dotIndex = 0.0;
  bool obxTxt = true;

  obxTxtState() {
    if (obxTxt) {
      obxTxt = false;
    } else {
      obxTxt = true;
    }
    update();
  }

  dotBtnState(index) {
    dotIndex = index;
    update();
  }

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

  Future<void> loginBtnClick() async {
    bool isDataValid = await checkValidation();
    if (isDataValid) {
      Get.dialog(Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            reusableInstance.loader(),
          ],
        ),
      ));

      var isLogin = await userLogin();
      if (isLogin) {
        await pref?.setBool('logedin', true);
        await pref?.setString('email', email.text.trim());
        cateController = Get.find<CategoryController>();
        bool isCatGet = await cateController!.getCategories();
        if (isCatGet) {
          email.text = '';
          password.text = '';
          Get.offAll(Categories());
        }
      }
    }
  }

  Future<bool> userLogin() async {
    return await loginService(email.text, password.text);
  }
}
