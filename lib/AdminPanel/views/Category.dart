import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/AdminQuestionsListController.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/CategoryController.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/DashBoradController.dart';
import 'package:triviaadminpanal/AdminPanel/Services/ApprovedQuestionServices.dart';
import 'package:triviaadminpanal/AdminPanel/views/AddCategory.dart';
import 'package:triviaadminpanal/AdminPanel/views/CustomWidgets/CustomAppbar.dart';
import 'package:triviaadminpanal/AdminPanel/views/SubCategory.dart';

import '../../main.dart';
import 'CustomWidgets/MyText.dart';
import 'CustomWidgets/colorContainer.dart';
import 'components/style.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var controller = Get.put(CategoryController());
  var educationTab = false;
  var addCat = false;
  var addSubCat = false;
  File? pcikedImage;
  var categoryLogo;
  var subCategoryLogo;
  var cid = '';
  var sid = '';

  var isEdit = false;
  var isSubCatEdit = false;
  // @override
  // void initState() {
  //   super.initState();
  //   countSubCatLength();
  // }

  countSubCatLength() async {
    if (controller.catList.length == 0) {
      await controller.getCategories();
      controller.subCatLength.clear();
      for (int i = 0; i < controller.catList.length; i++) {
        await controller.getSubCategories(controller.catList[i][2]);
        controller.subCatLength.add(controller.subcatList.length);
      }
      controller.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
            future: countSubCatLength(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                );
              } else {
                return GetBuilder<CategoryController>(builder: (controller) {
                  return Column(
                    children: [
                      SizedBox(
                        width: 1586.w,
                        height: 70.h,
                        child: Card(
                          margin: EdgeInsets.zero,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 40.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.categoryTextControllr.text = '';
                                    controller.categoryLogo = null;
                                    controller.isCategoryEdit = false;
                                    controller.update();

                                    Get.to(AddCategroy());
                                  },
                                  child: colorContainer(
                                    basicColor,
                                    Center(
                                      child: MyText(
                                        txt: 'Add',
                                        color: whiteColor,
                                        fontweight: FontWeight.w600,
                                        size: 15.sp,
                                      ),
                                    ),
                                    60.w,
                                    30.h,
                                    5.h,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: 1586.w,
                            height: 25.h,
                            margin: EdgeInsets.only(top: 40.h),
                            child: Center(
                              child: ListView.builder(
                                  itemCount: 4,
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.only(left: 40.h, right: 40.w),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: index < 2 ? EdgeInsets.only(right: 70.w) : EdgeInsets.only(right: 975.w),
                                      child: MyText(
                                        txt: controller.heading[index],
                                        color: drawerColor,
                                        fontweight: FontWeight.w700,
                                        size: 16.sp,
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          SizedBox(
                            width: 1586.w,
                            height: 900.h,
                            child: Scrollbar(
                              controller: ScrollController(keepScrollOffset: true),
                              child: ListView.builder(
                                  itemCount: controller.catList.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: 1586.w,
                                      height: 60.h,
                                      margin: EdgeInsets.only(top: 40.h),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: hideColor, width: 1.h),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 35.w),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 60.w,
                                              height: 60.h,
                                              // color: hideColor,
                                              child: Image.memory(
                                                base64.decode(controller.catList[index][1]),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 50.w,
                                            ),
                                            SizedBox(
                                                width: 156.w,
                                                height: 24.h,
                                                child: MyText(
                                                  txt: controller.catList[index][0],
                                                  color: drawerColor,
                                                  fontweight: FontWeight.w400,
                                                  size: 18.sp,
                                                )),
                                            SizedBox(
                                              width: 50.w,
                                            ),
                                            SizedBox(
                                                width: 156.w,
                                                height: 24.h,
                                                child: MyText(
                                                  txt: '${controller.subCatLength[index]}',
                                                  color: drawerColor,
                                                  fontweight: FontWeight.w400,
                                                  size: 18.sp,
                                                )),
                                            SizedBox(
                                              width: 80.w,
                                            ),
                                            SizedBox(
                                                width: 42.w,
                                                height: 24.h,
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.to(SubCategory(cid: controller.catList[index][2]));
                                                  },
                                                  child: MyText(
                                                    txt: 'View',
                                                    color: basicColor,
                                                    fontweight: FontWeight.w700,
                                                    size: 18.sp,
                                                  ),
                                                )),
                                            SizedBox(
                                              width: 80.w,
                                            ),
                                            SizedBox(
                                                width: 42.w,
                                                height: 24.h,
                                                child: InkWell(
                                                  onTap: () {
                                                    controller.categoryTextControllr.text = controller.catList[index][0];
                                                    controller.categoryLogo = controller.catList[index][1];
                                                    controller.isCategoryEdit = true;
                                                    controller.cid = controller.catList[index][2];
                                                    controller.update();
                                                    Get.to(AddCategroy());
                                                  },
                                                  child: MyText(
                                                    txt: 'Edit',
                                                    color: basicColor,
                                                    fontweight: FontWeight.w700,
                                                    size: 18.sp,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          )
                        ],
                      )
                    ],
                  );
                });
              }
            }));
  }
}
