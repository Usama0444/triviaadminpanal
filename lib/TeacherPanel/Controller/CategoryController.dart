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
  var catList = [];
  var catID = [];
  var dashController = Get.put(DashboardController());
  List<SubCategoryModel> subcategoryModelList = [];

  getCategories() async {
    try {
      categoryModelList = [];
      dashController.categoryList.clear();
      dashController.subCategoryList.clear();
      categoryModelList = await getAllCategoryList();
      for (int i = 0; i < categoryModelList.length; i++) {
        dashController.categoryList.add(categoryModelList[i].name);
        dashController.openSubcate.add(false);
        dashController.categoryColor.add(whiteColor);
        dashController.categoryTextColor.add(secondColor);
        dashController.menuBottomBorderColor.add(drawerColor);

        dashController.update();
        catID.add(categoryModelList[i].cid);
      }
      update();
      await getSubCategories();
      // print('subcate ${await dashController.subCategoryList}');
    } catch (e) {
      print(e);
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
