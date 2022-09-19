import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/AddQuestions.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/CustomWidgets/MyText.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/CustomWidgets/Reusable.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/QuestionList.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/components/style.dart';

import '../Controller/QuestionsController.dart';
import '../Services/LoginServices.dart';
import 'Draft.dart';
import 'LoginPage.dart';

Reusable reusableInstance = Reusable();

class SubCategory extends StatefulWidget {
  SubCategory({Key? key}) : super(key: key);

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  CategoryController cateController = Get.find<CategoryController>();
  QuestionController questionController = Get.find<QuestionController>();

  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cateController.categoryViewBtnClick().whenComplete(() async {
      await questionController.getTotalNumberOfQuestionForSpecificCategory();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
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
                                  controller: cateController.subCategoryNameSearch,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: greyColor,
                                  ),
                                  onChanged: (value) {
                                    print(value);
                                    if (value.isEmpty) {
                                      cateController.subCategorySearchIndex = -1;
                                      cateController.isSubCategorySearchNotMatch = false;
                                      cateController.update();
                                    } else {
                                      cateController.subCategorySearchTap();
                                    }
                                  },
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
                    Padding(
                      padding: EdgeInsets.only(top: 29.h, right: 60.w),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: reusableInstance.buttons(
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
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 29.h),
                      child: InkWell(
                        onTap: () {
                          Get.to(AddQuestion(callingFor: 'Add'));
                        },
                        child: reusableInstance.buttons(
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
                                  await questionController.erasedData();
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
                    ),
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
          ),
          SizedBox(
            height: 41.h,
          ),
          GetBuilder<CategoryController>(builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cateController.subCateHeader.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            left: index != 0
                                ? index == 3
                                    ? 1075.w
                                    : 120.w
                                : 40.w,
                          ),
                          child: MyText(
                            txt: index != 3 ? cateController.subCateHeader[index] : '${questionController.totalQuestions} Questions',
                            color: index != 3 ? Colors.black : basicColor,
                            fontweight: FontWeight.w500,
                            size: 20.sp,
                          ),
                        );
                      }),
                ),
                SizedBox(height: 50.h),
                Row(
                  children: [
                    GetBuilder<QuestionController>(builder: (con) {
                      return SizedBox(
                        width: 1345.w,
                        height: 882.h,
                        child: isLoading == true
                            ? reusableInstance.loader()
                            : ListView.builder(
                                itemCount: cateController.subCategorySearchIndex == -1
                                    ? cateController.isSubCategorySearchNotMatch
                                        ? 0
                                        : cateController.subCatList.length
                                    : 1,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 63.h,
                                    margin: EdgeInsets.only(bottom: 50.h),
                                    decoration: BoxDecoration(
                                      color: cateContainerColor,
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Container(
                                              width: 60.w,
                                              height: 60.w,
                                              margin: EdgeInsets.only(left: 40.w),
                                              decoration: const BoxDecoration(
                                                color: Color(0xffF5F5F5),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Container(
                                                width: 40.w,
                                                height: 40.h,
                                                margin: EdgeInsets.all(5.h),
                                                child: Image.memory(
                                                    base64Decode(cateController.subCatList[cateController.subCategorySearchIndex == -1 ? index : cateController.subCategorySearchIndex].image)),
                                              )),
                                          Expanded(
                                            flex: 2,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: MyText(
                                                    txt: cateController.subCatList[cateController.subCategorySearchIndex == -1 ? index : cateController.subCategorySearchIndex].name,
                                                    color: Colors.black,
                                                    fontweight: FontWeight.w500,
                                                    size: 20.sp,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: MyText(
                                                    txt:
                                                        '${questionController.totalQuestionOfspecificSubCategory[cateController.subCategorySearchIndex == -1 ? index : cateController.subCategorySearchIndex]}',
                                                    color: Colors.black,
                                                    fontweight: FontWeight.w500,
                                                    size: 20.sp,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: InkWell(
                                                    onTap: () {
                                                      cateController.subCategoryName =
                                                          cateController.subCatList[cateController.subCategorySearchIndex == -1 ? index : cateController.subCategorySearchIndex].name;
                                                      cateController.update();
                                                      Get.to(QuestionList());
                                                    },
                                                    child: MyText(
                                                      txt: 'View',
                                                      color: basicColor,
                                                      fontweight: FontWeight.w500,
                                                      size: 20.sp,
                                                    ),
                                                  ),
                                                ),
                                                const Expanded(
                                                  flex: 1,
                                                  child: Text(''),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                      );
                    }),
                    Container(width: 575.w, height: 882.h, child: reusableInstance.profile(isLoading))
                  ],
                ),
              ],
            );
          })
        ],
      ),
    );
  }
}
