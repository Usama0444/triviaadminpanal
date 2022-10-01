import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Controller/CategoryController.dart';
import '../../Controller/QuestionsController.dart';
import '../ArticleList.dart';
import '../components/style.dart';
import 'MyText.dart';

CategoryController catController = Get.find<CategoryController>();
QuestionController questionController = Get.find<QuestionController>();
Widget leftSideMenuForAddQuestion() {
  return GetBuilder<CategoryController>(builder: (cat) {
    return Container(
      width: 375.w,
      height: 924.h,
      color: const Color(0xffFAFAFA),
      child: catController.isLoadingAddQuestion
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200.h,
                ),
                const Text('Loading...'),
                SizedBox(
                  height: 5.h,
                ),
                const CircularProgressIndicator(),
              ],
            )
          : ListView.builder(
              itemCount: catController.catList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    catController.hideShowDropDown(index);
                    catController.highlightSpecificSubCategoryInit();
                  },
                  child: Column(
                    children: [
                      Visibility(
                        visible: catController.hideCategory[index],
                        child: Container(
                            width: 355.w,
                            height: 60.h,
                            margin: EdgeInsets.only(top: 14.h, left: 14.w, right: 14.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.h),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.w, right: 10.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 50.w,
                                        height: 50.h,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffF5F5F5),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(5.h),
                                          child: ClipOval(
                                              child: Image.memory(
                                            base64Decode(catController.catList[index].image),
                                            fit: BoxFit.cover,
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      MyText(
                                        txt: catController.catList[index].name,
                                        color: Colors.black,
                                        fontweight: FontWeight.w600,
                                        size: 14.sp,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      MyText(
                                        txt: '${catController.totalSubCate[index]}',
                                        color: Colors.black,
                                        fontweight: FontWeight.w600,
                                        size: 14.sp,
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Icon(
                                        Icons.expand_more,
                                        size: 25.sp,
                                        color: basicColor,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Visibility(
                          visible: catController.showSubCategory[index],
                          child: Container(
                            width: 375.w,
                            height: (catController.subCategoriesForDrawer[index].length + 2) * 60.h,
                            color: const Color(0xffC4C4C4),
                            child: ListView.builder(
                                itemCount: catController.subCategoriesForDrawer[index].length + 1,
                                itemBuilder: (context, j) {
                                  return InkWell(
                                    onTap: () async {
                                      if (j != 0) {
                                        catController.questionSubCategory = catController.subCategoriesForDrawer[index][j - 1].name;
                                        catController.highlightSpecificSubCategory(j);
                                        questionController.isShowSubCategoryQuestionForm = true;
                                        questionController.update();
                                      } else {
                                        catController.hideShowDropDown(index);
                                      }
                                    },
                                    child: Container(
                                        width: 355.w,
                                        height: 60.h,
                                        margin: EdgeInsets.only(top: 14.h, left: 14.w, right: 14.w),
                                        decoration: BoxDecoration(
                                          color: j != 0 ? catController.highlightSubCategories[j] : whiteColor,
                                          borderRadius: BorderRadius.circular(10.h),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 20.w, right: 10.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 50.w,
                                                    height: 50.h,
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color(0xffF5F5F5),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(5.h),
                                                      child: ClipOval(
                                                        child: Image.memory(
                                                          j == 0 ? base64Decode(catController.catList[index].image) : base64Decode(catController.subCategoriesForDrawer[index][j - 1].image),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  MyText(
                                                    txt: j == 0 ? catController.catList[index].name : catController.subCategoriesForDrawer[index][j - 1].name,
                                                    color: Colors.black,
                                                    fontweight: FontWeight.w600,
                                                    size: 14.sp,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  GetBuilder<QuestionController>(builder: (controller) {
                                                    return MyText(
                                                      txt: j != 0
                                                          ? controller.questionLengthPerSubcateogryForAddQuestion.isEmpty
                                                              ? ''
                                                              : '${controller.questionLengthPerSubcateogryForAddQuestion[index][j - 1]}'
                                                          : '${catController.totalSubCate[index]}',
                                                      color: Colors.black,
                                                      fontweight: FontWeight.w600,
                                                      size: 14.sp,
                                                    );
                                                  }),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Icon(
                                                    j != 0 ? Icons.arrow_forward_ios_outlined : Icons.expand_less,
                                                    size: j != 0 ? 17.sp : 25.sp,
                                                    color: basicColor,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  );
                                }),
                          ))
                    ],
                  ),
                );
              }),
    );
  });
}

Widget leftSideCategoryForDraft() {
  return GetBuilder<CategoryController>(builder: (cat) {
    return Container(
      width: 375.w,
      height: 924.h,
      color: const Color(0xffFAFAFA),
      child: catController.isLoadingDraft
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200.h,
                ),
                const Text('Loading...'),
                SizedBox(
                  height: 5.h,
                ),
                const CircularProgressIndicator(),
              ],
            )
          : ListView.builder(
              itemCount: catController.catList.length + 1,
              itemBuilder: (context, index) {
                return index != catController.catList.length
                    ? InkWell(
                        onTap: () async {
                          catController.hideShowDropDown(index);
                          catController.highlightSpecificSubCategoryInit();
                        },
                        child: Column(
                          children: [
                            Visibility(
                              visible: catController.hideCategory[index],
                              child: Container(
                                  width: 355.w,
                                  height: 60.h,
                                  margin: EdgeInsets.only(top: 14.h, left: 14.w, right: 14.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.h),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20.w, right: 10.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 50.w,
                                              height: 50.h,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xffF5F5F5),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(5.h),
                                                child: ClipOval(
                                                    child: Image.memory(
                                                  base64Decode(catController.catList[index].image),
                                                  fit: BoxFit.cover,
                                                )),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            MyText(
                                              txt: catController.catList[index].name,
                                              color: Colors.black,
                                              fontweight: FontWeight.w600,
                                              size: 14.sp,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            MyText(
                                              txt: '${catController.totalSubCate[index]}',
                                              color: Colors.black,
                                              fontweight: FontWeight.w600,
                                              size: 14.sp,
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Icon(
                                              Icons.expand_more,
                                              size: 25.sp,
                                              color: basicColor,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            Visibility(
                                visible: catController.showSubCategory[index],
                                child: Container(
                                  width: 375.w,
                                  height: (catController.subCategoriesForDrawer[index].length + 2) * 60.h,
                                  color: const Color(0xffC4C4C4),
                                  child: ListView.builder(
                                      itemCount: catController.subCategoriesForDrawer[index].length + 1,
                                      itemBuilder: (context, j) {
                                        return InkWell(
                                          onTap: () async {
                                            if (j != 0) {
                                              catController.questionSubCategory = catController.subCategoriesForDrawer[index][j - 1].name;
                                              catController.highlightSpecificSubCategory(j);
                                              var isDraftQuestionGet = await questionController.getDraftQuestions();
                                              if (isDraftQuestionGet) {
                                                questionController.isShowQuestionlist = true;
                                                questionController.update();
                                              }
                                            } else {
                                              catController.hideShowDropDown(index);
                                            }
                                          },
                                          child: Container(
                                              width: 355.w,
                                              height: 60.h,
                                              margin: EdgeInsets.only(top: 14.h, left: 14.w, right: 14.w),
                                              decoration: BoxDecoration(
                                                color: j != 0 ? catController.highlightSubCategories[j] : whiteColor,
                                                borderRadius: BorderRadius.circular(10.h),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 20.w, right: 10.w),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 50.w,
                                                          height: 50.h,
                                                          decoration: const BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: Color(0xffF5F5F5),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.all(5.h),
                                                            child: ClipOval(
                                                              child: Image.memory(
                                                                j == 0 ? base64Decode(catController.catList[index].image) : base64Decode(catController.subCategoriesForDrawer[index][j - 1].image),
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        MyText(
                                                          txt: j == 0 ? catController.catList[index].name : catController.subCategoriesForDrawer[index][j - 1].name,
                                                          color: Colors.black,
                                                          fontweight: FontWeight.w600,
                                                          size: 14.sp,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        GetBuilder<QuestionController>(builder: (controller) {
                                                          return MyText(
                                                            txt: j != 0
                                                                ? controller.questionLengthPerSubcateogryForDraftDropDownMenu.isEmpty
                                                                    ? ''
                                                                    : '${controller.questionLengthPerSubcateogryForDraftDropDownMenu[index][j - 1]}'
                                                                : '${catController.totalSubCate[index]}',
                                                            color: Colors.black,
                                                            fontweight: FontWeight.w600,
                                                            size: 14.sp,
                                                          );
                                                        }),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        Icon(
                                                          j != 0 ? Icons.arrow_forward_ios_outlined : Icons.expand_less,
                                                          size: j != 0 ? 17.sp : 25.sp,
                                                          color: basicColor,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        );
                                      }),
                                ))
                          ],
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          Get.to(const ArticleList());
                        },
                        child: Container(
                          width: 355.w,
                          height: 60.h,
                          color: Colors.white,
                          margin: EdgeInsets.only(top: 40.h),
                          child: Padding(
                            padding: EdgeInsets.only(left: 30.w, right: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.mail_outline_outlined, size: 40.h),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    SizedBox(width: 30.w),
                                    MyText(
                                      txt: 'Drafts',
                                      color: drawerColor,
                                      fontweight: FontWeight.w300,
                                      size: 14.sp,
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20.h,
                                  color: basicColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
              }),
    );
  });
}
