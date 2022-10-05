import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/AddQuestions.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Categories.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/components/style.dart';
import '../Models/QuestionModel.dart';
import '../Services/QuestionServices.dart';

class QuestionController extends GetxController {
  List<QuestionModel> teacherQuestionModelList = [];
  List<QuestionModel> draftQuestionModelList = [];
  List<QuestionModel> searchQuestion = [];

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
  var draftQID;
  var draftQuestionCreatedAt = DateTime.now();
  var totalQuestionsForSubCategorPage = 0;
  // String? catController.questionCategory, catController.questionSubCategory;
  List<int> totalQuestionOfspecificSubCategory = [];
  List<int> draftCheckedIndex = [];
  int questionSearchIndex = -1;
  bool questionSearchNotMatch = false;
  int listLength = 1;
  int textCounter = 0;
  int textCounterForQuestion = 0;
  List<int> temp = [];
  bool isShowSubCategoryQuestionForm = false;
  bool isShowQuestionlist = false;

  bool isDraftEditPress = false;
  int? editDraftQuestionSelectedIndex;
  List<List<int>> questionLengthPerSubcateogryForAddQuestion = []; //for add question screen drop down menu
  List<List<int>> questionLengthPerSubcateogryForDraftDropDownMenu = []; //this is use for drop down menu in add question screen and draft pages
  bool? isCorrect1, isCorrect2, isCorrect3, isCorrect4;
  List<int> totalUploadSubCategoryQuestionList = [];
  List<int> totalDraftSubCategoryQuestionList = [];

  CategoryController catController = Get.find<CategoryController>();

  bool isLoadingDraft = true;

  int totalDraftQuestion = 0;

  getDraftQuestionsLength() async {
    totalDraftQuestion = await getDraftTotalQuestions();
    update();
  }

  getAllDrafts() async {
    draftQuestionModelList = await getDraftAllQuestions();
    update();
  }

  markCorrectIncorrect() {
    if (question.text.trim().isNotEmpty) {
      if (option1.text.trim().isNotEmpty && answer == 1) {
        isCorrect1 = true;
        isCorrect2 = false;
        isCorrect3 = false;
        isCorrect4 = false;
      } else if (option2.text.trim().isNotEmpty && answer == 2) {
        isCorrect2 = true;
        isCorrect1 = false;
        isCorrect3 = false;
        isCorrect4 = false;
      } else if (option3.text.trim().isNotEmpty && answer == 3) {
        isCorrect3 = true;
        isCorrect2 = false;
        isCorrect1 = false;
        isCorrect4 = false;
      } else if (option4.text.trim().isNotEmpty && answer == 4) {
        isCorrect4 = true;
        isCorrect2 = false;
        isCorrect3 = false;
        isCorrect1 = false;
      }
    }
    update();
  }

  markCorrectIncorrectForEdit() {
    if (answer != null) {
      if (answer == 1) {
        isCorrect1 = true;
        isCorrect2 = false;
        isCorrect3 = false;
        isCorrect4 = false;
      } else if (answer == 2) {
        isCorrect2 = true;
        isCorrect1 = false;
        isCorrect3 = false;
        isCorrect4 = false;
      } else if (answer == 3) {
        isCorrect3 = true;
        isCorrect2 = false;
        isCorrect1 = false;
        isCorrect4 = false;
      } else {
        isCorrect4 = true;
        isCorrect2 = false;
        isCorrect3 = false;
        isCorrect1 = false;
      }
      update();
    }
  }

  checkCategoryAndSubCategoryAlreadySelected() {
    String? catName = catController.categoryName;
    String? subCate = catController.subCategoryName;
    for (int i = 0; i < catController.catList.length; i++) {
      if (catName != null && catController.catList[i].name == catName) {
        catController.catIndex = i;
      }
    }
    if (catController.subCatList.isNotEmpty) {
      for (int i = 0; i < catController.subCatList.length; i++) {
        if (subCate != null && catController.subCatList[i].name == subCate) {
          catController.subCatIndex = i;
        }
      }
    }
    catController.update();
  }

  questionSearchTap() async {
    questionSearchNotMatch = false;
    searchQuestion = [];
    for (int i = 0; i < teacherQuestionModelList.length; i++) {
      if (teacherQuestionModelList[i].question.toLowerCase().contains(questionSerach.text.toLowerCase())) {
        questionSearchNotMatch = false;
        searchQuestion.add(teacherQuestionModelList[i]);
      } else {
        questionSearchNotMatch = true;
      }
    }
    update();
  }

  erasedData() async {
    question.text = '';
    option1.text = '';
    option2.text = '';
    option3.text = '';
    option4.text = '';
    answer = null;
    article.text = '';
    isCorrect1 = null;
    isCorrect2 = null;
    isCorrect3 = null;
    isCorrect4 = null;
    draftQID = null;
    textCounter = 0;
    textCounterForQuestion = 0;
    update();
    catController.categoryName = '';
    catController.subCategoryName = '';
    catController.update();
  }

  uploadBtnClick() async {
    bool isInputValid = await checkValidation();
    if (isInputValid) {
      await addNewQuestions();
      await erasedData();
      await updateTotalQuestionsOfSepecificSubcategoryForAddQuestion();

      if (isDraftEditPress) {
        await deleteDraftBtnClick(editDraftQuestionSelectedIndex!);
        await getDraftQuestions();
      }

      if (catController.subCategoryName != null) {
        await getQuestions(catController.categoryName!, catController.subCategoryName!);
      } else {
        await getQuestions(catController.questionCategory!, catController.questionSubCategory!);
      }
      await getTotalNumberOfQuestionForSpecificCategory();
      await updateTotalQuestionsOfSepecificSubcategoryForDraft();

      reusableInstance.toast('Confirmation Alert', 'Question Added successfully');
    }
  }

  editBtnClick(int index) async {
    if (searchQuestion.isEmpty) {
      question.text = teacherQuestionModelList[index].question;
      option1.text = teacherQuestionModelList[index].choiceList[0];
      option2.text = teacherQuestionModelList[index].choiceList[1];
      option3.text = teacherQuestionModelList[index].choiceList[2];
      option4.text = teacherQuestionModelList[index].choiceList[3];
      article.text = teacherQuestionModelList[index].article;
      qid = teacherQuestionModelList[index].qid;
      catController.questionCategory = teacherQuestionModelList[index].category;
      catController.questionSubCategory = teacherQuestionModelList[index].subcategory;
    } else {
      question.text = searchQuestion[index].question;
      option1.text = searchQuestion[index].choiceList[0];
      option2.text = searchQuestion[index].choiceList[1];
      option3.text = searchQuestion[index].choiceList[2];
      option4.text = searchQuestion[index].choiceList[3];
      article.text = searchQuestion[index].article;
      qid = searchQuestion[index].qid;
      catController.questionCategory = searchQuestion[index].category;
      catController.questionSubCategory = searchQuestion[index].subcategory;
    }
    update();
    catController.update();
    Get.to(AddQuestion(callingFor: 'Edit'));
  }

  deleteBtnClick(int index) async {
    if (searchQuestion.isEmpty) {
      qid = teacherQuestionModelList[index].qid;
    } else {
      qid = searchQuestion[index].qid;
    }
    bool isdelete = await deleteQuestion(qid);

    await getQuestions(catController.categoryName!, catController.subCategoryName!);
    if (isdelete) {
      await Future.delayed(const Duration(seconds: 1));
      reusableInstance.toast('Confirmation Alert', 'Question Deleted successfully');
    }
    await updateTotalNumberOfQuestionForSpecificCategory();
    update();
  }

  increaseTextCounterForArticle(value) {
    textCounter = value;
    update();
  }

  increaseTextCounterForQuestion(value) {
    textCounterForQuestion = value;
    update();
  }

  copyBtnClick(index) {
    Clipboard.setData(ClipboardData(text: teacherQuestionModelList[index].article));
  }

//methods for draft
  Future<bool> draftBtnClick() async {
    bool isInputValid = await checkValidation();
    if (isInputValid) {
      if (draftQID == null) {
        await addToDraft(
          question.text,
          option1.text,
          option2.text,
          option3.text,
          option4.text,
          answer,
          article.text,
          catController.questionCategory,
          catController.questionSubCategory,
        );
        await erasedData();
      } else {
        await updateDraftQuestion(
          question.text,
          option1.text,
          option2.text,
          option3.text,
          option4.text,
          answer,
          article.text,
          catController.questionCategory,
          catController.questionSubCategory,
          draftQID,
          draftQuestionCreatedAt,
        );
        await erasedData();
      }
      await getDraftQuestions();
      await getAllDrafts();
      await getDraftQuestionsLength();
      await updateTotalQuestionsOfSepecificSubcategoryForDraft();

      return true;
    }
    return false;
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
    editDraftQuestionSelectedIndex = index;
    isDraftEditPress = true;
    draftQID = draftQuestionModelList[index].qid;
    catController.questionCategory = null;
    catController.questionSubCategory = null;
    catController.update();
    // draftQuestionCreatedAt = draftQuestionModelList[index].createdAt;
    update();
    if (draftCheckedIndex.isEmpty) {
      Get.to(AddQuestion(callingFor: 'Edit'));
    }
  }

  deleteDraftBtnClick(int index) async {
    qid = draftQuestionModelList[index].qid;
    await deleteDraftQuestion(qid);
    await getDraftQuestions();
    await getAllDrafts();
    await updateTotalQuestionsOfSepecificSubcategoryForDraft();
    update();
  }

  Future<bool> getDraftQuestions() async {
    draftQuestionModelList = await getDraftQuestionsListByCategoryAndSubCategory(
      catController.questionCategory!,
      catController.questionSubCategory!,
    );
    update();
    return true;
  }

////

  Future<bool> checkValidation() async {
    RegExp regex = RegExp(r"[a-zA-Z0-9]");

    if (!regex.hasMatch(question.text.trim())) {
      reusableInstance.toast('Invalid question', 'please enter valid question!');
      return false;
    } else if (!regex.hasMatch(option1.text.trim()) || !regex.hasMatch(option2.text.trim()) || !regex.hasMatch(option3.text.trim()) || !regex.hasMatch(option4.text.trim())) {
      reusableInstance.toast('Invalid question', 'please enter valid options!');
      return false;
    } else if (catController.questionSubCategory == null || catController.questionCategory == null) {
      reusableInstance.toast('Invalid choice', 'please select category and subcategory!');
      return false;
    } else if (question.text.trim().isEmpty && option1.text.trim().isEmpty && option2.text.trim().isEmpty && option3.text.trim().isEmpty && option4.text.trim().isEmpty) {
      reusableInstance.toast('Invalid choice', 'please enter required data');
      return false;
    } else if (question.text.trim().isEmpty) {
      reusableInstance.toast('Invalid choice', 'please enter question!');
      return false;
    } else if (option1.text.trim().isEmpty || option2.text.trim().isEmpty || option3.text.trim().isEmpty || option4.text.trim().isEmpty) {
      reusableInstance.toast('Invalid choice', 'please enter all options!');
      return false;
    } else if (option1.text.trim() == option2.text.trim() ||
        option1.text.trim() == option3.text.trim() ||
        option1.text.trim() == option4.text.trim() ||
        option2.text.trim() == option1.text.trim() ||
        option2.text.trim() == option3.text.trim() ||
        option2.text.trim() == option4.text.trim() ||
        option3.text.trim() == option2.text.trim() ||
        option3.text.trim() == option1.text.trim() ||
        option3.text.trim() == option4.text.trim() ||
        option4.text.trim() == option2.text.trim() ||
        option4.text.trim() == option1.text.trim() ||
        option4.text.trim() == option3.text.trim()) {
      reusableInstance.toast('Invalid Options', 'please enter different options!');
      return false;
    } else if (answer == null) {
      reusableInstance.toast('Invalid choice', 'please select answer!');
      return false;
    } else {
      return true;
    }
  }

  Future<bool> getQuestions(String cat, String subcat) async {
    teacherQuestionModelList = await getQuestionsList(cat, subcat);
    update();
    return true;
  }

  getTotalNumberOfQuestionForSpecificCategory() async {
    totalQuestionOfspecificSubCategory = [];
    totalQuestionsForSubCategorPage = 0;
    var categoryController = Get.find<CategoryController>();
    for (int i = 0; i < categoryController.subCatList.length; i++) {
      var getList = await getQuestionsList(categoryController.categoryName, categoryController.subCatList[i].name);
      totalQuestionOfspecificSubCategory.add(getList.length);
      totalQuestionsForSubCategorPage += getList.length;
      update();
    }
  }

  updateTotalNumberOfQuestionForSpecificCategory() async {
    totalQuestionsForSubCategorPage = 0;
    var categoryController = Get.find<CategoryController>();
    for (int i = 0; i < categoryController.subCatList.length; i++) {
      var getList = await getQuestionsList(categoryController.categoryName, categoryController.subCatList[i].name);
      totalQuestionOfspecificSubCategory[i] = getList.length;
      totalQuestionsForSubCategorPage += getList.length;
      update();
    }
    catController.getCategories();
  }

  Future<int> getTotalQuestions() async {
    return await totalNoOfQuestions();
  }

  addNewQuestions() async {
    await addQuestions(question.text, option1.text, option2.text, option3.text, option4.text, answer, article.text, catController.questionCategory, catController.questionSubCategory);
  }

  teacherUpdateQuestion() async {
    bool isInputValid = await checkValidation();
    if (isInputValid) {
      await editTeacherQuestions(question.text, option1.text, option2.text, option3.text, option4.text, answer, article.text, catController.questionCategory, catController.questionSubCategory, qid);
      await getQuestions(catController.categoryName!, catController.subCategoryName!);
      await getTotalNumberOfQuestionForSpecificCategory();
      await erasedData();
    }
  }

  ///fil list of total question length for Add question screen drop down menu

  getTotalQuestionsOfSepecificSubcategoryForAddQuestion() async {
    questionLengthPerSubcateogryForAddQuestion.clear();
    totalUploadSubCategoryQuestionList.clear();
    var questions;
    int sum = 0;
    for (int i = 0; i < catController.catList.length; i++) {
      temp = [];
      sum = 0;
      for (int j = 0; j < catController.subCategoriesForDrawer[i].length; j++) {
        questions = await getQuestionsList(catController.catList[i].name, catController.subCategoriesForDrawer[i][j].name);
        temp.add(questions.length);
      }
      for (int i = 0; i < temp.length; i++) {
        sum = sum + temp[i];
      }
      questionLengthPerSubcateogryForAddQuestion.add(temp);
      totalUploadSubCategoryQuestionList.add(sum);
      update();
    }
  }

  updateTotalQuestionsOfSepecificSubcategoryForAddQuestion() async {
    var questions;
    int sum = 0;
    for (int i = 0; i < catController.catList.length; i++) {
      temp = [];
      sum = 0;
      for (int j = 0; j < catController.subCategoriesForDrawer[i].length; j++) {
        questions = await getQuestionsList(catController.catList[i].name, catController.subCategoriesForDrawer[i][j].name);
        temp.add(questions.length);
      }
      for (int i = 0; i < temp.length; i++) {
        sum = sum + temp[i];
      }
      questionLengthPerSubcateogryForAddQuestion[i] = temp;
      totalUploadSubCategoryQuestionList[i] = sum;
      update();
    }
  }

  ///fil list of total question length for Draft screen drop down menu

  getTotalQuestionsOfSepecificSubcategoryForDraft() async {
    var questions;
    int sum = 0;
    questionLengthPerSubcateogryForDraftDropDownMenu.clear();
    totalDraftSubCategoryQuestionList.clear();
    for (int i = 0; i < catController.catList.length; i++) {
      temp = [];
      sum = 0;
      for (int j = 0; j < catController.subCategoriesForDrawer[i].length; j++) {
        questions = await getDraftQuestionsListByCategoryAndSubCategory(catController.catList[i].name, catController.subCategoriesForDrawer[i][j].name);
        temp.add(questions.length);
      }
      for (int i = 0; i < temp.length; i++) {
        sum = sum + temp[i];
      }
      totalDraftSubCategoryQuestionList.add(sum);
      questionLengthPerSubcateogryForDraftDropDownMenu.add(temp);
      update();
    }
  }

  updateTotalQuestionsOfSepecificSubcategoryForDraft() async {
    var questions;
    int sum = 0;

    for (int i = 0; i < catController.catList.length; i++) {
      temp = [];
      sum = 0;
      for (int j = 0; j < catController.subCategoriesForDrawer[i].length; j++) {
        questions = await getDraftQuestionsListByCategoryAndSubCategory(catController.catList[i].name, catController.subCategoriesForDrawer[i][j].name);
        temp.add(questions.length);
      }
      for (int i = 0; i < temp.length; i++) {
        sum = sum + temp[i];
      }
      totalDraftSubCategoryQuestionList[i] = sum;
      questionLengthPerSubcateogryForDraftDropDownMenu[i] = temp;
      update();
    }
  }
}
