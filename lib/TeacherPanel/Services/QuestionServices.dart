import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/QuestionsController.dart';
import 'package:triviaadminpanal/main.dart';

import '../Models/QuestionModel.dart';

var teacherQuestionCollectionRef = FirebaseFirestore.instance.collection('questions');
var copyteacherQuestionCollectionRef = FirebaseFirestore.instance.collection('copyquestions');

var controller = Get.put(QuestionController());
var email = pref?.getString('email');
Future<List<QuestionModel>> getTeacherQuestionsList(cat, subcat) async {
  var questionList =
      await teacherQuestionCollectionRef.where('email', isEqualTo: email).where('category', isEqualTo: cat).where('subcategory', isEqualTo: subcat).where('isapproved', isEqualTo: 'false').get();
  var questionsList = await questionList.docs.map((e) => QuestionModel.fromJson(e.data())).toList();
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

addQuestions(String question, option1, option2, option3, option4, answer, category, subCategory) async {
  try {
    List<String> choice = [option1, option2, option3, option4];
    var id = teacherQuestionCollectionRef.doc().id;
    if (question == '' || option1 == '' || option2 == '' || option3 == '' || option4 == '') {
      Get.snackbar('Confirmation Alert', 'Invalid Data');
      controller.isValid = false;
      controller.update();
    } else {
      teacherQuestionCollectionRef.doc(id).set({
        'category': category,
        'question': question,
        'choices': choice,
        'answer': answer,
        'qid': id,
        'subcategory': subCategory,
        'email': email,
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
        'isapproved': 'false',
      });
      Get.snackbar('Confirmation Alert', 'Question Added successfully');
    }
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}
