import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/DashBoradController.dart';
import 'package:triviaadminpanal/AdminPanel/Models/QuestionModel.dart';
import 'package:triviaadminpanal/AdminPanel/Services/QuestionServices.dart';

class TeacherQuestionContoller extends GetxController {
  List<QuestionModel> questionModelList = [];
  var question = TextEditingController();
  var option1 = TextEditingController();
  var option2 = TextEditingController();
  var option3 = TextEditingController();
  var option4 = TextEditingController();
  var questionList = [];
  var choicesList = [];
  var teacherEmail;
  var isEdit = false;
  var isValid = true;
  var qid;
  var dashboradCon = Get.put(DashboardController());

  List<String> headingText = [
    'Question',
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Total Question : 50000',
  ];

  getquestionByteacherEmail() async {
    questionList = [];
    questionModelList = [];
    choicesList = [];
    questionModelList = await getAllQuestionListByEmail(teacherEmail);

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

  getApprovedquestionByteacherEmail() async {
    print('in apporved');
    questionList = [];
    questionModelList = [];
    choicesList = [];
    questionModelList = await getApprovedQuestionListByEmail(teacherEmail);

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

  removeQuestion() async {
    await deleteQuestion(qid);
  }

  removeApprovedQuestion() async {
    await deleteApprovedQuestion(qid);
  }

  approveQuestion() async {
    await approvedQuestionsByAdmin(question.text, option1.text, option2.text, option3.text, option4.text, dashboradCon.category, dashboradCon.subCategory, teacherEmail, qid);
  }
}
