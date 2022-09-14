import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/LogInController.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Categories.dart';
import 'package:triviaadminpanal/main.dart';

import 'CustomWidgets/MyContainer.dart';
import 'CustomWidgets/MyText.dart';
import 'components/string.dart';
import 'components/style.dart';

class TeacherLogin extends StatefulWidget {
  TeacherLogin({Key? key}) : super(key: key);

  @override
  State<TeacherLogin> createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  var loginController = Get.find<LogInController>();
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 748.w, right: 748.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 424.w,
              height: 120.h,
              child: MyText(
                txt: 'TriviaStar',
                color: basicColor,
                fontweight: FontWeight.w800,
                size: 90.sp,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25.h, bottom: 50.h),
              child: MyText(
                txt: loginTeacher,
                color: Color(0xff707070),
                fontweight: FontWeight.w800,
                size: 20.sp,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: basicColor,
                  width: 0.5,
                )),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: TextFormField(
                  controller: loginController.email,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: email,
                      hintStyle: TextStyle(
                        fontSize: 20.sp,
                        color: hideColor,
                      )),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.h, bottom: 80.h),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: basicColor,
                  width: 0.5,
                )),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: TextFormField(
                  controller: loginController.password,
                  decoration: InputDecoration(border: InputBorder.none, hintText: password, hintStyle: TextStyle(fontSize: 20.sp, color: hideColor)),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                if (isLoading) {
                  reusableInstance.loader();
                }
                isLoading = await loginController.userLogin();
                setState(() {});
                if (!isLoading) {
                  Get.back();
                }
              },
              child: MyContainer(
                  180.w,
                  60.h,
                  10.h,
                  Container(
                    margin: EdgeInsets.only(
                      top: 17.h,
                      bottom: 10.h,
                      left: 59.25.w,
                      right: 58.75.w,
                    ),
                    child: MyText(
                      txt: loginBtn,
                      color: basicColor,
                      fontweight: FontWeight.normal,
                      size: 20.sp,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
