import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/TeacherModel.dart';
import '../Services/TeacherServices.dart';

class TeacherController extends GetxController {
  List<TeacherModel> TeacherModelList = [];
  var isValid = true;
  var teacherList = [];
  var tid = '';
  var isTeacherEdit = false;
  var email = TextEditingController();
  var password = TextEditingController();
  List<String> headingTxt = [
    'Email',
    'Password',
    '',
  ];
  getTeacher() async {
    TeacherModelList.clear();
    teacherList.clear();
    TeacherModelList = await getAllTeacherList();
    for (int i = 0; i < TeacherModelList.length; i++) {
      var lst = [
        TeacherModelList[i].email,
        TeacherModelList[i].password,
        TeacherModelList[i].tid,
      ];
      teacherList.add(lst);
    }
    update();
  }

  addNewTeachers(String email, password) async {
    await addTeachers(email, password);
  }

  updateTeacher(String email, password) async {
    await editTeacher(email, password, tid);
  }
}
