import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/UserController.dart';
import 'package:triviaadminpanal/AdminPanel/Services/LoginServices.dart';

class LogInController extends GetxController {
  UserController controller = Get.put(UserController());
  userAuth(email, pass) async {
    await userLogin(email, pass);
    await controller.getUser();
  }
}
