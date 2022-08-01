import 'package:get/get.dart';

import '../Services/LoginServices.dart';

class LogInController extends GetxController {
  userAuth(email, pass) async {
    await userLogin(email, pass);
  }
}
