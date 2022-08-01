import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/AddedQuestionsListController.dart';
import 'package:triviaadminpanal/AdminPanel/Models/QuestionModel.dart';
import 'package:triviaadminpanal/AdminPanel/Models/QuestionModel.dart';

var controller = Get.put(AddedQuestionsListController());
var questionCollectionRef = FirebaseFirestore.instance.collection('ApprovedQuestions');
var teacherQuestionCollectionRef = FirebaseFirestore.instance.collection('questions');

Future<List<QuestionModel>> getAllQuestionList() async {
  var questionList = await teacherQuestionCollectionRef.get();
  var questionsList = await questionList.docs.map((e) => QuestionModel.fromJson(e.data())).toList();
  return questionsList;
}

addQuestions(String question, option1, option2, option3, option4, qid) async {
  try {
    List<String> choice = [option1, option2, option3, option4];
    var id = questionCollectionRef.doc().id;
    questionCollectionRef.doc(id).set({
      'category': 'Education',
      'question': question,
      'choices': choice,
      'qid': id,
    });
    Get.snackbar('Confirmation Alert', 'Question Added successfully');
    teacherQuestionCollectionRef.doc(qid).delete();
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}

deleteQuestion(qid) async {
  try {
    teacherQuestionCollectionRef.doc(qid).delete();
    Get.snackbar('Confirmation Alert', 'Question Deleted successfully');
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}
