import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Models/UserModel.dart';
import 'package:triviaadminpanal/AdminPanel/Services/UserServices.dart';

class UserController extends GetxController {
  List<UserModel> userModelList = [];
  var userList = [];
  List<String> headings = [
    'User Name',
    'Points',
    'World Rank',
    'Social Rank',
    'Email',
    'Active/Suspend',
  ];
  getUser() async {
    print('in get');
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
    }
    update();
  }
}
