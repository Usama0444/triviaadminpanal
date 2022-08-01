import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Views/components/style.dart';

class DashboardController extends GetxController {
  int selectedAddQuestionScreenIndex = 0;
  int sportAddQuestionScreenIndex = 0;
  var question = TextEditingController();
  var option1 = TextEditingController();
  var option2 = TextEditingController();
  var option3 = TextEditingController();
  var option4 = TextEditingController();
  var category = 'Education';
  var subCategory = 'Science';
  bool addQuestion = false;
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
  List<int> sportNumberList = [
    10,
    30,
    40,
    60,
    80,
    150,
  ];
  List<int> subjectNumberList = [
    10,
    30,
    40,
    60,
    80,
    150,
  ];
  List<Color> educationSubCatColor = [
    basicColor,
    secondColor,
    secondColor,
    secondColor,
    secondColor,
    secondColor,
  ];
  List<Color> sportSubCatColor = [
    basicColor,
    secondColor,
    secondColor,
    secondColor,
    secondColor,
    secondColor,
  ];
  List<Color> menuColor = [
    basicColor,
    secondColor,
  ];
  List<Color> menuBottomBorderColor = [
    basicColor,
    drawerColor,
  ];
}
