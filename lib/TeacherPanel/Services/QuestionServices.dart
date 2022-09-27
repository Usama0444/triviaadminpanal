import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/QuestionsController.dart';
import 'package:triviaadminpanal/main.dart';

import '../Models/QuestionModel.dart';
import '../Views/Categories.dart';

var questionCollectionRef = FirebaseFirestore.instance.collection('questions');
var draftCollection = FirebaseFirestore.instance.collection('draft');
var copyQuestionCollectionRef = FirebaseFirestore.instance.collection('copyquestions');
var questionsList;
var controller = Get.put(QuestionController());
var email = pref?.getString('email') ?? FirebaseAuth.instance.currentUser?.email;

Future<List<QuestionModel>> getQuestionsList(cat, subcat) async {
  try {
    print(email);
    print(cat);
    print(subcat);

    var getQuestions = await questionCollectionRef.where('email', isEqualTo: email).where('category', isEqualTo: cat).where('subcategory', isEqualTo: subcat).get();
    questionsList = getQuestions.docs.map((e) => QuestionModel.fromJson(e.data())).toList();
  } catch (e) {
    reusableInstance.toast('Error', '$e');
  }
  return questionsList;
}

deleteQuestion(qid) async {
  try {
    questionCollectionRef.doc(qid).delete();
    copyQuestionCollectionRef.doc(qid).delete();
    reusableInstance.toast('Confirmation Alert', 'Question Deleted successfully');
  } catch (e) {
    reusableInstance.toast('Error', 'something went wrong!!');
  }
}

editTeacherQuestions(String question, option1, option2, option3, option4, answer, article, category, subCategory, qid) async {
  try {
    List<String> choice = [option1, option2, option3, option4];

    questionCollectionRef.doc(qid).update({
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
    copyQuestionCollectionRef.doc(qid).update({
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
  } catch (e) {
    reusableInstance.toast('Error', 'something went wrong!!');
  }
}

addQuestions(String question, option1, option2, option3, option4, answer, article, category, subCategory) async {
  try {
    List<String> choice = [option1, option2, option3, option4];
    var id = questionCollectionRef.doc().id;

    questionCollectionRef.doc(id).set({
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
    copyQuestionCollectionRef.doc(id).set({
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

Future<List<QuestionModel>> getDraftQuestionsList(cat, subcat) async {
  try {
    var getQuestions = await draftCollection.where('email', isEqualTo: email).where('category', isEqualTo: cat).where('subcategory', isEqualTo: subcat).get();
    questionsList = getQuestions.docs.map((e) => QuestionModel.fromJson(e.data())).toList();
  } catch (e) {
    reusableInstance.toast('Error', '$e');
  }
  return questionsList;
}

addToDraft(String question, option1, option2, option3, option4, answer, article, category, subCategory) {
  try {
    List<String> choice = [option1, option2, option3, option4];
    var id = questionCollectionRef.doc().id;

    draftCollection.doc(id).set({
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
      'type': 'Draft',
      'isapproved': 'false',
    });
    reusableInstance.toast('Add', 'Add to Draft');
  } catch (e) {
    reusableInstance.toast('Error', '$e');
  }
}

deleteDraftQuestion(qid) async {
  try {
    draftCollection.doc(qid).delete();

    reusableInstance.toast('Confirmation Alert', 'Draft Question Deleted successfully');
  } catch (e) {
    reusableInstance.toast('Error', 'something went wrong!!');
  }
}

editDraftQuestions(String question, option1, option2, option3, option4, answer, article, category, subCategory, qid) async {
  try {
    List<String> choice = [option1, option2, option3, option4];
    draftCollection.doc(qid).update({
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
      'type': 'update Draft',
      'isapproved': 'false',
    });

    reusableInstance.toast('Confirmation Alert', 'Draft Question Updated successfully');
  } catch (e) {
    reusableInstance.toast('Error', 'something went wrong!!');
  }
}

Future<int> totalNoOfQuestions() async {
  try {
    int total = 0;
    var questions = await questionCollectionRef.get();

    total = questions.docs.length;
    return total;
  } catch (e) {
    reusableInstance.toast('Error', '$e');
    return 0;
  }
}

updateDraftQuestion(String question, option1, option2, option3, option4, answer, article, category, subCategory, qid, createdAt) {
  try {
    List<String> choice = [option1, option2, option3, option4];

    draftCollection.doc(qid).update({
      'category': category,
      'question': question,
      'choices': choice,
      'answer': answer,
      'qid': qid,
      'subcategory': subCategory,
      'email': email,
      'article': article,
      'createdAt': createdAt,
      'updatedAt': DateTime.now(),
      'type': 'Update',
      'isapproved': 'false',
    });
    reusableInstance.toast('Updated', 'Updated Draft Question');
  } catch (e) {
    reusableInstance.toast('Error', '$e');
  }
}
