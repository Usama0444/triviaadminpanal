import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Models/QuestionModel.dart';
import 'package:triviaadminpanal/AdminPanel/Models/QuestionModel.dart';

import '../Controllers/TeacherQuestionsListController.dart';

var controller = Get.put(TeacherQuestionContoller());
var questionCollectionRef = FirebaseFirestore.instance.collection('questions');
var approveQuestionCollectionRef = FirebaseFirestore.instance.collection('Approvedquestions');

Future<List<QuestionModel>> getAllQuestionListByEmail(email) async {
  var questionList = await questionCollectionRef.where('email', isEqualTo: email).where('isapproved', isEqualTo: 'false').get();
  var questions = await questionList.docs.map((e) => QuestionModel.fromJson(e.data())).toList();
  return questions;
}

Future<List<QuestionModel>> getApprovedQuestionListByEmail(email) async {
  print('get approved $email');
  var questionList = await approveQuestionCollectionRef.where('email', isEqualTo: email).get();
  var list = await questionList.docs.map((e) => QuestionModel.fromJson(e.data())).toList();
  print(list);
  return list;
}

addQuestions(String question, option1, option2, option3, option4, category, subcategory, email, userType) async {
  try {
    List<String> choice = [option1, option2, option3, option4];
    var id = questionCollectionRef.doc().id;
    questionCollectionRef.doc(id).set({
      'category': category,
      'subcategory': subcategory,
      'question': question,
      'choices': choice,
      'qid': id,
      'email': email,
      'isapproved': userType == 'admin' ? 'true' : 'false',
    });
    Get.snackbar('Confirmation Alert', 'Question Added successfully');
    questionCollectionRef.doc(id).delete();
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}

approvedQuestionsByAdmin(String question, option1, option2, option3, option4, category, subcategory, email, qid) async {
  try {
    print('in add');
    List<String> choice = [option1, option2, option3, option4];
    approveQuestionCollectionRef.doc(qid).set({
      'category': category,
      'subcategory': subcategory,
      'question': question,
      'choices': choice,
      'qid': qid,
      'email': email,
      'isapproved': 'true',
    });
    Get.snackbar('Confirmation Alert', 'Question Approved successfully');
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}

deleteQuestion(qid) async {
  try {
    questionCollectionRef.doc(qid).delete();
    Get.snackbar('Confirmation Alert', 'Question Deleted successfully');
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}

deleteApprovedQuestion(qid) async {
  try {
    questionCollectionRef.doc(qid).delete();
    Get.snackbar('Confirmation Alert', 'Question Deleted successfully');
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}
