import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/views/ApproveQuestionList.dart';
import 'package:triviaadminpanal/AdminPanel/views/ApproveTeacherQuestionsList.dart';
import 'package:triviaadminpanal/AdminPanel/views/DrawerMenu.dart';
import 'package:triviaadminpanal/AdminPanel/views/Login.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/DrawerMenu.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return ScreenUtilInit(
      rebuildFactor: (old, data) => true,
      builder: (context, child) => GetMaterialApp(
        home: TeacherDrawerMenu(),
        // home: TeacherLogin(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Segoe UI'),
      ),
      designSize: const Size(1920, 1080),
    );
  }
}
