import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/DashBoradController.dart';
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

 Future<bool> getQuestions(String cat,String subcat) async
 {
  teacherQuestionModelList= await getQuestionsList(cat, subcat);
  update();
  print(teacherQuestionModelList.length);
   return true;
 }
  addNewQuestions(String cat,subcate) async {
    await addQuestions(question.text, option1.text, option2.text, option3.text, option4.text, answer,cat,subcate);
  }

  teacherUpdateQuestion(String cat,subCat) async {
    await editTeacherQuestions(question.text, option1.text, option2.text, option3.text, option4.text, answer, cat,subCat, qid);
  }

  removeQuestion() async {
    await deleteQuestion(qid);
  }
}
