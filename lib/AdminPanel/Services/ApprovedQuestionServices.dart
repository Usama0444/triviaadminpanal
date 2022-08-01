import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/TeacherQuestionsListController.dart';
import 'package:triviaadminpanal/AdminPanel/Models/QuestionModel.dart';
import 'package:triviaadminpanal/AdminPanel/Models/QuestionModel.dart';

var controller = Get.put(TeacherQuestionContoller());
var questionCollectionRef = FirebaseFirestore.instance.collection('questions');
var copyquestionCollectionRef = FirebaseFirestore.instance.collection('copyquestions');

Future<List<QuestionModel>> getAllApproveQuestionList() async {
  var questionList = await questionCollectionRef.where('isapproved', isEqualTo: 'true').get();
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
        'isapproved': 'true',
      });
      Get.snackbar('Confirmation Alert', 'Question Added successfully');
    }
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}

editAdminQuestions(String question, option1, option2, option3, option4, categpry, subcategory, qid, email) async {
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

copyaddApproveQuestions(String question, option1, option2, option3, option4, category, subCategory, teacheremail) async {
  try {
    List<String> choice = [option1, option2, option3, option4];
    var id = copyquestionCollectionRef.doc().id;
    if (question == '' || option1 == '' || option2 == '' || option3 == '' || option4 == '') {
      controller.isValid = false;
      controller.update();
    } else {
      copyquestionCollectionRef.doc(id).set({
        'category': category,
        'question': question,
        'choices': choice,
        'qid': id,
        'subcategory': subCategory,
        'teacheremail': teacheremail,
        'isapproved': 'true',
      });
    }
  } catch (e) {}
}

copyeditAdminQuestions(String question, option1, option2, option3, option4, categpry, subcategory, qid, email) async {
  try {
    List<String> choice = [option1, option2, option3, option4];
    if (question == '' || option1 == '' || option2 == '' || option3 == '' || option4 == '') {
      controller.isValid = false;
      controller.update();
    } else {
      copyquestionCollectionRef.doc(qid).update({
        'category': categpry,
        'subcategory': subcategory,
        'question': question,
        'choices': choice,
        'qid': qid,
        'teacheremail': email,
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
