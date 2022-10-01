import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/ArticleList.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Categories.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/CustomWidgets/SideDropDownMenu.dart';

import '../Controller/CategoryController.dart';
import '../Controller/QuestionsController.dart';
import '../Services/LoginServices.dart';
import 'CustomWidgets/MyText.dart';
import 'LoginPage.dart';
import 'components/style.dart';

class Draft extends StatefulWidget {
  const Draft({Key? key}) : super(key: key);

  @override
  State<Draft> createState() => _DraftState();
}

class _DraftState extends State<Draft> {
  CategoryController catController = Get.find<CategoryController>();
  QuestionController questionController = Get.find<QuestionController>();
  var optionNumber = [
    'a)',
    'b)',
    'c)',
    'd)',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    catController.fillSubCategoryForDrawer().whenComplete(() async {
      catController.highlightSpecificSubCategoryInit();
      catController.hideShowListInit();
      await questionController.getTotalQuestionsOfSepecificSubcategoryForDraft();
      catController.isLoadingDraft = false;
      catController.update();
    });
  }

  List<Color> highlight = [];
  bool isShowQuestionsList = false;
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
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 20.h,
                                child: MyText(
                                  txt: 'Back',
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
                    SizedBox(
                      width: 60.w,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              leftSideCategoryForDraft(),
              GetBuilder<QuestionController>(builder: (quesController) {
                return Visibility(
                  visible: questionController.isShowQuestionlist,
                  child: SizedBox(
                    width: 1545.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GetBuilder<QuestionController>(builder: (controller) {
                          return SizedBox(
                            height: 882.h,
                            child: ListView.builder(
                              itemCount: questionController.draftQuestionModelList.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 150.h,
                                  margin: EdgeInsets.only(bottom: 29.h),
                                  decoration: BoxDecoration(
                                    color: cateContainerColor,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12.h),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  MyText(
                                                    txt: '${index + 1}.',
                                                    color: basicColor,
                                                    fontweight: FontWeight.w800,
                                                    size: 25.sp,
                                                  ),
                                                  MyText(
                                                    txt: ' ${questionController.draftQuestionModelList[index].question}',
                                                    color: Colors.black,
                                                    fontweight: FontWeight.w800,
                                                    size: 25.sp,
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  questionController.editDraftBtnClick(index);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(right: 25.w),
                                                  child: MyText(
                                                    txt: 'Edit',
                                                    color: basicColor,
                                                    fontweight: FontWeight.w800,
                                                    size: 20.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 50.w, right: 30.w, top: 20.h),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 1300.w,
                                                height: 70.h,
                                                child: ListView.builder(
                                                    itemCount: 4,
                                                    scrollDirection: Axis.horizontal,
                                                    itemBuilder: (context, j) {
                                                      return Container(
                                                        margin: EdgeInsets.only(right: 20.w),
                                                        child: reusableInstance.inputBox(
                                                            300.w,
                                                            70.h,
                                                            j + 1 != questionController.draftQuestionModelList[index].answer ? containerWrongBorder : containerCorrectBorder,
                                                            Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  MyText(
                                                                    txt: optionNumber[j],
                                                                    color: basicColor,
                                                                    fontweight: FontWeight.w800,
                                                                    size: 25.sp,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 250.w,
                                                                    child: SingleChildScrollView(
                                                                      scrollDirection: Axis.vertical,
                                                                      child: MyText(
                                                                        txt: '${questionController.draftQuestionModelList[index].choiceList[j]}',
                                                                        color: Colors.black,
                                                                        maxline: 10,
                                                                        fontweight: FontWeight.w800,
                                                                        size: 22.sp,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      );
                                                    }),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  questionController.deleteDraftBtnClick(index);
                                                },
                                                child: MyText(
                                                  txt: 'Delete',
                                                  color: Color(0xffFF0000),
                                                  fontweight: FontWeight.w800,
                                                  size: 20.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                );
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
