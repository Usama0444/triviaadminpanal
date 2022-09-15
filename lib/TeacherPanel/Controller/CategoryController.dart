import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/DashBoradController.dart';

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
  List<List<String>> subCategoriesForDrawer = [];
  String? categoryName, subCategoryName;
  String callingScreenName = 'category';
  String? cid;
  List<SubCategoryModel> allSubCatLis = [];
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
  List<String> cateNameList = [
    'General',
    'Technical',
    'Social',
    'Education',
    'Sports',
    'General',
    'Technical',
    'Social',
    'Education',
    'Sports',
    'General',
    'Technical',
    'Social',
    'Education',
    'Sports',
  ];

  Future<bool> getCategories() async {
    try {
      categoryModelList = [];
      categoryModelList = await getAllCategoryList();
      for (int i = 0; i < categoryModelList.length; i++) {
        catList.add(categoryModelList[i]);
      }
      update();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  getSubCategories() async {
    for (int j = 0; j < catList.length; j++) {
      subcategoryModelList = await getAllSubCategoryList(catList[j].cid);
      totalSubCate.add(subcategoryModelList.length);
      // allSubCatLis.add(subcategoryModelList[j]);
    }
    update();
  }

  categoryViewBtnClick(cid) async {
    subCatList = [];
    try {
      subcategoryModelList = await getAllSubCategoryList(cid);
      for (int i = 0; i < subcategoryModelList.length; i++) {
        subCatList.add(subcategoryModelList[i]);
      }
      update();
    } catch (e) {
      Get.snackbar('Error', '$e');
    }
  }

  fillSubCategoryForDrawer() async {
    subCategoriesForDrawer = [];
    print('${catList.length} ${subCatList.length}');
    for (int i = 0; i < catList.length; i++) {
      for (int j = 0; j < allSubCatLis.length; j++) {
        if (catList[i].cid == allSubCatLis[j].cid) {
          subCategoriesForDrawer.add([allSubCatLis[j].image, allSubCatLis[j].name]);
        }
      }
    }
    print('drawer subCate');
    print(subCategoriesForDrawer.length);
  }
}
