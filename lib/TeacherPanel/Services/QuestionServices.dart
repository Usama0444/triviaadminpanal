import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/QuestionsController.dart';
import 'package:triviaadminpanal/main.dart';

import '../Models/QuestionModel.dart';
import '../Views/Categories.dart';

var teacherQuestionCollectionRef = FirebaseFirestore.instance.collection('questions');
var copyteacherQuestionCollectionRef = FirebaseFirestore.instance.collection('copyquestions');
var questionsList;
var controller = Get.put(QuestionController());
var email = pref?.getString('email');

Future<List<QuestionModel>> getQuestionsList(cat, subcat) async {
  try {
    var getQuestions = await teacherQuestionCollectionRef.where('email', isEqualTo: email).where('category', isEqualTo: cat).where('subcategory', isEqualTo: subcat).get();
    questionsList = await getQuestions.docs.map((e) => QuestionModel.fromJson(e.data())).toList();
  } catch (e) {
    reusableInstance.toast('Error', '$e');
  }
  return questionsList;
}

deleteQuestion(qid) async {
  try {
    teacherQuestionCollectionRef.doc(qid).delete();
    copyteacherQuestionCollectionRef.doc(qid).delete();
    reusableInstance.toast('Confirmation Alert', 'Question Deleted successfully');
  } catch (e) {
    reusableInstance.toast('Error', 'something went wrong!!');
  }
}

editTeacherQuestions(String question, option1, option2, option3, option4, answer, article, category, subCategory, qid) async {
  try {
    List<String> choice = [option1, option2, option3, option4];
    if (question == '' || option1 == '' || option2 == '' || option3 == '' || option4 == '') {
      reusableInstance.toast('Confirmation Alert', 'Invalid Data');
      controller.isValid = false;
      controller.update();
    } else {
      teacherQuestionCollectionRef.doc(qid).update({
        'category': category,
        'question': question,
        'choices': choice,
        'answer': answer,
        'qid': qid,
        'subcategory': subCategory,
        'email': email,
        'article': article,
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
        'type': 'update Question',
        'isapproved': 'false',
      });
      copyteacherQuestionCollectionRef.doc(qid).update({
        'category': category,
        'question': question,
        'choices': choice,
        'answer': answer,
        'qid': qid,
        'subcategory': subCategory,
        'email': email,
        'article': article,
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
        'type': 'update Question',
        'isapproved': 'false',
      });
      reusableInstance.toast('Confirmation Alert', 'Question Updated successfully');
    }
  } catch (e) {
    reusableInstance.toast('Error', 'something went wrong!!');
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
    reusableInstance.toast('Confirmation Alert', 'Question Added successfully');
  } catch (e) {
    reusableInstance.toast('Error', 'something went wrong!!');
  }
}
