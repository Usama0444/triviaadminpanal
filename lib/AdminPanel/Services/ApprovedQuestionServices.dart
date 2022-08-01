import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/AddedQuestionsListController.dart';
import 'package:triviaadminpanal/AdminPanel/Models/QuestionModel.dart';
import 'package:triviaadminpanal/AdminPanel/Models/QuestionModel.dart';

var controller = Get.put(AddedQuestionsListController());
var questionCollectionRef = FirebaseFirestore.instance.collection('questions');

Future<List<QuestionModel>> getAllApproveQuestionList() async {
  var questionList = await questionCollectionRef.get();
  var questionsList = await questionList.docs.map((e) => QuestionModel.fromJson(e.data())).toList();
  return questionsList;
}

Future<List<QuestionModel>> getTeacherQuestionsList(String cat, subCat, email) async {
  var questionList = await questionCollectionRef.where('email', isEqualTo: email).where('category', isEqualTo: cat).where('subcategory', isEqualTo: subCat).get();
  var questionsList = await questionList.docs.map((e) => QuestionModel.fromJson(e.data())).toList();
  return questionsList;
}

addApproveQuestions(String question, option1, option2, option3, option4, category, subCategory, teacheremail) async {
  try {
    List<String> choice = [option1, option2, option3, option4];
    var id = questionCollectionRef.doc().id;
    if (question == '' || option1 == '' || option2 == '' || option3 == '' || option4 == '') {
      Get.snackbar('Confirmation Alert', 'Invalid Data');
      controller.isValid = false;
      controller.update();
    } else {
      questionCollectionRef.doc(id).set({
        'category': category,
        'question': question,
        'choices': choice,
        'qid': id,
        'subcategory': subCategory,
        'teacheremail': teacheremail,
        'isapproved': 'false',
      });
      Get.snackbar('Confirmation Alert', 'Question Added successfully');
    }
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}

editApproveQuestions(String question, option1, option2, option3, option4, qid) async {
  try {
    List<String> choice = [option1, option2, option3, option4];
    if (question == '' || option1 == '' || option2 == '' || option3 == '' || option4 == '') {
      Get.snackbar('Confirmation Alert', 'Invalid Data');
      controller.isValid = false;
      controller.update();
    } else {
      questionCollectionRef.doc(qid).update({
        'category': 'Education',
        'question': question,
        'choices': choice,
        'qid': qid,
      });
      Get.snackbar('Confirmation Alert', 'Question Updated successfully');
    }
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}

editTeacherQuestions(String question, option1, option2, option3, option4, categpry, subcategory, qid, email) async {
  try {
    List<String> choice = [option1, option2, option3, option4];
    if (question == '' || option1 == '' || option2 == '' || option3 == '' || option4 == '') {
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
        'teacheremail': email,
        'isapproved': 'false',
      });
      Get.snackbar('Confirmation Alert', 'Question Updated successfully');
    }
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}

deleteApproveQuestion(qid) async {
  try {
    questionCollectionRef.doc(qid).delete();
    Get.snackbar('Confirmation Alert', 'Question Deleted successfully');
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}
