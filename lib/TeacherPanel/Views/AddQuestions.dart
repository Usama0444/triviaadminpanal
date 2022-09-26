// ignore_for_file: avoid_init_to_null

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/QuestionsController.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Categories.dart';

import '../Services/LoginServices.dart';
import 'CustomWidgets/MyText.dart';
import 'CustomWidgets/text_input_field_widget.dart';
import 'LoginPage.dart';
import 'components/max_word_textinput_formater.dart';
import 'components/style.dart';

class AddQuestion extends StatefulWidget {
  var callingFor;
  AddQuestion({Key? key, required this.callingFor}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  bool? isCorrect1, isCorrect2, isCorrect3, isCorrect4;
  CategoryController catController = Get.find<CategoryController>();
  QuestionController questionController = Get.find<QuestionController>();
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    catController.fillSubCategoryForDrawer().whenComplete(() async {
      questionController.checkCategoryAndSubCategoryAlreadySelected();
      await questionController.getTotalQuestionsOfSepecificSubcategoryForAddQuestion();
      if (widget.callingFor == 'Edit') {
        questionController.isShowSubCategoryQuestionForm = true;
      }
      questionController.highlightSpecificSubCategoryInit();
      questionController.hideShowListInit();
      setState(() {
        if (questionController.answer != null) {
          if (questionController.answer == 1) {
            isCorrect1 = true;
            isCorrect2 = false;
            isCorrect3 = false;
            isCorrect4 = false;
          } else if (questionController.answer == 2) {
            isCorrect2 = true;
            isCorrect1 = false;
            isCorrect3 = false;
            isCorrect4 = false;
          } else if (questionController.answer == 3) {
            isCorrect3 = true;
            isCorrect2 = false;
            isCorrect1 = false;
            isCorrect4 = false;
          } else {
            isCorrect4 = true;
            isCorrect2 = false;
            isCorrect3 = false;
            isCorrect1 = false;
          }
        }
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
                          width: 150.w,
                          height: 42.h,
                          margin: EdgeInsets.only(
                            top: 10.h,
                            left: 20.w,
                          ),
                          child: MyText(txt: 'Add Question', color: whiteColor, fontweight: FontWeight.w800, size: 22.sp),
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 29.h),
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
                ),
              ],
            ),
          ),
          SizedBox(
            height: 41.h,
          ),
          GetBuilder<QuestionController>(builder: (controller) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 375.w,
                  height: 924.h,
                  color: Color(0xffFAFAFA),
                  child: isLoading
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 200.h,
                            ),
                            Text('Loading...'),
                            SizedBox(
                              height: 5.h,
                            ),
                            CircularProgressIndicator(),
                          ],
                        )
                      : ListView.builder(
                          itemCount: catController.catList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                questionController.hideShowDropDown(index);
                                questionController.highlightSpecificSubCategoryInit();
                              },
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: questionController.hideCategory[index],
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
                                      visible: questionController.showSubCategory[index],
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
                                                    questionController.questionSubCategory = catController.subCategoriesForDrawer[index][j - 1].name;
                                                    questionController.highlightSpecificSubCategory(j);
                                                  } else {
                                                    questionController.hideShowDropDown(index);
                                                  }
                                                },
                                                child: Container(
                                                    width: 355.w,
                                                    height: 60.h,
                                                    margin: EdgeInsets.only(top: 14.h, left: 14.w, right: 14.w),
                                                    decoration: BoxDecoration(
                                                      color: j != 0 ? questionController.highlightSubCategories[j] : whiteColor,
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
                                                                      j == 0
                                                                          ? base64Decode(catController.catList[index].image)
                                                                          : base64Decode(catController.subCategoriesForDrawer[index][j - 1].image),
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
                                                              MyText(
                                                                txt: j != 0 ? '${controller.questionLengthPerSubcateogryForAddQuestion[index][j - 1]}' : '${catController.totalSubCate[index]}',
                                                                color: Colors.black,
                                                                fontweight: FontWeight.w600,
                                                                size: 14.sp,
                                                              ),
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
                ),
                SizedBox(
                  width: 40.w,
                ),
                Visibility(
                  visible: questionController.isShowSubCategoryQuestionForm,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          reusableInstance.inputBox(740.w, 80.h, greyColor, myContainers('Question', 740.w, 80.h, 2, questionController.question)),
                          SizedBox(
                            height: 20.w,
                          ),
                          Row(
                            children: [
                              reusableInstance.inputBox(360.w, 60.h, greyColor, myContainers('Option 1', 740.w, 80.h, 2, questionController.option1)),
                              SizedBox(
                                width: 20.w,
                              ),
                              reusableInstance.inputBox(360.w, 60.h, greyColor, myContainers('Option 2', 740.w, 80.h, 2, questionController.option2))
                            ],
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (questionController.option1.text.trim().isNotEmpty) {
                                    setState(() {
                                      isCorrect1 = true;
                                      isCorrect2 = false;
                                      isCorrect3 = false;
                                      isCorrect4 = false;
                                    });
                                  } else {
                                    setState(() {
                                      isCorrect1 = null;
                                      isCorrect2 = null;
                                      isCorrect3 = null;
                                      isCorrect4 = null;
                                    });
                                  }
                                  questionController.answer = 1;
                                  questionController.update();
                                },
                                child: Container(
                                  width: 360.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isCorrect1 != null && isCorrect1 == false ? Color(0xffFF0000) : Color(0xff50A89F),
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: isCorrect1 != null && isCorrect1 == false
                                            ? Colors.white
                                            : isCorrect1 == true
                                                ? Colors.white
                                                : greyColor.withOpacity(1.0),
                                        offset: Offset(
                                          3.0,
                                          3.0,
                                        ),
                                        blurRadius: 1.0,
                                        spreadRadius: -2.0,
                                      )
                                    ],
                                    color: isCorrect1 == true ? Color(0xff00D579) : Colors.white,
                                  ),
                                  child: Center(
                                    child: MyText(
                                      txt: isCorrect1 != null && isCorrect1 == false
                                          ? 'wrong answer'
                                          : isCorrect1 == true
                                              ? 'correct answer'
                                              : 'Select if this a correct answer',
                                      color: isCorrect1 != null && isCorrect1 == false
                                          ? Colors.red
                                          : isCorrect1 == true
                                              ? Colors.white
                                              : Colors.green,
                                      fontweight: FontWeight.w300,
                                      size: 12.sp,
                                    ),

                                    // Text('Select if this a correct answer'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              InkWell(
                                onTap: () {
                                  if (questionController.option2.text.trim().isNotEmpty) {
                                    setState(() {
                                      isCorrect1 = false;
                                      isCorrect2 = true;
                                      isCorrect3 = false;
                                      isCorrect4 = false;
                                    });
                                  } else {
                                    setState(() {
                                      isCorrect1 = null;
                                      isCorrect2 = null;
                                      isCorrect3 = null;
                                      isCorrect4 = null;
                                    });
                                  }
                                  questionController.answer = 2;
                                  questionController.update();
                                },
                                child: Container(
                                  width: 360.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isCorrect2 != null && isCorrect2 == false ? Color(0xffFF0000) : Color(0xff50A89F),
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: isCorrect2 != null && isCorrect2 == false
                                            ? Colors.white
                                            : isCorrect2 == true
                                                ? Colors.white
                                                : greyColor.withOpacity(1.0),
                                        offset: Offset(
                                          3.0,
                                          3.0,
                                        ),
                                        blurRadius: 1.0,
                                        spreadRadius: -2.0,
                                      )
                                    ],
                                    color: isCorrect2 == true ? Color(0xff00D579) : Colors.white,
                                  ),
                                  child: Center(
                                    child: MyText(
                                      txt: isCorrect2 != null && isCorrect2 == false
                                          ? 'wrong answer'
                                          : isCorrect2 == true
                                              ? 'correct answer'
                                              : 'Select if this a correct answer',
                                      color: isCorrect2 != null && isCorrect2 == false
                                          ? Colors.red
                                          : isCorrect2 == true
                                              ? Colors.white
                                              : Colors.green,
                                      fontweight: FontWeight.w300,
                                      size: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          Row(
                            children: [
                              reusableInstance.inputBox(360.w, 60.h, greyColor, myContainers('Option 3', 740.w, 80.h, 2, questionController.option3)),
                              SizedBox(
                                width: 20.w,
                              ),
                              reusableInstance.inputBox(360.w, 60.h, greyColor, myContainers('Option 4', 740.w, 80.h, 2, questionController.option4))
                            ],
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (questionController.option3.text.trim().isNotEmpty) {
                                    setState(() {
                                      isCorrect1 = false;
                                      isCorrect2 = false;
                                      isCorrect3 = true;
                                      isCorrect4 = false;
                                    });
                                  } else {
                                    setState(() {
                                      isCorrect1 = null;
                                      isCorrect2 = null;
                                      isCorrect3 = null;
                                      isCorrect4 = null;
                                    });
                                  }
                                  questionController.answer = 3;
                                  questionController.update();
                                },
                                child: Container(
                                  width: 360.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isCorrect3 != null && isCorrect3 == false ? Color(0xffFF0000) : Color(0xff50A89F),
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: isCorrect3 != null && isCorrect3 == false
                                            ? Colors.white
                                            : isCorrect2 == true
                                                ? Colors.white
                                                : greyColor.withOpacity(1.0),
                                        offset: Offset(
                                          3.0,
                                          3.0,
                                        ),
                                        blurRadius: 1.0,
                                        spreadRadius: -2.0,
                                      )
                                    ],
                                    color: isCorrect3 == true ? Color(0xff00D579) : Colors.white,
                                  ),
                                  child: Center(
                                    child: MyText(
                                      txt: isCorrect3 != null && isCorrect3 == false
                                          ? 'wrong answer'
                                          : isCorrect3 == true
                                              ? 'correct answer'
                                              : 'Select if this a correct answer',
                                      color: isCorrect3 != null && isCorrect3 == false
                                          ? Colors.red
                                          : isCorrect3 == true
                                              ? Colors.white
                                              : Colors.green,
                                      fontweight: FontWeight.w300,
                                      size: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              InkWell(
                                onTap: () {
                                  if (questionController.option4.text.trim().isNotEmpty) {
                                    setState(() {
                                      isCorrect1 = false;
                                      isCorrect2 = false;
                                      isCorrect3 = false;
                                      isCorrect4 = true;
                                    });
                                  } else {
                                    setState(() {
                                      isCorrect1 = null;
                                      isCorrect2 = null;
                                      isCorrect3 = null;
                                      isCorrect4 = null;
                                    });
                                  }
                                  questionController.answer = 4;
                                  questionController.update();
                                },
                                child: Container(
                                  width: 360.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isCorrect4 != null && isCorrect4 == false ? Color(0xffFF0000) : Color(0xff50A89F),
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: isCorrect4 != null && isCorrect4 == false
                                            ? Colors.white
                                            : isCorrect4 == true
                                                ? Colors.white
                                                : greyColor.withOpacity(1.0),
                                        offset: const Offset(
                                          3.0,
                                          3.0,
                                        ),
                                        blurRadius: 1.0,
                                        spreadRadius: -2.0,
                                      )
                                    ],
                                    color: isCorrect4 == true ? Color(0xff00D579) : Colors.white,
                                  ),
                                  child: Center(
                                    child: MyText(
                                      txt: isCorrect4 != null && isCorrect4 == false
                                          ? 'wrong answer'
                                          : isCorrect4 == true
                                              ? 'correct answer'
                                              : 'Select if this a correct answer',
                                      color: isCorrect4 != null && isCorrect4 == false
                                          ? Colors.red
                                          : isCorrect4 == true
                                              ? Colors.white
                                              : Colors.green,
                                      fontweight: FontWeight.w300,
                                      size: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          Container(
                            width: 740.w,
                            height: 500.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: greyColor,
                                width: 1.h,
                              ),
                              borderRadius: BorderRadius.circular(10.h),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  width: 740,
                                  height: 500.h,
                                ),
                                Positioned(
                                  top: 0,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.w),
                                    child: Container(
                                      width: 720.w,
                                      margin: EdgeInsets.zero,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          MyText(txt: 'Article/Description', color: Colors.black, fontweight: FontWeight.bold, size: 15.sp),
                                          GetBuilder<QuestionController>(builder: (con) {
                                            return MyText(txt: '${questionController.textCounter}/500', color: Colors.black, fontweight: FontWeight.w300, size: 15.sp);
                                          })
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 20.h,
                                  left: 10.w,
                                  child: Container(
                                    width: 700.w,
                                    height: 400.h,
                                    child: TextInputFieldWidget(
                                      controller: questionController.article,
                                      maxLength: 2000,
                                      maxLines: 200,
                                      textInputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9\?\s_-]+")),
                                        MaxWordTextInputFormater(maxWords: 500, currentLength: questionController.increaseTextCounter),
                                      ],
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: 17.h,
                                    right: 24.w,
                                    child: Row(
                                      children: [
                                        reusableInstance.buttons(
                                          100.w,
                                          37.w,
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 25.h,
                                                child: FittedBox(
                                                  child: Icon(
                                                    Icons.add,
                                                    color: whiteColor,
                                                  ),
                                                ),
                                              ),
                                              MyText(
                                                txt: 'Image',
                                                color: whiteColor,
                                                fontweight: FontWeight.w300,
                                                size: 20.sp,
                                              ),
                                            ],
                                          ),
                                        ),

                                        // InkWell(
                                        //   onTap: () async {
                                        //     setState(() {
                                        //       isCorrect1 = null;
                                        //       isCorrect2 = null;
                                        //       isCorrect3 = null;
                                        //       isCorrect4 = null;
                                        //     });
                                        //     if (widget.callingFor == 'Edit') {
                                        //       await questionController.teacherUpdateQuestion();
                                        //     } else {
                                        //       await questionController.uploadBtnClick();
                                        //     }
                                        //   },
                                        //   child: reusableInstance.buttons(
                                        //     100.w,
                                        //     42.h,
                                        //     Container(
                                        //       height: 20.h,
                                        //       child: Center(
                                        //         child: MyText(
                                        //           txt: 'Upload',
                                        //           color: whiteColor,
                                        //           fontweight: FontWeight.w300,
                                        //           size: 23.sp,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(25.h),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                bool isQuestionDraft = await questionController.draftBtnClick();
                                if (isQuestionDraft) {
                                  setState(() {
                                    isCorrect1 = null;
                                    isCorrect2 = null;
                                    isCorrect3 = null;
                                    isCorrect4 = null;
                                  });
                                  questionController.erasedData();
                                }
                              },
                              child: reusableInstance.buttons(
                                180.w,
                                37.w,
                                Container(
                                  height: 20.h,
                                  child: Center(
                                    child: MyText(
                                      txt: 'Save as Draft',
                                      color: whiteColor,
                                      fontweight: FontWeight.w300,
                                      size: 19.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            InkWell(
                              onTap: () async {
                                await questionController.uploadBtnClick();
                                setState(() {
                                  isCorrect1 = null;
                                  isCorrect2 = null;
                                  isCorrect3 = null;
                                  isCorrect4 = null;
                                });
                              },
                              child: reusableInstance.buttons(
                                180.w,
                                42.h,
                                Container(
                                  height: 20.h,
                                  child: Center(
                                    child: MyText(
                                      txt: 'Upload to Admin',
                                      color: whiteColor,
                                      fontweight: FontWeight.w300,
                                      size: 19.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget myContainers(var label, var width, var height, var maXLine, TextEditingController cont) {
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
            margin: EdgeInsets.only(left: 5.w, bottom: 10.w),
            child: TextInputFieldWidget(
              controller: cont,
              maxLength: label == 'Question' ? 200 : 20,
              maxLines: 1,
              textInputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9\?\s_-]+")),
                MaxWordTextInputFormater(maxWords: label == 'Question' ? 50 : 2),
              ],
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
