import 'package:cloud_firestore/cloud_firestore.dart';

import '../../AdminPanel/Models/CategoryModel.dart';
import '../../AdminPanel/Models/SubCategoryModel.dart';

var categoryCollectionRef = FirebaseFirestore.instance.collection('category');
var subCategoryCollectionRef = FirebaseFirestore.instance.collection('subcategory');

Future<List<CategoryModel>> getAllCategoryList() async {
  var categpryList = await categoryCollectionRef.get();
  var categoryList = await categpryList.docs.map((e) => CategoryModel.fromJson(e.data())).toList();
  return categoryList;
}

Future<List<SubCategoryModel>> getAllSubCategoryList(cid) async {
  var subcategory = await subCategoryCollectionRef.where('cid', isEqualTo: cid).get();
  var subcategoryList = await subcategory.docs.map((e) => SubCategoryModel.fromJson(e.data())).toList();
  return subcategoryList;
}
