import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Models/CategoryModel.dart';
import 'package:triviaadminpanal/AdminPanel/Services/CategoryServices.dart';
import 'package:triviaadminpanal/AdminPanel/views/components/style.dart';

import '../Models/SubCategoryModel.dart';

class CategoryController extends GetxController {
  List<CategoryModel> categoryModelList = [];
  var catList = [];
  var subCatLength = [];

  List<SubCategoryModel> subcategoryModelList = [];
  var subcatList = [];
  var subCategpryListByCategory = [];
  List<Color> categoryColor = [
    whiteColor,
    whiteColor,
    whiteColor,
    whiteColor,
    whiteColor,
    whiteColor,
    whiteColor,
    whiteColor,
    whiteColor,
    whiteColor,
    whiteColor,
    whiteColor,
    whiteColor,
    whiteColor,
    whiteColor,
  ];
  List<Color> categoryTextColor = [
    secondColor,
    secondColor,
    secondColor,
    secondColor,
    secondColor,
    secondColor,
    secondColor,
    secondColor,
    secondColor,
    secondColor,
    secondColor,
    secondColor,
    secondColor,
    secondColor,
    secondColor,
    secondColor,
    secondColor,
    secondColor,
  ];

  getCategories() async {
    categoryModelList = [];
    catList = [];
    categoryModelList = await getAllCategoryList();
    for (int i = 0; i < categoryModelList.length; i++) {
      var lst = [
        categoryModelList[i].name,
        categoryModelList[i].image,
        categoryModelList[i].cid,
      ];
      catList.add(lst);
    }
    update();
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
