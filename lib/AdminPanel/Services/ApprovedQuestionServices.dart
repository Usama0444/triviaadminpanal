import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/TeacherQuestionsListController.dart';
import 'package:triviaadminpanal/AdminPanel/Models/QuestionModel.dart';
import 'package:triviaadminpanal/AdminPanel/Models/QuestionModel.dart';

var controller = Get.put(TeacherQuestionContoller());
var questionCollectionRef = FirebaseFirestore.instance.collection('questions');
var copyquestionCollectionRef = FirebaseFirestore.instance.collection('copyquestions');
var email = FirebaseAuth.instance.currentUser?.email;
Future<List<QuestionModel>> getAllApproveQuestionList() async {
  var questionList = await questionCollectionRef.where('isapproved', isEqualTo: 'true').get();
  var questionsList = await questionList.docs.map((e) => QuestionModel.fromJson(e.data())).toList();
  return questionsList;
}

addApproveQuestions(String question, option1, option2, option3, option4, answer, category, subCategory, email) async {
  try {
    List<String> choice = [option1, option2, option3, option4];
    var id = questionCollectionRef.doc().id;
    if (question.trim() == '' || option1.trim() == '' || option2.trim() == '' || option3.trim() == '' || option4.trim() == '') {
      Get.snackbar('Confirmation Alert', 'Invalid Data');
      controller.isValid = false;
      controller.update();
    } else {
      questionCollectionRef.doc(id).set({
        'category': category,
        'question': question,
        'choices': choice,
        'qid': id,
        'answer': answer,
        'subcategory': subCategory,
        'email': email,
        'isapproved': 'true',
      });
      Get.snackbar('Confirmation Alert', 'Question Added successfully');
    }
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}

editAdminQuestions(String question, option1, option2, option3, option4, answer, categpry, subcategory, qid, email) async {
  try {
    List<String> choice = [option1, option2, option3, option4];
    if (question.trim() == '' || option1.trim() == '' || option2.trim() == '' || option3.trim() == '' || option4.trim() == '') {
      Get.snackbar('Confirmation Alert', 'Invalid Data');
      controller.isValid = false;
      controller.update();
    } else {
      questionCollectionRef.doc(qid).update({
        'category': categpry,
        'subcategory': subcategory,
        'question': question,
        'choices': choice,
        'qid': qid,
        'answer': answer,
        'teacheremail': email,
        'isapproved': 'true',
      });
      Get.snackbar('Confirmation Alert', 'Question Updated successfully');
    }
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}

deleteAdminQuestion(qid) async {
  try {
    questionCollectionRef.doc(qid).delete();
    Get.snackbar('Confirmation Alert', 'Question Deleted successfully');
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}

//this is Question Collection copies

copyaddApproveQuestions(String question, option1, option2, option3, option4, answer, category, subCategory, teacheremail) async {
  try {
    List<String> choice = [option1, option2, option3, option4];
    var id = copyquestionCollectionRef.doc().id;
    if (question.trim() == '' || option1.trim() == '' || option2.trim() == '' || option3.trim() == '' || option4.trim() == '') {
      controller.isValid = false;
      controller.update();
    } else {
      copyquestionCollectionRef.doc(id).set({
        'category': category,
        'question': question,
        'choices': choice,
        'qid': id,
        'answer': answer,
        'subcategory': subCategory,
        'email': email,
        'isapproved': 'true',
      });
    }
  } catch (e) {}
}

copyeditAdminQuestions(String question, option1, option2, option3, option4, answer, categpry, subcategory, qid, email) async {
  try {
    List<String> choice = [option1, option2, option3, option4];
    if (question.trim() == '' || option1.trim() == '' || option2.trim() == '' || option3.trim() == '' || option4.trim() == '') {
      controller.isValid = false;
      controller.update();
    } else {
      copyquestionCollectionRef.doc(qid).update({
        'category': categpry,
        'subcategory': subcategory,
        'question': question,
        'choices': choice,
        'qid': qid,
        'answer': answer,
        'email': email,
        'isapproved': 'true',
      });
    }
  } catch (e) {}
}

copydeleteAdminQuestion(qid) async {
  try {
    copyquestionCollectionRef.doc(qid).delete();
  } catch (e) {}
}
