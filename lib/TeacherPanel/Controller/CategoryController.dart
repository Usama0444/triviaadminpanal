import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Categories.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/CustomWidgets/SideDropDownMenu.dart';

import '../Models/CategoryModel.dart';
import '../Models/SubCategoryModel.dart';
import '../Services/CategoryServices.dart';
import '../Views/components/style.dart';
import 'QuestionsController.dart';

class CategoryController extends GetxController {
  List<CategoryModel> categoryModelList = [];
  List<CategoryModel> searchCategory = [];
  List<CategoryModel> catList = [];
  List<SubCategoryModel> subCatList = [];
  List<int> totalSubCatForSearch = [];
  List<int> totalSubCatQuestionsForSearch = [];
  List<SubCategoryModel> searchSubCategory = [];
  List<int> totalSubCate = [];
  List<SubCategoryModel> subcategoryModelList = [];
  List<List<SubCategoryModel>> subCategoriesForDrawer = [];
  String? categoryName, subCategoryName;
  String callingScreenName = 'category';
  String? cid;
  List<SubCategoryModel> allSubCatLis = [];
  var categoryNameSearch = TextEditingController();
  var subCategoryNameSearch = TextEditingController();
  int categorySearchIndex = -1;
  int subCategorySearchIndex = -1;
  bool isCategorySearchNotMatch = false;
  bool isSubCategorySearchNotMatch = false;
  int length = 1;
  List<Color> highlightSubCategories = [];
  List<bool> showSubCategory = [];
  List<bool> hideCategory = [];
  int? catIndex, subCatIndex;
  String? questionCategory, questionSubCategory;
  bool isLoading = true;
  bool isLoadingAddQuestion = true;
  bool isLoadingDraft = true;

  List<String> cateHeader = [
    'Logo',
    'Categories Name',
    'Total Sub-Categories',
    '500 Question',
  ];
  List<String> subCateHeader = [
    'Logo',
    'Sub-Categories Name',
    'Total Question',
    '500 Question',
  ];

  categorySearchTap() async {
    isCategorySearchNotMatch = false;
    searchCategory = [];
    totalSubCatForSearch = [];
    for (int i = 0; i < catList.length; i++) {
      if (catList[i].name.toLowerCase().toString().contains(categoryNameSearch.text.trim().toLowerCase())) {
        isCategorySearchNotMatch = false;
        searchCategory.add(catList[i]);
        totalSubCatForSearch.add(totalSubCate[i]);
      } else {
        isCategorySearchNotMatch = true;
      }
    }
    update();
    print('search cat ${searchCategory.length}');
  }

  subCategorySearchTap() async {
    isSubCategorySearchNotMatch = false;
    searchSubCategory = [];
    QuestionController questionController = Get.find<QuestionController>();

    totalSubCatQuestionsForSearch = [];
    for (int i = 0; i < subCatList.length; i++) {
      if (subCatList[i].name.toLowerCase().toString().contains(subCategoryNameSearch.text.trim().toLowerCase())) {
        isSubCategorySearchNotMatch = false;
        searchSubCategory.add(subCatList[i]);
        totalSubCatQuestionsForSearch.add(questionController.totalQuestionOfspecificSubCategory[i]);
      } else {
        isSubCategorySearchNotMatch = true;
      }
    }
    update();
  }

  Future<bool> getCategories() async {
    try {
      if (catList.isEmpty) {
        categoryModelList = [];
        catList = [];
        categoryModelList = await getAllCategoryList();
        for (int i = 0; i < categoryModelList.length; i++) {
          catList.add(categoryModelList[i]);
        }
        update();
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  resetLodaing() {
    if (isLoading) {
      isLoading = false;
    } else {
      isLoading = false;
    }
    update();
  }

  getSubCategories() async {
    if (totalSubCate.isEmpty) {
      for (int j = 0; j < catList.length; j++) {
        subcategoryModelList = await getAllSubCategoryList(catList[j].cid);
        totalSubCate.add(subcategoryModelList.length);
      }
      update();
    }
  }

  categoryViewBtnClick() async {
    try {
      subCatList = [];
      subcategoryModelList = await getAllSubCategoryList(cid);
      for (int i = 0; i < subcategoryModelList.length; i++) {
        subCatList.add(subcategoryModelList[i]);
      }
      update();
    } catch (e) {
      reusableInstance.toast('Error', '$e');
    }
  }

  fillSubCategoryForDrawer() async {
    isLoadingAddQuestion = true;

    if (subCategoriesForDrawer.isEmpty) {
      subCategoriesForDrawer = [];
      List<SubCategoryModel> tempList = [];
      for (int i = 0; i < catList.length; i++) {
        tempList = [];
        var subCat = await getAllSubCategoryList(catList[i].cid);
        if (subCat.isNotEmpty) {
          for (int j = 0; j < subCat.length; j++) {
            tempList.add(subCat[j]);
          }
          subCategoriesForDrawer.add(tempList);
        } else {
          subCategoriesForDrawer.add([]);
        }
      }
    }
  }

  appBarLogoClick() {
    resetSelection().whenComplete(() {
      Get.offAll(Categories());
    });
  }

  resetSelection() async {
    categoryName = null;
    subCategoryName = null;
    catIndex = null;
    subCatIndex = null;
    update();
  }
////leftside drop down menu in add question screen

  highlightSpecificSubCategory(index) {
    for (int i = 0; i < 10; i++) {
      highlightSubCategories[i] = whiteColor;
    }
    highlightSubCategories[index] = Colors.green.withOpacity(0.5);
    questionController.isShowSubCategoryQuestionForm = true;
    questionController.update();
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
      questionCategory = catList[catIndex!].name;
    }
    if (subCatIndex != null) {
      highlightSpecificSubCategory(subCatIndex! + 1);
      questionController.isShowSubCategoryQuestionForm = true;
      questionController.update();
      questionSubCategory = subCatList[subCatIndex!].name;
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
    questionCategory = catList[index].name;
    update();
    print(hideCategory[index]);
    print(showSubCategory[index]);
  }
}
