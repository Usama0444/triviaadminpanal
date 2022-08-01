import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:triviaadminpanal/AdminPanel/Models/UserModel.dart';

Future<List<UserModel>> getAllUsers() async {
  var users = await FirebaseFirestore.instance.collection('users').get();
  var userList = await users.docs.map((e) => UserModel.fromJson(e.data())).toList();
  return userList;
}
