import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/DashBoradController.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/LoginController.dart';
import 'package:triviaadminpanal/AdminPanel/views/AddQuestion.dart';
import 'package:triviaadminpanal/AdminPanel/views/AddTeacher.dart';
import 'package:triviaadminpanal/AdminPanel/views/ApprovedQuestionList.dart';
import 'package:triviaadminpanal/AdminPanel/views/Category.dart';
import 'package:triviaadminpanal/AdminPanel/views/TeacherQuestionsList.dart';
import 'package:triviaadminpanal/AdminPanel/views/Categories.dart';
import 'package:triviaadminpanal/AdminPanel/views/Dashboard.dart';
import 'package:triviaadminpanal/AdminPanel/views/Teacher.dart';
import 'package:triviaadminpanal/AdminPanel/views/components/style.dart';

import 'MyDashboard.dart';
import 'TeachersList.dart';
import 'CustomWidgets/MyText.dart';
import 'Users.dart';
import 'components/string.dart';

class MyDrawer extends StatefulWidget {
  Widget child;
  MyDrawer({Key? key, required this.child}) : super(key: key);

  @override
  State<MyDrawer> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<MyDrawer> {
  var bodyScreens = [UserDashboard(), Users(), CategoryScreen(), AddedQuestionsList()];
  var subCateScreen = [AddedQuestionsList(), ApproveTeacherQuestionsList(), Teacher()];

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
                                    Get.back();
                                    for (int i = 0; i < 4; i++) {
                                      controller.menuBottomBorderColor[i] = drawerColor;
                                      controller.menuColor[i] = secondColor;
                                    }
                                    controller.menuBottomBorderColor[index] = basicColor;
                                    controller.menuColor[index] = basicColor;
                                    controller.screenIndex = index;
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

                                                controller.update();
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
                                                      margin: EdgeInsets.only(right: 36.w),
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
                                                height: 200.h,
                                                margin: EdgeInsets.only(left: 22.w, top: 20.h),
                                                child: ListView.builder(
                                                    itemCount: 3,
                                                    itemBuilder: (context, j) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          for (int i = 0; i < 3; i++) {
                                                            controller.menuSubCatColor[i] = secondColor;
                                                          }
                                                          controller.menuSubCatColor[j] = basicColor;
                                                          controller.addQuestion = false;
                                                          controller.addTeachers = false;
                                                          controller.showTeacherQuestionsList = false;
                                                          controller.subCatIndex = j;
                                                          if (controller.questionsSubCat[j] == 'Approve') {
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
            Container(width: 1586.w, height: 1080.h, child: widget.child),
          ],
        ),
      );
    }));
  }
}
