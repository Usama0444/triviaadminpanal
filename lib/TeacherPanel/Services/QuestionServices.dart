import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/QuestionsController.dart';
import 'package:triviaadminpanal/main.dart';

import '../Models/QuestionModel.dart';

var teacherQuestionCollectionRef = FirebaseFirestore.instance.collection('questions');
var copyteacherQuestionCollectionRef = FirebaseFirestore.instance.collection('copyquestions');
var questionsList;
var controller = Get.put(QuestionController());
var email = FirebaseAuth.instance.currentUser?.email;

Future<List<QuestionModel>> getQuestionsList(cat, subcat) async {
  try {
    var getQuestions = await teacherQuestionCollectionRef.where('email', isEqualTo: email).where('category', isEqualTo: cat).where('subcategory', isEqualTo: subcat).get();
    questionsList = await getQuestions.docs.map((e) => QuestionModel.fromJson(e.data())).toList();
  } catch (e) {
    Get.snackbar('Error', '$e');
  }
  return questionsList;
}

deleteQuestion(qid) async {
  try {
    teacherQuestionCollectionRef.doc(qid).delete();
    copyteacherQuestionCollectionRef.doc(qid).delete();
    Get.snackbar('Confirmation Alert', 'Question Deleted successfully');
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}

editTeacherQuestions(String question, option1, option2, option3, option4, answer, categpry, subcategory, qid) async {
  try {
    List<String> choice = [option1, option2, option3, option4];
    if (question == '' || option1 == '' || option2 == '' || option3 == '' || option4 == '') {
      Get.snackbar('Confirmation Alert', 'Invalid Data');
      controller.isValid = false;
      controller.update();
    } else {
      teacherQuestionCollectionRef.doc(qid).update({
        'category': categpry,
        'subcategory': subcategory,
        'question': question,
        'choices': choice,
        'answer': answer,
        'qid': qid,
        'email': email,
        'isapproved': 'false',
      });
      copyteacherQuestionCollectionRef.doc(qid).update({
        'category': categpry,
        'subcategory': subcategory,
        'question': question,
        'choices': choice,
        'answer': answer,
        'qid': qid,
        'email': email,
        'isapproved': 'false',
      });
      Get.snackbar('Confirmation Alert', 'Question Updated successfully');
    }
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}

addQuestions(String question, option1, option2, option3, option4, answer, article, category, subCategory) async {
  try {
    List<String> choice = [option1, option2, option3, option4];
    var id = teacherQuestionCollectionRef.doc().id;

    teacherQuestionCollectionRef.doc(id).set({
      'category': category,
      'question': question,
      'choices': choice,
      'answer': answer,
      'qid': id,
      'subcategory': subCategory,
      'email': email,
      'article': article,
      'createdAt': DateTime.now(),
      'updatedAt': DateTime.now(),
      'type': 'Add new Question',
      'isapproved': 'false',
    });
    copyteacherQuestionCollectionRef.doc(id).set({
      'category': category,
      'question': question,
      'choices': choice,
      'answer': answer,
      'qid': id,
      'subcategory': subCategory,
      'email': email,
      'article': article,
      'createdAt': DateTime.now(),
      'updatedAt': DateTime.now(),
      'type': 'Add new Question',
      'isapproved': 'false',
    });
    Get.snackbar('Confirmation Alert', 'Question Added successfully');
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}
