import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/QuestionModel.dart';
import '../Services/ApprovedQuestionServices.dart';
import 'TeacherController.dart';

class AdminQuestionsListController extends GetxController {
  List<String> headingTxt = [
    'Email',
    'Total Questions',
    '',
  ];
  var teacherController = Get.put(TeacherController());
  getTeachers() async {
    await teacherController.getTeacher();
  }

  List<QuestionModel> questionModelList = [];
  var question = TextEditingController();
  var option1 = TextEditingController();
  var option2 = TextEditingController();
  var option3 = TextEditingController();
  var option4 = TextEditingController();
  var questionList = [];
  var choicesList = [];
  var isEdit = false;
  var isValid = true;

  var qid;

  List<String> headingText = [
    'Question',
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Total Question : 50000',
  ];

  getquestion() async {
    questionList = [];
    questionModelList = [];
    choicesList = [];
    questionModelList = await getAllApproveQuestionList();

    for (int i = 0; i < questionModelList.length; i++) {
      var lst = [
        questionModelList[i].question,
        questionModelList[i].qid,
      ];
      choicesList.add(questionModelList[i].choiceList);
      questionList.add(lst);
    }
    update();
  }

  addNewQuestions(category, subcategory, teacheremail) async {
    await addApproveQuestions(question.text, option1.text, option2.text, option3.text, option4.text, category, subcategory, teacheremail);
    await copyaddApproveQuestions(question.text, option1.text, option2.text, option3.text, option4.text, category, subcategory, teacheremail);
  }

  updateQuestion(category, subcategory, email) async {
    await editAdminQuestions(question.text, option1.text, option2.text, option3.text, option4.text, category, subcategory, qid, email);
    await copyeditAdminQuestions(question.text, option1.text, option2.text, option3.text, option4.text, category, subcategory, qid, email);
  }

  removeQuestion() async {
    await deleteAdminQuestion(qid);
    await copydeleteAdminQuestion(qid);
  }
}
