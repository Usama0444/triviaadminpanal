import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/TeacherController.dart';

import '../Models/TeacherModel.dart';

var controller = Get.put(TeacherController());
var teacherCollectionRef = FirebaseFirestore.instance.collection('teacher');
Future<List<TeacherModel>> getAllTeacherList() async {
  var teacherList = await teacherCollectionRef.get();
  var teachersList = await teacherList.docs.map((e) => TeacherModel.fromJson(e.data())).toList();
  return teachersList;
}

addTeachers(String email, password) async {
  try {
    var id = teacherCollectionRef.doc().id;
    teacherCollectionRef.doc(id).set({
      'email': email,
      'password': password,
      'tid': id,
    });
    Get.snackbar('Confirmation Alert', 'Teacher Added successfully');
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}

editTeacher(String email, password, tid) async {
  try {
    if (email == '' || password == '') {
      Get.snackbar('Confirmation Alert', 'Invalid Data');
      controller.isValid = false;
      controller.update();
    } else {
      teacherCollectionRef.doc(tid).update({
        'email': email,
        'password': password,
        'tid': tid,
      });
      Get.snackbar('Confirmation Alert', 'Teacher Updated successfully');
    }
  } catch (e) {
    Get.snackbar('Error', 'something went wrong!!');
  }
}
