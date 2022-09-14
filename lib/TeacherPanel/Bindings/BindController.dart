import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/LogInController.dart';

class BindController with Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut(() => LogInController());

    Get.put(CategoryController(), permanent: true);
  }
}
