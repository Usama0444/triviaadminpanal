import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';

import '../Services/CategoryServices.dart';
import '../Services/LoginServices.dart';

class LogInController extends GetxController {
  userAuth(email, pass) async {
    await userLogin(email, pass);
  }
}
