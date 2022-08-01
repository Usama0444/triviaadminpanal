import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/TeacherController.dart';

import '../Models/TeacherModel.dart';

var controller = Get.put(TeacherController());
var teacherCollectionRef = FirebaseFirestore.instance.collection('teacher');
final FirebaseAuth _auth = FirebaseAuth.instance;
Future<List<TeacherModel>> getAllTeacherList() async {
  var teacherList = await teacherCollectionRef.get();
  var teachersList = await teacherList.docs.map((e) => TeacherModel.fromJson(e.data())).toList();
  return teachersList;
}

addTeachers(String email, password) async {
  try {
    var id = teacherCollectionRef.doc().id;
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
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

// updateTeacherInfo(email, password) async {
//   try {
//     var user = await _auth.currentUser;
//     AuthCredential credentials = EmailAuthProvider.credential(email: 't@gmail.com', password: '111111');
//     await user?.delete();
//   } catch (e) {
//     Get.snackbar('Error', '$e');
//   }
// }

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
