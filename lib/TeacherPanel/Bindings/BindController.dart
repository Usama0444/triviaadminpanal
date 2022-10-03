import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/LogInController.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/QuestionsController.dart';

class BindController with Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut(() => LogInController());
    Get.put(LogInController(), permanent: true);
    Get.put(CategoryController(), permanent: true);
    Get.put(QuestionController(), permanent: true);
  }
}
