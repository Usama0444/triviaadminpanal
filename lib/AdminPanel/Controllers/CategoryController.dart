import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Models/CategoryModel.dart';
import 'package:triviaadminpanal/AdminPanel/Services/CategoryServices.dart';
import 'package:triviaadminpanal/AdminPanel/views/components/style.dart';

import '../Models/SubCategoryModel.dart';
import 'DashBoradController.dart';

class CategoryController extends GetxController {
  List<CategoryModel> categoryModelList = [];
  var catList = [];
  var subCatLength = [];
  var heading = [
    'Logo',
    'Categories Name',
    'Total Sub-Categories',
    'Questions',
  ];
  var subCategoryheading = [
    'Logo',
    'Sub-Categories Name',
    'Total Questions',
    'Questions',
  ];
  List<SubCategoryModel> subcategoryModelList = [];
  var subcatList = [];
  var subCategpryListByCategory = [];
  var dashController = Get.put(DashboardController());
  List<Color> categoryColor = [];
  List<Color> categoryTextColor = [];
  List<String> catID = [];

  // coloring() {
  //   for (int i = 0; i < 10; i++) {
  //     categoryColor.add(whiteColor);
  //     categoryTextColor.add(secondColor);
  //   }
  //   update();
  // }

  getCategories() async {
    // coloring();
    categoryModelList = [];
    catList = [];
    dashController.categoryList.clear();
    dashController.subCategoryList.clear();
    categoryModelList = await getAllCategoryList();
    for (int i = 0; i < categoryModelList.length; i++) {
      var lst = [
        categoryModelList[i].name,
        categoryModelList[i].image,
        categoryModelList[i].cid,
      ];
      dashController.categoryList.add(categoryModelList[i].name);
      dashController.update();
      catList.add(lst);
      catID.add(categoryModelList[i].cid);
    }
    print('cat ${catList.length}');
    print('categ ${dashController.categoryList.length}');
    update();
    // await getSubCategoriesForDrawer();
  }

  getSubCategoriesForDrawer() async {
    dashController.subCategoryList.clear();
    for (int j = 0; j < catID.length; j++) {
      List<String> name = [];
      subcategoryModelList = await getAllSubCategoryList(catID[j]);
      for (int i = 0; i < subcategoryModelList.length; i++) {
        name.add(subcategoryModelList[i].name);
      }
      dashController.subCategoryList.add(name);
      dashController.update();
    }
  }

  addCategories(name, image) async {
    await addCategory(name, image);
  }

  getSubCategories(cid) async {
    subcategoryModelList = [];
    subcatList = [];
    subcategoryModelList = await getAllSubCategoryList(cid);
    for (int i = 0; i < subcategoryModelList.length; i++) {
      var lst = [
        subcategoryModelList[i].name,
        subcategoryModelList[i].image,
        subcategoryModelList[i].cid,
        subcategoryModelList[i].sid,
      ];
      subcatList.add(lst);
    }
    update();
  }

  addSubCategories(name, image, cid) async {
    await addSubCategory(name, image, cid);
  }

  updateCategory(name, image, cid) async {
    await editCategory(name, image, cid);
  }

  updateSubCategory(name, image, sid) async {
    print('cid $sid');
    await editSubCategory(name, image, sid);
  }
}
