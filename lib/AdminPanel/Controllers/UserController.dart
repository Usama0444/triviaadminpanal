import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Models/UserModel.dart';
import 'package:triviaadminpanal/AdminPanel/Services/UserServices.dart';

class UserController extends GetxController {
  List<UserModel> userModelList = [];
  var userList = [];
  var active = [];
  var searchUser = [];

  List<String> headings = [
    'User Name',
    'Points',
    'World Rank',
    'Social Rank',
    'Email',
    'Active/Suspend',
  ];
  getUser() async {
    if (userList.length == 0) {
      userModelList = await getAllUsers();

      for (int i = 0; i < userModelList.length; i++) {
        var lst = [
          userModelList[i].fullname,
          userModelList[i].points,
          userModelList[i].worldrank,
          userModelList[i].socialrank,
          userModelList[i].email,
          'false',
        ];
        userList.add(lst);
        active.add(true);
      }
    }
    update();
  }

  searchTap(String txt) {
    searchUser = [];
    for (int i = 0; i < userList.length; i++) {
      if (txt.toLowerCase().trim() == userList[i][0].toString().toLowerCase().trim() || txt.toLowerCase().trim() == userList[i][4].toString().toLowerCase().trim()) {
        searchUser.add(userList[i]);
        print('matching user data is \n');
        print(searchUser[0]);
        active.add(true);
      }
    }
    update();
  }
}
