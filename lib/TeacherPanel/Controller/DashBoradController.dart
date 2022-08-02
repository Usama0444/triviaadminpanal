import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Views/components/style.dart';

class DashboardController extends GetxController {
  int catIndex = 0;
  List<bool> openSubcate = [];
  var question = TextEditingController();
  var option1 = TextEditingController();
  var option2 = TextEditingController();
  var option3 = TextEditingController();
  var option4 = TextEditingController();
  var category = 'Select Category';
  var subCategory = 'Select Sub-Category';
  bool addQuestion = false;
  List<Color> categoryColor = [];
  List<Color> categoryTextColor = [];
  List<List<Color>> subcategoryColor = [];
  List<List<Color>> subcategoryTextColor = [];
  List<String> categoryList = [];
  List<List<String>> subCategoryList = [];
  List<Color> menuBottomBorderColor = [];
}
