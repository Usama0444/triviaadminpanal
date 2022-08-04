import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triviaadminpanal/AdminPanel/Services/UserServices.dart';
import 'package:triviaadminpanal/AdminPanel/Services/loginServices.dart';
import 'package:triviaadminpanal/AdminPanel/views/CustomWidgets/MyContainer.dart';
import 'package:triviaadminpanal/AdminPanel/views/CustomWidgets/MyText.dart';
import 'package:triviaadminpanal/AdminPanel/views/DrawerMenu.dart';
import 'package:triviaadminpanal/AdminPanel/views/components/string.dart';
import 'package:triviaadminpanal/AdminPanel/views/components/style.dart';

import 'package:get/get.dart';
import 'package:triviaadminpanal/main.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  var emailCon = TextEditingController();
  var passCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: EdgeInsets.only(left: 748.w, right: 748.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 424.w,
              height: 120.h,
              margin: EdgeInsets.zero,
              // color: Colors.grey,
              child: MyText(
                txt: 'Trivia Star',
                color: basicColor,
                fontweight: FontWeight.w700,
                size: 90.sp,
              ),
            ),
            Container(
              width: 72.w,
              height: 30.h,
              margin: EdgeInsets.only(top: 25.h, bottom: 50.h),
              child: MyText(
                txt: loginAdmin,
                color: Color(0xff707070),
                fontweight: FontWeight.bold,
                size: 20.sp,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: basicColor,
                  width: 0.5.h,
                )),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: TextFormField(
                  controller: emailCon,
                  decoration: InputDecoration(border: InputBorder.none, hintText: email, hintStyle: TextStyle(fontSize: 20.sp, color: hideColor)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.h, bottom: 80.h),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  color: basicColor,
                  width: 0.5.h,
                )),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: TextFormField(
                  controller: passCon,
                  decoration: InputDecoration(border: InputBorder.none, hintText: password, hintStyle: TextStyle(fontSize: 20.sp, color: hideColor)),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                if (emailCon.text.trim() == '' || !emailCon.text.contains('@gmail.com')) {
                  Get.snackbar('Error', 'Invalid Email');
                } else if (passCon.text.trim() == '') {
                  Get.snackbar('Error', 'Invalid Password');
                } else {
                  pref?.setBool('logedin', true);
                  pref?.setString('email', emailCon.text);
                  await userLogin(emailCon.text, passCon.text);
                }
              },
              child: MyContainer(
                  180.w,
                  65.h,
                  10.h,
                  Container(
                    margin: EdgeInsets.only(
                      top: 15.h,
                      bottom: 16.h,
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
