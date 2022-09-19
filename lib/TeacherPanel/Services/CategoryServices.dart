import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/CategoryModel.dart';
import '../Models/SubCategoryModel.dart';

var categoryCollectionRef = FirebaseFirestore.instance.collection('category');
var subCategoryCollectionRef = FirebaseFirestore.instance.collection('subcategory');

Future<List<CategoryModel>> getAllCategoryList() async {
  var cateList = await categoryCollectionRef.get();
  var categoryList = cateList.docs.map((e) => CategoryModel.fromJson(e.data())).toList();
  return categoryList;
}

Future<List<SubCategoryModel>> getAllSubCategoryList(cid) async {
  var subcategory = await subCategoryCollectionRef.where('cid', isEqualTo: cid).get();
  var subcategoryList = subcategory.docs.map((e) => SubCategoryModel.fromJson(e.data())).toList();
  return subcategoryList;
}
