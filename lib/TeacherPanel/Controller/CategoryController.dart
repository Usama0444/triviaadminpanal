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
  var catID = [];
  var dashController = Get.put(DashboardController());
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
  List<int> totalSubCate = [
    11,
    12,
    23,
    45,
    66,
    11,
    12,
    23,
    45,
    66,
    11,
    12,
    23,
    45,
    66,
  ];
  List<SubCategoryModel> subcategoryModelList = [];

  Future<bool> getCategories() async {
    try {
      categoryModelList = [];
      dashController.categoryList.clear();
      dashController.subCategoryList.clear();
      categoryModelList = await getAllCategoryList();
      for (int i = 0; i < categoryModelList.length; i++) {
        catList.add(categoryModelList[i]);
      }
      update();
      // await getSubCategories();
      print('categroy getted ${catList[0].name}');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  getSubCategories() async {
    dashController.subCategoryList.clear();
    for (int j = 0; j < catID.length; j++) {
      List<String> name = [];
      subcategoryModelList = await getAllSubCategoryList(catID[j]);
      for (int i = 0; i < subcategoryModelList.length; i++) {
        name.add(subcategoryModelList[i].name);
      }
      dashController.subCategoryList.add(name);
      dashController.fillcat = 1;
      dashController.update();
    }
  }
}
