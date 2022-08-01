import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Education/Histroy.dart';

import '../Controller/DashBoradController.dart';
import 'CustomWidgets/MyText.dart';
import 'AddQuestions.dart';
import 'Education/Biology.dart';
import 'Education/Chemistry.dart';
import 'Education/Math.dart';
import 'Education/Physics.dart';
import 'Education/Science.dart';
import 'Sports/Badminton.dart';
import 'Sports/Circket.dart';
import 'Sports/Football.dart';
import 'Sports/Hockey.dart';
import 'Sports/Pool.dart';
import 'Sports/Tennis.dart';
import 'components/string.dart';
import 'components/style.dart';

class TeacherDrawerMenu extends StatefulWidget {
  TeacherDrawerMenu({Key? key}) : super(key: key);

  @override
  State<TeacherDrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<TeacherDrawerMenu> {
  bool educationVisible = false;
  bool sportVisible = false;
  var educationScreens = [Science(), Biology(), Chemistry(), Physics(), Math(), History()];
  var sportsScreens = [
    Circket(),
    Football(),
    Pool(),
    Badminton(),
    Hockey(),
    Tennis(),
  ];
  var con = Get.put(DashboardController());
  int educationScreenIndex = 0;
  int sportScreenIndex = 0;
  String screenName = 'Education';
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
                              txt: loginTeacher,
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
                            itemCount: 2,
                            padding: EdgeInsets.only(
                              top: 10.h,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    for (int i = 0; i < 2; i++) {
                                      controller.menuBottomBorderColor[i] = drawerColor;
                                      controller.menuColor[i] = secondColor;
                                    }

                                    controller.menuBottomBorderColor[index] = basicColor;
                                    controller.menuColor[index] = basicColor;
                                    controller.category = controller.mainHeading[index];
                                    if (controller.category == 'Sports') {
                                      controller.subCategory = 'Cricket';
                                    }
                                    controller.update();
                                  },
                                  child: Column(
                                    children: [
                                      controller.mainHeading[index] == 'Education'
                                          ? InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (educationVisible) {
                                                    educationVisible = false;
                                                  } else {
                                                    educationVisible = true;
                                                    sportVisible = false;
                                                  }
                                                  educationScreenIndex = index;
                                                  screenName = 'Education';
                                                });
                                                for (int i = 0; i < 2; i++) {
                                                  controller.menuBottomBorderColor[i] = drawerColor;
                                                  controller.menuColor[i] = secondColor;
                                                }
                                                controller.menuColor[index] = basicColor;
                                                controller.menuBottomBorderColor[index] = basicColor;
                                                controller.category = 'Education';
                                                controller.subCategory = 'Science';
                                                controller.addQuestion = false;
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
                                                        txt: controller.mainHeading[index],
                                                        color: controller.menuColor[index],
                                                        fontweight: FontWeight.bold,
                                                        size: 20.sp,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(right: 36.w),
                                                        child: Icon(
                                                          educationVisible == false ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                                                          color: secondColor,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (sportVisible) {
                                                    sportVisible = false;
                                                  } else {
                                                    sportVisible = true;
                                                    educationVisible = false;
                                                  }
                                                  screenName = 'Sports';
                                                  sportScreenIndex = index;
                                                });
                                                for (int i = 0; i < 2; i++) {
                                                  controller.menuBottomBorderColor[i] = drawerColor;
                                                  controller.menuColor[i] = secondColor;
                                                }
                                                controller.menuColor[index] = basicColor;
                                                controller.menuBottomBorderColor[index] = basicColor;
                                                controller.category = 'Sports';
                                                controller.subCategory = 'Cricket';
                                                controller.addQuestion = false;
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
                                                        txt: controller.mainHeading[index],
                                                        color: controller.menuColor[index],
                                                        fontweight: FontWeight.bold,
                                                        size: 20.sp,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(right: 36.w),
                                                        child: Icon(
                                                          sportVisible == false ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                                                          color: secondColor,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                      controller.mainHeading[index] == 'Education'
                                          ? Visibility(
                                              visible: educationVisible,
                                              child: Container(
                                                width: 334.w,
                                                height: 300.h,
                                                margin: EdgeInsets.only(left: 22.w, top: 20.h),
                                                child: ListView.builder(
                                                    itemCount: 6,
                                                    itemBuilder: (context, j) {
                                                      return InkWell(
                                                        onTap: () {
                                                          for (int i = 0; i < 6; i++) {
                                                            controller.educationSubCatColor[i] = secondColor;
                                                          }
                                                          controller.educationSubCatColor[j] = basicColor;
                                                          setState(() {
                                                            educationScreenIndex = j;
                                                          });
                                                          controller.addQuestion = false;
                                                          controller.subCategory = controller.subjectsNameList[j];
                                                          controller.update();
                                                        },
                                                        child: Container(
                                                          height: 50.h,
                                                          child: Row(
                                                            children: [
                                                              MyText(
                                                                txt: controller.subjectsNameList[j],
                                                                color: controller.educationSubCatColor[j],
                                                                fontweight: FontWeight.bold,
                                                                size: 16.sp,
                                                              ),
                                                              SizedBox(
                                                                width: 6.w,
                                                              ),
                                                              MyText(
                                                                txt: '${controller.subjectNumberList[j]}',
                                                                color: controller.educationSubCatColor[j],
                                                                fontweight: FontWeight.bold,
                                                                size: 16.sp,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            )
                                          : Visibility(
                                              visible: sportVisible,
                                              child: Container(
                                                width: 334.w,
                                                height: 300.h,
                                                margin: EdgeInsets.only(left: 22.w, top: 20.h),
                                                child: ListView.builder(
                                                    itemCount: 6,
                                                    itemBuilder: (context, j) {
                                                      return InkWell(
                                                        onTap: () {
                                                          for (int i = 0; i < 6; i++) {
                                                            controller.sportSubCatColor[i] = secondColor;
                                                          }
                                                          controller.sportSubCatColor[j] = basicColor;
                                                          setState(() {
                                                            setState(() {
                                                              sportScreenIndex = j;
                                                            });
                                                          });
                                                          controller.addQuestion = false;
                                                          controller.subCategory = controller.sportNameList[j];

                                                          controller.update();
                                                          print(controller.category);
                                                          print(controller.subCategory);
                                                        },
                                                        child: Container(
                                                          height: 50.h,
                                                          child: Row(
                                                            children: [
                                                              MyText(
                                                                txt: controller.sportNameList[j],
                                                                color: controller.sportSubCatColor[j],
                                                                fontweight: FontWeight.bold,
                                                                size: 16.sp,
                                                              ),
                                                              SizedBox(
                                                                width: 6.w,
                                                              ),
                                                              MyText(
                                                                txt: '${controller.sportNumberList[j]}',
                                                                color: controller.sportSubCatColor[j],
                                                                fontweight: FontWeight.bold,
                                                                size: 16.sp,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            )
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
                      child: Icon(
                        Icons.power_settings_new,
                        color: basicColor,
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
                ? Container(
                    width: 1586.w,
                    height: 1080.h,
                    child: AddQuestions(),
                  )
                : screenName != 'Sports'
                    ? Container(
                        width: 1586.w,
                        height: 1080.h,
                        child: educationScreens[educationScreenIndex],
                      )
                    : Container(
                        width: 1586.w,
                        height: 1080.h,
                        child: sportsScreens[sportScreenIndex],
                      )
          ],
        ),
      );
    }));
  }
}
