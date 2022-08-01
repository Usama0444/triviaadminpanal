import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/DashBoradController.dart';
import 'package:triviaadminpanal/AdminPanel/Models/QuestionModel.dart';
import 'package:triviaadminpanal/AdminPanel/Services/QuestionServices.dart';

class AddedQuestionsListController extends GetxController {
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
    questionModelList = await getAllQuestionList();

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

  approveQuestion() async {
    await addQuestions(question.text, option1.text, option2.text, option3.text, option4.text, qid);
  }
}
