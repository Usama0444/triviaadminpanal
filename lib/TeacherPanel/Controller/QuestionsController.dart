import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/DashBoradController.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/components/style.dart';
import '../Models/QuestionModel.dart';
import '../Services/QuestionServices.dart';

class QuestionController extends GetxController {
  List<QuestionModel> teacherQuestionModelList = [];
  var question = TextEditingController();
  var option1 = TextEditingController();
  var option2 = TextEditingController();
  var option3 = TextEditingController();
  var option4 = TextEditingController();
  var answer;
  var teacherQuestionList = [];
  var teacherChoicesList = [];
  var isEdit = false;
  var isValid = true;
  var qid;
  var totalQuestions = 0;
  List<int> totalQuestionOfspecificSubCategory = [];
  Future<bool> getQuestions(String cat, String subcat) async {
    teacherQuestionModelList = await getQuestionsList(cat, subcat);
    update();
    print(teacherQuestionModelList.length);
    return true;
  }

  getTotalNumberOfQuestion() async {
    totalQuestionOfspecificSubCategory = [];
    totalQuestions = 0;
    var categoryController = Get.find<CategoryController>();
    for (int i = 0; i < categoryController.subCatList.length; i++) {
      print('${categoryController.categoryName}, ${categoryController.subCatList[i].name}');
      var getList = await getQuestionsList(categoryController.categoryName, categoryController.subCatList[i].name);
      totalQuestionOfspecificSubCategory.add(getList.length);
      totalQuestions += getList.length;
    }
    update();
  }

  addNewQuestions(String cat, subcate) async {
    await addQuestions(question.text, option1.text, option2.text, option3.text, option4.text, answer, cat, subcate);
  }

  teacherUpdateQuestion(String cat, subCat) async {
    await editTeacherQuestions(question.text, option1.text, option2.text, option3.text, option4.text, answer, cat, subCat, qid);
  }

  removeQuestion() async {
    await deleteQuestion(qid);
  }
}
