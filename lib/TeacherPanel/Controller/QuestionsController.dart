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
  var totalQuestions = 0;
  String? questionCategory, questionSubCategory;
  List<int> totalQuestionOfspecificSubCategory = [];
  List<int> draftCheckedIndex = [];
  int questionSearchIndex = -1;
  bool questionSearchNotMatch = false;
  int listLength = 1;
  int textCounter = 0;
  List<bool> hideCategory = [];
  List<bool> showSubCategory = [];
  bool isShowSubCategoryQuestionForm = false;
  int? catIndex, subCatIndex;

  CategoryController catController = Get.find<CategoryController>();

  List<Color> highlightSubCategories = [];

  highlightSpecificSubCategory(index) {
    for (int i = 0; i < 10; i++) {
      highlightSubCategories[i] = whiteColor;
    }
    highlightSubCategories[index] = Colors.green.withOpacity(0.5);
    isShowSubCategoryQuestionForm = true;
    update();
  }

  highlightSpecificSubCategoryInit() {
    highlightSubCategories = [];
    for (int i = 0; i < 10; i++) {
      highlightSubCategories.add(whiteColor);
    }
    update();
  }

  hideShowListInit() {
    hideCategory = [];
    showSubCategory = [];
    for (int i = 0; i < 20; i++) {
      hideCategory.add(true);
      showSubCategory.add(false);
    }
    if (catIndex != null) {
      if (hideCategory[catIndex!]) {
        hideCategory[catIndex!] = false;
        showSubCategory[catIndex!] = true;
      }
      questionCategory = catController.catList[catIndex!].name;
    }
    if (subCatIndex != null) {
      highlightSpecificSubCategory(subCatIndex! + 1);
      isShowSubCategoryQuestionForm = true;
      questionSubCategory = catController.subCatList[subCatIndex!].name;
    }
    update();
  }

  hideShowDropDown(index) async {
    if (hideCategory[index]) {
      for (int i = 0; i < 20; i++) {
        hideCategory[i] = true;
        showSubCategory[i] = false;
      }
      hideCategory[index] = false;
      showSubCategory[index] = true;
    } else {
      for (int i = 0; i < 20; i++) {
        hideCategory[i] = true;
        showSubCategory[i] = false;
      }
      hideCategory[index] = true;
      showSubCategory[index] = false;
    }
    questionCategory = catController.catList[index].name;
    update();
    print(hideCategory[index]);
    print(showSubCategory[index]);
  }

  checkCategoryAndSubCategoryAlreadySelected() {
    String? catName = catController.categoryName;
    String? subCate = catController.subCategoryName;
    for (int i = 0; i < catController.catList.length; i++) {
      if (catName != null && catController.catList[i].name == catName) {
        catIndex = i;
      }
    }
    if (catController.subCatList.isNotEmpty) {
      for (int i = 0; i < catController.subCatList.length; i++) {
        if (subCate != null && catController.subCatList[i].name == subCate) {
          subCatIndex = i;
        }
      }
    }
    update();
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

    update();
  }

  uploadBtnClick() async {
    bool isInputValid = await checkValidation();
    if (isInputValid) {
      if (draftCheckedIndex.isNotEmpty) {
        for (int i = 0; i < draftCheckedIndex.length; i++) {
          await editDraftBtnClick(draftCheckedIndex[i]);
          await addNewQuestions();
          await erasedData();
          await deleteDraftBtnClick(draftCheckedIndex[i]);
        }
        await getDraftQuestions();
        draftCheckedIndex = [];
        update();
      } else {
        await addNewQuestions();
        await erasedData();
        textCounter = 0;
      }
      if (catController.subCategoryName != null) {
        await getQuestions(catController.categoryName!, catController.subCategoryName!);
      } else {
        await getQuestions(questionCategory!, questionSubCategory!);
      }
      await getTotalNumberOfQuestionForSpecificCategory();
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
      questionCategory = teacherQuestionModelList[index].category;
      questionSubCategory = teacherQuestionModelList[index].subcategory;
    } else {
      question.text = searchQuestion[index].question;
      option1.text = searchQuestion[index].choiceList[0];
      option2.text = searchQuestion[index].choiceList[1];
      option3.text = searchQuestion[index].choiceList[2];
      option4.text = searchQuestion[index].choiceList[3];
      article.text = searchQuestion[index].article;
      qid = searchQuestion[index].qid;
      questionCategory = searchQuestion[index].category;
      questionSubCategory = searchQuestion[index].subcategory;
    }
    update();
    Get.to(AddQuestion(callingFor: 'Edit'));
  }

  deleteBtnClick(int index) async {
    if (searchQuestion.isEmpty) {
      qid = teacherQuestionModelList[index].qid;
    } else {
      qid = searchQuestion[index].qid;
    }
    await removeQuestion();
    await getQuestions(catController.categoryName!, catController.subCategoryName!);
    await getTotalNumberOfQuestionForSpecificCategory();
    update();
  }

  increaseTextCounter(value) {
    textCounter = value;
    update();
  }

  copyBtnClick(index) {
    Clipboard.setData(ClipboardData(text: teacherQuestionModelList[index].article));
  }

//methods for draft
  Future<bool> draftBtnClick() async {
    bool isInputValid = await checkValidation();
    if (isInputValid) {
      await addToDraft(question.text, option1.text, option2.text, option3.text, option4.text, answer, article.text, questionCategory, questionSubCategory);
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
    if (draftCheckedIndex.isEmpty) {
      Get.to(AddQuestion(callingFor: 'Edit'));
    }
  }

  deleteDraftBtnClick(int index) async {
    qid = draftQuestionModelList[index].qid;
    update();
    await deleteDraftQuestion(qid);
    await getDraftQuestions();
  }

  Future<bool> getDraftQuestions() async {
    draftQuestionModelList = await getDraftQuestionsList();
    update();
    return true;
  }

////

  Future<bool> checkValidation() async {
    if (questionSubCategory == null) {
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
    } else if (answer == null) {
      reusableInstance.toast('Invalid choice', 'please select answer!');
      return false;
    } else if (article.text.trim().isEmpty) {
      reusableInstance.toast('Invalid choice', 'please enter article');
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
    bool isInputValid = await checkValidation();
    if (isInputValid) {
      await editTeacherQuestions(question.text, option1.text, option2.text, option3.text, option4.text, answer, article.text, questionCategory, questionSubCategory, qid);
      await getQuestions(catController.categoryName!, catController.subCategoryName!);
      await getTotalNumberOfQuestionForSpecificCategory();
      await erasedData();
    }
  }

  removeQuestion() async {
    await deleteQuestion(qid);
  }
}
