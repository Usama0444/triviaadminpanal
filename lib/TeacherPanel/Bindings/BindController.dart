import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';

class BindController with Bindings {
  @override
  Future<void> dependencies() async {
    Get.put(CategoryController(), permanent: true);
  }
}
