import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Services/LoginServices.dart';

class LogInController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  CategoryController? cateController;
  Future<bool> checkValidation() async {
    return true;
  }

  Future<bool> loginBtnClick() async {
    var isLogin = await userLogin();
    if (isLogin) {
      cateController = Get.find<CategoryController>();
      bool isCatGet = await cateController!.getCategories();
      if (isCatGet) {
        return true;
      }
    }
    return false;
  }

  Future<bool> userLogin() async {
    return await loginService(email.text, password.text);
  }

}
