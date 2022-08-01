import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Models/CategoryModel.dart';
import 'package:triviaadminpanal/AdminPanel/Models/QuestionModel.dart';
import 'package:triviaadminpanal/AdminPanel/Models/QuestionModel.dart';

import '../Models/SubCategoryModel.dart';

var categoryCollectionRef = FirebaseFirestore.instance.collection('category');
var subCategoryCollectionRef = FirebaseFirestore.instance.collection('subcategory');

Future<List<CategoryModel>> getAllCategoryList() async {
  var categpryList = await categoryCollectionRef.get();
  var categoryList = await categpryList.docs.map((e) => CategoryModel.fromJson(e.data())).toList();
  return categoryList;
}

addCategory(String name, String image) async {
  try {
    var id = categoryCollectionRef.doc().id;

    categoryCollectionRef.doc(id).set({
      'name': name,
      'image': image,
      'cid': id,
    });
    Get.snackbar('Confirmation Alert', 'Category Added successfully');
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}

Future<List<SubCategoryModel>> getAllSubCategoryList(cid) async {
  var subcategory = await subCategoryCollectionRef.where('cid', isEqualTo: cid).get();
  var subcategoryList = await subcategory.docs.map((e) => SubCategoryModel.fromJson(e.data())).toList();
  return subcategoryList;
}

addSubCategory(String name, String image, cid) async {
  try {
    var id = subCategoryCollectionRef.doc().id;
    subCategoryCollectionRef.doc(id).set({
      'name': name,
      'image': image,
      'sid': id,
      'cid': cid,
    });
    Get.snackbar('Confirmation Alert', 'Sub-Category Added successfully');
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}

editCategory(name, image, cid) async {
  if (name != '' && image != null) {
    categoryCollectionRef.doc(cid).update({'name': name, 'image': image, 'cid': cid});
    Get.snackbar('Update Alert', 'Category Updated');
  } else {
    Get.snackbar('Update Alert', 'Category Not Updated');
  }
}

editSubCategory(name, image, sid) async {
  if (name != '' && image != null) {
    subCategoryCollectionRef.doc(sid).update({'name': name, 'image': image, 'sid': sid});
    Get.snackbar('Update Alert', 'Sub-Category Updated');
  } else {
    Get.snackbar('Update Alert', 'Sub-Category Not Updated');
  }
}
