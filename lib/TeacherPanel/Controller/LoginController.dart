import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Services/CategoryServices.dart';

import '../Services/LoginServices.dart';

class LogInController extends GetxController {
  userAuth(email, pass) async {
    await userLogin(email, pass);
    await getAllCategoryList();
  }
}
