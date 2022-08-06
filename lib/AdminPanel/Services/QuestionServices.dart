import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Models/QuestionModel.dart';
import 'package:triviaadminpanal/AdminPanel/Models/QuestionModel.dart';

import '../Controllers/TeacherQuestionsListController.dart';

var controller = Get.put(TeacherQuestionContoller());
var questionCollectionRef = FirebaseFirestore.instance.collection('questions');

Future<List<QuestionModel>> getAllQuestionListByEmail(email) async {
  var questionList = await questionCollectionRef.where('email', isEqualTo: email).where('isapproved', isEqualTo: 'false').get();
  var questions = await questionList.docs.map((e) => QuestionModel.fromJson(e.data())).toList();
  return questions;
}

Future<List<QuestionModel>> getApprovedQuestionListByEmail(email) async {
  var questionList = await questionCollectionRef.where('email', isEqualTo: email).where('isapproved', isEqualTo: 'true').get();
  var list = await questionList.docs.map((e) => QuestionModel.fromJson(e.data())).toList();
  return list;
}

addQuestions(String question, option1, option2, option3, option4, answer, category, subcategory, email, userType) async {
  try {
    List<String> choice = [option1, option2, option3, option4];
    var id = questionCollectionRef.doc().id;
    questionCollectionRef.doc(id).set({
      'answer': answer,
      'category': category,
      'subcategory': subcategory,
      'question': question,
      'choices': choice,
      'qid': id,
      'email': email,
      'isapproved': 'admin',
    });
    Get.snackbar('Confirmation Alert', 'Question Added successfully');
    questionCollectionRef.doc(id).delete();
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}

approvedQuestionsByAdmin(qid) async {
  try {
    var questionList = await questionCollectionRef.where('qid', isEqualTo: qid).get();
    var list = await questionList.docs.first.data();
    print(list['choices']);
    print('qid $qid');

    questionCollectionRef.doc(qid).update({
      'answer': list['answer'],
      'category': list['category'],
      'subcategory': list['subcategory'],
      'question': list['question'],
      'choices': list['choices'],
      'qid': qid,
      'email': list['email'],
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
