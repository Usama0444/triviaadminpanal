import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/AddQuestions.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/components/style.dart';
import '../Models/QuestionModel.dart';
import '../Services/QuestionServices.dart';

class QuestionController extends GetxController {
  List<QuestionModel> teacherQuestionModelList = [];
  List<QuestionModel> draftQuestionModelList = [];

  var question = TextEditingController();
  var option1 = TextEditingController();
  var option2 = TextEditingController();
  var option3 = TextEditingController();
  var option4 = TextEditingController();
  var answer;
  var article = TextEditingController();
  var questionSerach = TextEditingController();
  var teacherQuestionList = [];
  var teacherChoicesList = [];
  var isEdit = false;
  var isValid = true;
  var qid;
  var totalQuestions = 0;
  String? questionCategory, questionSubCategory;
  List<int> totalQuestionOfspecificSubCategory = [];
  List<int> draftCheckedIndex = [];
  int questionSearchIndex = -1;
  bool questionSearchNotMatch = false;
  int listLength = 1;
  questionSearchTap() async {
    questionSearchNotMatch = false;
    listLength = 1;
    questionSearchIndex - 1;
    for (int i = 0; i < teacherQuestionModelList.length; i++) {
      if (teacherQuestionModelList[i].question.toLowerCase().contains(questionSerach.text.toLowerCase())) {
        questionSearchIndex = i;
        questionSearchNotMatch = false;
        listLength++;
      } else {
        questionSearchNotMatch = true;
      }
    }
    update();
    print('questionSearchIndex $listLength');
  }

  ErasedData() async {
    question.text = '';
    option1.text = '';
    option2.text = '';
    option3.text = '';
    option4.text = '';
    answer = 0;
    article.text = '';
    update();
  }

  uploadBtnClick() async {
    CategoryController cateController = Get.find<CategoryController>();

    if (draftCheckedIndex.isNotEmpty) {
      for (int i = 0; i < draftCheckedIndex.length; i++) {
        await editDraftBtnClick(draftCheckedIndex[i]);
        await addNewQuestions();
        await ErasedData();
        await deleteDraftBtnClick(draftCheckedIndex[i]);
      }
      await getDraftQuestions(questionCategory!, questionSubCategory!);
      draftCheckedIndex = [];
      update();
    } else {
      await addNewQuestions();
      await ErasedData();
    }
  }

  editBtnClick(int index) async {
    question.text = teacherQuestionModelList[index].question;
    option1.text = teacherQuestionModelList[index].choiceList[0];
    option2.text = teacherQuestionModelList[index].choiceList[1];
    option3.text = teacherQuestionModelList[index].choiceList[2];
    option4.text = teacherQuestionModelList[index].choiceList[3];
    article.text = teacherQuestionModelList[index].article;
    qid = teacherQuestionModelList[index].qid;
    Get.to(AddQuestion(callingFor: 'Edit'));
  }

  deleteBtnClick(int index) async {
    qid = teacherQuestionModelList[index].qid;
    update();
    await removeQuestion();
  }

  copyBtnClick(index) {
    Clipboard.setData(ClipboardData(text: teacherQuestionModelList[index].article));
  }

//methods for draft
  draftBtnClick() async {
    await addToDraft(question.text, option1.text, option2.text, option3.text, option4.text, answer, article.text, questionCategory, questionSubCategory);
  }

  editDraftBtnClick(int index) async {
    question.text = draftQuestionModelList[index].question;
    option1.text = draftQuestionModelList[index].choiceList[0];
    option2.text = draftQuestionModelList[index].choiceList[1];
    option3.text = draftQuestionModelList[index].choiceList[2];
    option4.text = draftQuestionModelList[index].choiceList[3];
    article.text = draftQuestionModelList[index].article;
    answer = draftQuestionModelList[index].answer;
    qid = draftQuestionModelList[index].qid;
    if (draftCheckedIndex.isEmpty) {
      Get.to(AddQuestion(callingFor: 'Edit'));
    }
  }

  deleteDraftBtnClick(int index) async {
    qid = draftQuestionModelList[index].qid;
    update();
    await deleteDraftQuestion(qid);
  }

  Future<bool> getDraftQuestions(String cat, String subcat) async {
    draftQuestionModelList = await getDraftQuestionsList(cat, subcat);
    update();
    return true;
  }

////

  Future<bool> getQuestions(String cat, String subcat) async {
    teacherQuestionModelList = await getQuestionsList(cat, subcat);
    update();
    return true;
  }

  getTotalNumberOfQuestionForSpecificCategory() async {
    totalQuestionOfspecificSubCategory = [];
    totalQuestions = 0;
    var categoryController = Get.find<CategoryController>();
    for (int i = 0; i < categoryController.subCatList.length; i++) {
      var getList = await getQuestionsList(categoryController.categoryName, categoryController.subCatList[i].name);
      totalQuestionOfspecificSubCategory.add(getList.length);
      totalQuestions += getList.length;
    }
    update();
  }

  Future<int> getTotalQuestions() async {
    return await totalNoOfQuestions();
  }

  addNewQuestions() async {
    await addQuestions(question.text, option1.text, option2.text, option3.text, option4.text, answer, article.text, questionCategory, questionSubCategory);
  }

  teacherUpdateQuestion() async {
    await editTeacherQuestions(question.text, option1.text, option2.text, option3.text, option4.text, answer, article.text, questionCategory, questionSubCategory, qid);
  }

  removeQuestion() async {
    await deleteQuestion(qid);
  }
}
