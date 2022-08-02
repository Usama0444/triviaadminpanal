import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/AddQuestions.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/DrawerMenu.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Login.dart';

SharedPreferences? pref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyARxG5xZxdQ0jbNs8ziQq2zTCxlxFM_dJ8",
      appId: "1:5416121892:web:a07611c7364dfd15724ab1",
      messagingSenderId: "5416121892",
      projectId: "triviastar-a10ff",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool? checkLogin;
    checkLogin = pref?.getBool('logedin');
    checkLogin ??= false;
    print(checkLogin);
    return ScreenUtilInit(
      rebuildFactor: (old, data) => true,
      builder: (context, child) => GetMaterialApp(
        home: checkLogin == false ? TeacherLogin() : TeacherDrawerMenu(),
        // home: AddQuestions(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Segoe UI'),
      ),
      designSize: const Size(1920, 1080),
    );
  }
}
