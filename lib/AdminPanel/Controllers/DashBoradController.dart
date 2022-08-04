import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../views/components/string.dart';
import '../views/components/style.dart';

class DashboardController extends GetxController {
  int screenIndex = 0;
  int subCatIndex = 0;
  int catIndex = 0;
  bool addQuestion = false;
  bool addTeachers = false;
  bool showTeacherQuestionsList = false;
  var category = 'Select Category';
  var subCategory = 'Select Sub-Category';
  var approveScreen = false;
  var teacherQuestionScreen = false;
  List<String> categoryList = [];
  List<List<String>> subCategoryList = [];
  List<String> mainHeading = [
    'Education',
    'Sports',
  ];
  List<String> subjectsNameList = [
    'Science',
    'Biology',
    'Chemistry',
    'Physics',
    'Math',
    'History',
  ];
  List<String> sportNameList = [
    'Cricket',
    'Football',
    'Pool',
    'Badminton',
    'Hockey',
    'Tennis',
  ];
  List<String> menuList = [
    dashborad,
    users,
    cate,
    questions,
  ];
  List<Color> menuColor = [
    basicColor,
    secondColor,
    secondColor,
    secondColor,
  ];
  List<Color> menuBottomBorderColor = [
    basicColor,
    drawerColor,
    drawerColor,
    drawerColor,
  ];
  List<String> countryList = [
    'Pakistan',
    'India',
    'China',
    'Rassia',
    'America',
  ];
  String selectedCountry = 'Pakistan';
  List<String> position = [
    '1st',
    '2st',
    '3st',
    '4st',
    '5st',
  ];
  List<String> nameList = [
    'Amir Saqib',
    'Amir Saqib',
    'Amir Saqib',
    'Amir Saqib',
    'Amir Saqib',
  ];
  List<String> numberList = [
    '1.2 M',
    '3.2 M',
    '4.2 M',
    '5.2 M',
    '7.2 M',
  ];
  List<String> totalString = [
    'Categories',
    'Sub-Categories',
    'Questions',
  ];
  List<int> totalNumber = [
    12,
    24,
    15000,
  ];
  List<String> questionsSubCat = [
    'Add',
    'Approve',
    'Teacher',
  ];
  List<Color> menuSubCatColor = [
    basicColor,
    secondColor,
    secondColor,
  ];
}
