import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Categories.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/CustomWidgets/SideDropDownMenu.dart';

import '../Controller/CategoryController.dart';
import '../Controller/QuestionsController.dart';
import '../Services/LoginServices.dart';
import 'CustomWidgets/MyText.dart';
import 'LoginPage.dart';
import 'components/style.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({Key? key}) : super(key: key);

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  CategoryController catController = Get.find<CategoryController>();
  QuestionController questionController = Get.find<QuestionController>();

  var optionNumber = [
    'a)',
    'b)',
    'c)',
    'd)',
  ];
  DateTime? articleDate;
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
                    InkWell(
                      onTap: () {
                        catController.appBarLogoClick();
                      },
                      child: Row(
                        children: [
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
                        ],
                      ),
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
                          width: 60.w,
                          height: 42.h,
                          margin: EdgeInsets.only(
                            top: 10.h,
                            left: 20.w,
                          ),
                          child: MyText(txt: 'Draft', color: whiteColor, fontweight: FontWeight.w800, size: 22.sp),
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 29.h),
                      child: reusableInstance.buttons(
                        91.w,
                        42.h,
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Row(
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
                    //
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
                        await reusableInstance.logOut();
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              leftSideCategoryForDraft(),
              GetBuilder<QuestionController>(builder: (questionController) {
                return GetBuilder<QuestionController>(builder: (controller) {
                  return SizedBox(
                    width: 1535.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 30.h,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      MyText(
                                        txt: 'Articles /',
                                        color: Colors.black,
                                        fontweight: FontWeight.w800,
                                        size: 25.sp,
                                      ),
                                      MyText(
                                        txt: ' Blogs',
                                        color: Colors.black,
                                        fontweight: FontWeight.w300,
                                        size: 25.sp,
                                      ),
                                    ],
                                  ),
                                  MyText(
                                    txt: '${questionController.draftQuestionModelList.length} Articles',
                                    color: basicColor,
                                    fontweight: FontWeight.w500,
                                    size: 20.sp,
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(height: 45.h),
                        SizedBox(
                          height: 882.h,
                          child: ListView.builder(
                            itemCount: questionController.draftQuestionModelList.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              articleDate = questionController.draftQuestionModelList[index].createdDate.toDate();
                              return questionController.draftQuestionModelList[index].article == ''
                                  ? const Text('')
                                  : Container(
                                      height: 121.h,
                                      margin: EdgeInsets.only(bottom: 29.h),
                                      decoration: BoxDecoration(
                                        color: cateContainerColor,
                                      ),
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  MyText(
                                                    txt: 'Article no : 0${index + 1}',
                                                    color: Colors.black,
                                                    fontweight: FontWeight.w800,
                                                    size: 16.sp,
                                                  ),
                                                  MyText(
                                                    txt: '${articleDate?.day}' '/' '${articleDate?.month}' '/' '${articleDate?.year}',
                                                    color: basicColor,
                                                    fontweight: FontWeight.w800,
                                                    size: 10.sp,
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  SizedBox(
                                                    width: 1300.w,
                                                    child: Text(
                                                      overflow: TextOverflow.visible,
                                                      questionController.draftQuestionModelList[index].article,
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w300,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      questionController.copyBtnClick(index);
                                                      reusableInstance.toast('Copied', 'copy to Clipboard');
                                                    },
                                                    child: MyText(
                                                      txt: 'Copy',
                                                      color: Color(0xff00D579),
                                                      fontweight: FontWeight.w800,
                                                      size: 20.sp,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      questionController.editDraftBtnClick(index);
                                                    },
                                                    child: MyText(
                                                      txt: 'Edit',
                                                      color: Color(0xff2CB4B3),
                                                      fontweight: FontWeight.w800,
                                                      size: 20.sp,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      await questionController.deleteDraftBtnClick(index);
                                                    },
                                                    child: MyText(
                                                      txt: 'Delete',
                                                      color: Color(0xffFF0000),
                                                      fontweight: FontWeight.w800,
                                                      size: 20.sp,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )),
                                    );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                });
              }),
            ],
          )
        ],
      ),
    );
  }

  Widget myContainers(
    var label,
    var width,
    var height,
    var maXLine,
  ) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(top: 10.h),
      child: Stack(
        children: [
          Container(
            width: 54.w,
            height: 16.h,
            margin: EdgeInsets.only(left: 5.w),
            child: FittedBox(
              child: MyText(
                txt: label,
                color: hideColor,
                fontweight: FontWeight.normal,
                size: 12.sp,
              ),
            ),
          ),
          Container(
            width: width,
            height: height,
            margin: EdgeInsets.only(left: 5.w),
            child: TextField(
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
              maxLength: label == 'Question' ? 40 : 30,
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
