import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/DashBoradController.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/LoginController.dart';
import 'package:triviaadminpanal/AdminPanel/views/AddQuestion.dart';
import 'package:triviaadminpanal/AdminPanel/views/AddTeacher.dart';
import 'package:triviaadminpanal/AdminPanel/views/AdminQuestionList.dart';
import 'package:triviaadminpanal/AdminPanel/views/Category.dart';
import 'package:triviaadminpanal/AdminPanel/views/TeacherNewQuestionsList.dart';
import 'package:triviaadminpanal/AdminPanel/views/Teacher.dart';
import 'package:triviaadminpanal/AdminPanel/views/components/style.dart';

import 'MyDashboard.dart';
import 'TeachersList.dart';
import 'CustomWidgets/MyText.dart';
import 'Users.dart';
import 'ViewApprovedTeacher.dart';
import 'ViewTeacherQuestionList.dart';
import 'components/string.dart';

class DrawerMenu extends StatefulWidget {
  DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  var bodyScreens = [UserDashboard(), Users(), CategoryScreen(), AdminQuestionList()];
  var subCateScreen = [AdminQuestionList(), ApproveTeacherQuestionsList(), ApprovedTeacherList(), Teacher()];

  var cont = Get.put(DashboardController());
  var login = Get.put(LogInController());

  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: ((controller) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(
          children: [
            Container(
              width: 334.w,
              height: 1080.h,
              color: drawerColor,
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          MyText(
                            txt: loginHeader,
                            color: basicColor,
                            fontweight: FontWeight.bold,
                            size: 35.sp,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.h, left: 5.w),
                            child: MyText(
                              txt: loginAdmin,
                              color: secondColor,
                              fontweight: FontWeight.bold,
                              size: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: secondColor,
                    ),
                    SizedBox(
                        width: 300,
                        height: 900.h,
                        child: ListView.builder(
                            itemCount: 4,
                            padding: EdgeInsets.only(
                              top: 10.h,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                  mouseCursor: MouseCursor.defer,
                                  onTap: () {
                                    for (int i = 0; i < 4; i++) {
                                      controller.menuBottomBorderColor[i] = drawerColor;
                                      controller.menuColor[i] = secondColor;
                                    }
                                    controller.menuBottomBorderColor[index] = basicColor;
                                    controller.menuColor[index] = basicColor;
                                    controller.screenIndex = index;
                                    controller.showTeacherApprovedQuestionsList = 0;
                                    controller.update();
                                    setState(() {
                                      visible = false;
                                    });
                                    // print('screen index $screenIndex');
                                  },
                                  child: controller.menuList[index] != 'Questions'
                                      ? Container(
                                          width: 334.w,
                                          height: 40.h,
                                          margin: EdgeInsets.only(left: 22.w, top: 33.h),
                                          decoration: BoxDecoration(
                                            border: Border(right: BorderSide(color: controller.menuBottomBorderColor[index], width: 6.h)),
                                          ),
                                          child: MyText(
                                            txt: controller.menuList[index],
                                            color: controller.menuColor[index],
                                            fontweight: FontWeight.bold,
                                            size: 20.sp,
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (visible) {
                                                    visible = false;
                                                  } else {
                                                    visible = true;
                                                  }
                                                  controller.showTeacherApprovedQuestionsList = 0;

                                                  controller.update();
                                                });
                                                for (int i = 0; i < 4; i++) {
                                                  controller.menuBottomBorderColor[i] = drawerColor;
                                                  controller.menuColor[i] = secondColor;
                                                }
                                                controller.menuColor[index] = basicColor;
                                                controller.menuBottomBorderColor[index] = basicColor;

                                                controller.screenIndex = index;

                                                // print('screen index $screenIndex');
                                                controller.addQuestion = false;
                                                controller.addTeachers = false;
                                                controller.showTeacherQuestionsList = false;
                                                controller.showTeacherApprovedQuestionsList = 0;

                                                controller.update();
                                                print('controller.showTeacherApprovedQuestionsList');
                                                print(controller.showTeacherApprovedQuestionsList);
                                              },
                                              child: Container(
                                                width: 334.w,
                                                height: 40.h,
                                                margin: EdgeInsets.only(left: 22.w, top: 33.h),
                                                decoration: BoxDecoration(
                                                  border: Border(right: BorderSide(color: controller.menuBottomBorderColor[index], width: 3.5)),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    MyText(
                                                      txt: controller.menuList[index],
                                                      color: controller.menuColor[index],
                                                      fontweight: FontWeight.bold,
                                                      size: 20.sp,
                                                    ),
                                                    Container(
                                                      width: 8.w,
                                                      height: 5.17.h,
                                                      margin: EdgeInsets.only(right: 36.w, bottom: 10.h),
                                                      child: Icon(
                                                        visible == false ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                                                        color: secondColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: visible,
                                              child: Container(
                                                width: 334.w,
                                                height: 250.h,
                                                margin: EdgeInsets.only(left: 22.w, top: 20.h),
                                                child: ListView.builder(
                                                    itemCount: 4,
                                                    itemBuilder: (context, j) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          for (int i = 0; i < 4; i++) {
                                                            controller.menuSubCatColor[i] = secondColor;
                                                          }
                                                          controller.menuSubCatColor[j] = basicColor;
                                                          controller.addQuestion = false;
                                                          controller.addTeachers = false;
                                                          controller.showTeacherQuestionsList = false;
                                                          controller.showTeacherApprovedQuestionsList = 0;
                                                          controller.subCatIndex = j;
                                                          if (controller.questionsSubCat[j] == 'Approve View Question') {
                                                            controller.approveScreen = true;
                                                          } else {
                                                            controller.approveScreen = false;
                                                          }
                                                          controller.update();
                                                        },
                                                        child: Container(
                                                          height: 50.h,
                                                          child: MyText(
                                                            txt: controller.questionsSubCat[j],
                                                            color: controller.menuSubCatColor[j],
                                                            fontweight: FontWeight.bold,
                                                            size: 16.sp,
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                          ],
                                        ));
                            })),
                  ],
                ),
                Column(
                  children: [
                    Divider(
                      color: secondColor,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          login.logOut();
                          print('pressed');
                        },
                        child: Icon(
                          Icons.power_settings_new,
                          color: basicColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 19.h,
                ),
              ]),
            ),
            controller.addQuestion == true
                ? Container(width: 1586.w, height: 1080.h, child: AddQuestions())
                : controller.addTeachers == true
                    ? Container(width: 1586.w, height: 1080.h, child: AddTeachers())
                    : controller.showTeacherQuestionsList == true
                        ? Container(width: 1586.w, height: 1080.h, child: TeacherNewQuestionsList())
                        : controller.showTeacherApprovedQuestionsList == 1
                            ? Container(width: 1586.w, height: 1080.h, child: ViewTeacherQuestionList())
                            : Container(width: 1586.w, height: 1080.h, child: controller.screenIndex > 2 ? subCateScreen[controller.subCatIndex] : bodyScreens[controller.screenIndex]),
          ],
        ),
      );
    }));
  }
}
