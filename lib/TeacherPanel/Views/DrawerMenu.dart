import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/LoginController.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Body.dart';
import '../Controller/CategoryController.dart';
import '../Controller/DashBoradController.dart';
import 'AddQuestions.dart';
import 'CustomWidgets/MyText.dart';
import 'components/string.dart';
import 'components/style.dart';

class TeacherDrawerMenu extends StatefulWidget {
  TeacherDrawerMenu({Key? key}) : super(key: key);

  @override
  State<TeacherDrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<TeacherDrawerMenu> {
  var con = Get.put(DashboardController());

  var color = [secondColor, secondColor, secondColor, secondColor, secondColor];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    var categoryController = Get.put(CategoryController());
    await categoryController.getCategories();
  }

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
                            itemCount: controller.categoryList.length,
                            padding: EdgeInsets.only(
                              top: 10.h,
                            ),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      for (int i = 0; i < controller.categoryList.length; i++) {
                                        controller.menuBottomBorderColor[i] = drawerColor;
                                        controller.categoryTextColor[i] = secondColor;
                                      }

                                      controller.menuBottomBorderColor[index] = basicColor;
                                      controller.categoryTextColor[index] = basicColor;
                                      controller.category = controller.categoryList[index];
                                      controller.update();
                                      for (int i = 0; i < con.openSubcate.length; i++) {
                                        con.openSubcate[i] = false;
                                      }
                                      if (con.openSubcate[index]) {
                                        con.openSubcate[index] = false;
                                      } else {
                                        con.openSubcate[index] = true;
                                      }
                                      con.update();
                                      setState(() {
                                        for (int i = 0; i < 10; i++) {
                                          color[i] = secondColor;
                                        }
                                      });
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
                                              txt: controller.categoryList[index],
                                              color: controller.categoryTextColor[index],
                                              fontweight: FontWeight.bold,
                                              size: 20.sp,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(right: 36.w),
                                              child: Icon(
                                                con.openSubcate[index] == false ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                                                color: secondColor,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  Visibility(
                                    visible: con.openSubcate[index],
                                    child: Container(
                                      width: 334.w,
                                      height: ((controller.subCategoryList[index].length) * 50).h,
                                      margin: EdgeInsets.only(left: 22.w, top: 20.h),
                                      child: ListView.builder(
                                          itemCount: controller.subCategoryList[index].length,
                                          itemBuilder: (context, j) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  for (int c = 0; c < 5; c++) {
                                                    color[c] = secondColor;
                                                  }
                                                  color[j] = basicColor;
                                                });
                                                controller.addQuestion = false;
                                                controller.subCategory = controller.subCategoryList[index][j];

                                                controller.update();
                                                // print(controller.category);
                                                // print(controller.subCategory);
                                              },
                                              child: Container(
                                                height: 50.h,
                                                child: Row(
                                                  children: [
                                                    MyText(
                                                      txt: controller.subCategoryList[index][j],
                                                      color: color[j],
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
                              );
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
                          var login = Get.put(LogInController());
                          login.logOut();
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
                ? Container(
                    width: 1586.w,
                    height: 1080.h,
                    child: AddQuestions(),
                  )
                : Container(
                    width: 1586.w,
                    height: 1080.h,
                    child: Body(),
                  )
          ],
        ),
      );
    }));
  }
}
