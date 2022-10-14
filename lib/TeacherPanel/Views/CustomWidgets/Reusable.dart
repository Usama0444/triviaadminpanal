import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/QuestionsController.dart';
import 'package:triviaadminpanal/TeacherPanel/Services/QuestionServices.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/components/style.dart';

import '../../Services/LoginServices.dart';
import '../AddQuestions.dart';
import '../Categories.dart';
import '../Draft.dart';
import '../LoginPage.dart';
import 'MyText.dart';

class Reusable {
  QuestionController? questionController;
  CategoryController? catController;
  void toast(String heading, content) {
    Get.snackbar(
      heading,
      content,
      margin: EdgeInsets.only(left: 900, right: 100.w, bottom: 50.h),
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 1),
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
  }

  Widget buttons(double width, double height, Widget child) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: basicColor,
        borderRadius: BorderRadius.circular(5.h),
      ),
      child: child,
    );
  }

  Widget inputBox(double width, double height, var borderColor, Widget child) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 1.h,
        ),
        borderRadius: BorderRadius.circular(10.h),
      ),
      child: child,
    );
  }

  Widget loader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            const Text('Loading...'),
            SizedBox(
              height: 5.h,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ],
    );
  }

  Widget profile(bool isLoading) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          MyText(
            txt: 'PROFILE',
            color: Colors.black,
            fontweight: FontWeight.w800,
            size: 20.sp,
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            width: 119.w,
            height: 119.w,
            decoration: BoxDecoration(
              color: greyColor,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/defaultPic.png',
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          MyText(
            txt: 'SYED IZHAN UDDIN',
            color: Colors.black,
            fontweight: FontWeight.w300,
            size: 22.sp,
          ),
          SizedBox(
            height: 5.h,
          ),
          MyText(
            txt: 'TEACHER',
            color: basicColor,
            fontweight: FontWeight.w300,
            size: 18.sp,
          ),
          Container(
            width: 570.w,
            height: 97.h,
            margin: EdgeInsets.only(top: 85.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.h),
                onTap: () {
                  isLoading != true ? Get.to(const Draft()) : reusableInstance.toast('Wait', 'wait tell Loading Complete');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.mail_outline_outlined, size: 40.h),
                        SizedBox(
                          width: 10.w,
                        ),
                        MyText(
                          txt: 'Drafts',
                          color: Colors.black,
                          fontweight: FontWeight.w300,
                          size: 20.sp,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GetBuilder<QuestionController>(builder: (controller) {
                          return MyText(
                            txt: controller.totalDraftQuestion == 0 ? '0' : '${controller.totalDraftQuestion}',
                            color: basicColor,
                            fontweight: FontWeight.w500,
                            size: 25.sp,
                          );
                        }),
                        SizedBox(
                          width: 10.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.h),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 25.h,
                            color: basicColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> logOut() async {
    var logout = await userLogOut();
    if (logout) {
      await catController?.resetAllvariables();
      Get.offAll(LoginPage());
    }
  }
}
