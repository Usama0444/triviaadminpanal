import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Categories.dart';

import '../Models/CategoryModel.dart';
import '../Models/SubCategoryModel.dart';
import '../Services/CategoryServices.dart';
import '../Views/components/style.dart';

class CategoryController extends GetxController {
  List<CategoryModel> categoryModelList = [];
  List<CategoryModel> catList = [];
  List<SubCategoryModel> subCatList = [];
  List<int> totalSubCate = [];
  List<SubCategoryModel> subcategoryModelList = [];
  List<List<SubCategoryModel>> subCategoriesForDrawer = [];
  String? categoryName, subCategoryName;
  String callingScreenName = 'category';
  String? cid;
  List<SubCategoryModel> allSubCatLis = [];
  List<CategoryModel> searchList = [];
  var categoryNameSearch = TextEditingController();
  var subCategoryNameSearch = TextEditingController();

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
    searchList = [];
    for (int i = 0; i < catList.length; i++) {
      if (catList[i].name.contains(categoryNameSearch.text)) {
        searchList.add(catList[i]);
      }
    }
    print('searched ${searchList[0].name}');
    update();
  }

  subCategorySearchTap() async {
    searchList = [];
    for (int i = 0; i < catList.length; i++) {
      if (subCatList[i].name.contains(categoryNameSearch.text)) {
        searchList.add(catList[i]);
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

  getSubCategories() async {
    if (totalSubCate.isEmpty) {
      for (int j = 0; j < catList.length; j++) {
        subcategoryModelList = await getAllSubCategoryList(catList[j].cid);
        totalSubCate.add(subcategoryModelList.length);
        // allSubCatLis.add(subcategoryModelList[j]);
      }
      update();
    }
  }

  categoryViewBtnClick(cid) async {
    try {
      if (subCatList.length == 0) {
        subCatList = [];
        subcategoryModelList = await getAllSubCategoryList(cid);
        for (int i = 0; i < subcategoryModelList.length; i++) {
          subCatList.add(subcategoryModelList[i]);
        }
        update();
      }
    } catch (e) {
      reusableInstance.toast('Error', '$e');
    }
  }

  fillSubCategoryForDrawer() async {
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
}
