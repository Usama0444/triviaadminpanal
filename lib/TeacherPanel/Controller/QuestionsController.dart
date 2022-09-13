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
  var userEmail = FirebaseAuth.instance.currentUser?.email;
  var dashController = Get.put(DashboardController());
  List<String> headingText = [
    'Question',
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Total Question : 50000',
  ];
  int done = 0;
  getquestionByCategory() async {
    teacherQuestionList = [];
    teacherQuestionModelList = [];
    teacherChoicesList = [];
    teacherQuestionModelList = await getTeacherQuestionsList(
      dashController.ondrawercategory,
      dashController.ondrawersubCategory,
    );
    for (int i = 0; i < teacherQuestionModelList.length; i++) {
      var lst = [
        teacherQuestionModelList[i].question,
        teacherQuestionModelList[i].qid,
        teacherQuestionModelList[i].answer,
      ];
      teacherChoicesList.add(teacherQuestionModelList[i].choiceList);
      teacherQuestionList.add(lst);
    }
    done = 1;
    update();

    // print('teacherQuestion List $teacherQuestionList');
    // print('choices $teacherChoicesList');
  }

  addNewQuestions() async {
    await addQuestions(question.text, option1.text, option2.text, option3.text, option4.text, answer, dashController.category, dashController.subCategory);
  }

  teacherUpdateQuestion() async {
    await editTeacherQuestions(question.text, option1.text, option2.text, option3.text, option4.text, answer, dashController.category, dashController.subCategory, qid);
  }

  removeQuestion() async {
    await deleteQuestion(qid);
  }
}
