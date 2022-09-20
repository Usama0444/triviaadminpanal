import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/QuestionsController.dart';
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
            txt: 'USAMA GHAFOOR',
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
                onTap: () {
                  isLoading != true ? Get.to(Draft()) : reusableInstance.toast('Wait', 'wait tell Loading Complete');
                  ;
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
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 25.h,
                      color: basicColor,
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

  Widget appBar(String callingPageName) {
    questionController = Get.find<QuestionController>();
    catController = Get.find<CategoryController>();
    return Container(
      width: 1920.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: headerColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 28.w,
              ),
              SizedBox(
                width: 57.w,
                height: 47.h,
                child: Image.asset('assets/triviaLogo.png'),
              ),
              Row(
                children: [
                  MyText(
                    txt: 'Trivia ',
                    color: basicColor,
                    fontweight: FontWeight.bold,
                    size: 40.sp,
                  ),
                  MyText(
                    txt: 'star',
                    color: basicColor,
                    fontweight: FontWeight.w300,
                    size: 40.sp,
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 51.h),
                    child: MyText(
                      txt: 'TEACHERS',
                      color: greyColor,
                      fontweight: FontWeight.w300,
                      size: 15.sp,
                    ),
                  ),
                  const VerticalDivider(
                    color: Color(0xff3B3B3B),
                  ),
                  Container(
                    width: 334.w,
                    height: 42.h,
                    margin: EdgeInsets.only(
                      top: 25.h,
                      left: 65.w,
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: greyColor,
                      width: 1.h,
                    ))),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 293.w,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: greyColor,
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  fontSize: 20.sp,
                                  color: greyColor,
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 41.w,
                          height: 41.w,
                          child: FittedBox(
                            child: Icon(
                              Icons.search,
                              color: basicColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          Row(
            children: [
              callingPageName != 'category'
                  ? Padding(
                      padding: EdgeInsets.only(top: 29.h),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: buttons(
                          91.w,
                          42.h,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 25.h,
                                child: FittedBox(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                              Container(
                                height: 20.h,
                                child: MyText(
                                  txt: 'Back',
                                  color: whiteColor,
                                  fontweight: FontWeight.w300,
                                  size: 21.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Text(''),
              callingPageName == 'draft'
                  ? Padding(
                      padding: EdgeInsets.only(top: 29.h, left: 60.w),
                      child: buttons(
                        110.w,
                        43.h,
                        Container(
                          height: 20.h,
                          child: Center(
                            child: MyText(
                              txt: 'Upload',
                              color: whiteColor,
                              fontweight: FontWeight.w300,
                              size: 23.sp,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Text(''),
              callingPageName != 'category'
                  ? SizedBox(
                      width: 60.w,
                    )
                  : Text(''),
              callingPageName == 'add_questions'
                  ? Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 29.h),
                          child: InkWell(
                            onTap: () async {
                              await questionController?.uploadBtnClick();
                            },
                            child: buttons(
                              100.w,
                              42.h,
                              Container(
                                height: 20.h,
                                child: Center(
                                  child: MyText(
                                    txt: 'Upload',
                                    color: whiteColor,
                                    fontweight: FontWeight.w300,
                                    size: 23.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 60.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 29.h),
                          child: buttons(
                            86.w,
                            42.h,
                            Container(
                              height: 20.h,
                              child: Center(
                                child: MyText(
                                  txt: 'Draft',
                                  color: whiteColor,
                                  fontweight: FontWeight.w300,
                                  size: 23.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : callingPageName != 'draft'
                      ? Padding(
                          padding: EdgeInsets.only(top: 29.h),
                          child: InkWell(
                            onTap: () {
                              Get.to(AddQuestion(callingFor: 'Add'));
                            },
                            child: buttons(
                              180.w,
                              42.h,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20.w,
                                    height: 20.h,
                                    child: FittedBox(
                                      child: Icon(
                                        Icons.add,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await questionController?.erasedData();
                                      Get.to(AddQuestion(callingFor: 'Add'));
                                    },
                                    child: Container(
                                      height: 20.h,
                                      child: MyText(
                                        txt: 'Add Question',
                                        color: whiteColor,
                                        fontweight: FontWeight.w300,
                                        size: 21.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Text(''),
              SizedBox(
                width: 62.w,
              ),
              const VerticalDivider(
                color: Color(0xff3B3B3B),
              ),
              SizedBox(
                width: 28.w,
              ),
              InkWell(
                onTap: () async {
                  var logout = await userLogOut();
                  if (logout) {
                    Get.offAll(LoginPage());
                  }
                },
                child: Container(
                  width: 38.w,
                  height: 38.w,
                  child: FittedBox(
                    child: Icon(
                      Icons.power_settings_new,
                      color: basicColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 25.w,
              ),
            ],
          )
        ],
      ),
    );
  }
}
