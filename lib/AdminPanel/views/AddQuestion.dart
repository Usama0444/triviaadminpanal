import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/AdminQuestionsListController.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/DashBoradController.dart';
import 'package:triviaadminpanal/AdminPanel/views/ApprovedQuestionList.dart';
import 'package:triviaadminpanal/main.dart';

import 'CustomWidgets/MyText.dart';
import 'CustomWidgets/colorContainer.dart';
import 'components/string.dart';
import 'components/style.dart';

class AddQuestions extends StatefulWidget {
  AddQuestions({Key? key}) : super(key: key);

  @override
  State<AddQuestions> createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  var dashboard = Get.put(DashboardController());
  var questionController = Get.put(AdminQuestionsListController());
  var containerBorder = [hideColor, hideColor, hideColor, hideColor];
  var containercolor = [whiteColor, whiteColor, whiteColor, whiteColor];

  var txtList = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
  ];
  updateQuestion() async {
    setState(() {
      for (int i = 0; i < 4; i++) {
        containerBorder[i] = containerWrongBorder;
        containercolor[i] = whiteColor;
      }
      containercolor[questionController.answer - 1] = containerCorrectBorder;
      containerBorder[questionController.answer - 1] = containerCorrectBorder;
    });
  }

  erased() {
    questionController.question.text = '';
    questionController.option1.text = '';
    questionController.option2.text = '';
    questionController.option3.text = '';
    questionController.option4.text = '';
    questionController.qid = '';
    questionController.answer = 0;
    questionController.update();
    setState(() {
      for (int i = 0; i < 4; i++) {
        containerBorder[i] = hideColor;
        containercolor[i] = whiteColor;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (questionController.isEdit) {
      updateQuestion();
    } else {
      erased();
    }
  }

  @override
  Widget build(BuildContext context) {
    var textConList = [
      questionController.option1,
      questionController.option2,
      questionController.option3,
      questionController.option4,
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: 1586.w,
          height: 70.h,
          child: Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 40.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 115.w,
                    height: 24.h,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: MyText(
                        txt: 'Add Question',
                        color: Colors.black,
                        fontweight: FontWeight.w600,
                        size: 18.sp,
                      ),
                    ),
                  ),
                  Container(
                    width: 180.w,
                    height: 30.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            var dashboradCont = Get.put(DashboardController());
                            dashboradCont.addQuestion = false;
                            dashboradCont.update();
                          },
                          child: colorContainer(
                            basicColor,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(
                                  txt: 'Cancel',
                                  color: whiteColor,
                                  fontweight: FontWeight.w500,
                                  size: 15.sp,
                                ),
                              ],
                            ),
                            70.w,
                            30.h,
                            5.h,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            var useremail = pref?.getString('email');
                            if (questionController.isEdit) {
                              await questionController.updateQuestion(dashboard.category, dashboard.subCategory, useremail);
                              questionController.isEdit = false;
                              questionController.update();
                            } else {
                              print('useremail $useremail');
                              await questionController.addNewQuestions(dashboard.category, dashboard.subCategory, useremail);
                            }
                            questionController.question.text = '';
                            questionController.option1.text = '';
                            questionController.option2.text = '';
                            questionController.option3.text = '';
                            questionController.option4.text = '';
                            questionController.qid = '';
                            questionController.answer = 0;
                            questionController.update();
                            setState(() {
                              containerBorder = [hideColor, hideColor, hideColor, hideColor];
                              containercolor = [whiteColor, whiteColor, whiteColor, whiteColor];
                            });
                            var dashboradCont = Get.put(DashboardController());
                            dashboradCont.addQuestion = false;
                            dashboradCont.update();

                            // print('Catgory : ${dashboard.category}');
                            // print('Sub-Catgory : ${dashboard.subCategory}');
                          },
                          child: colorContainer(
                            basicColor,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(
                                  txt: questionController.isEdit == true ? 'Update' : 'Save',
                                  color: whiteColor,
                                  fontweight: FontWeight.w500,
                                  size: 15.sp,
                                ),
                              ],
                            ),
                            60.w,
                            30.h,
                            5.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 800.h,
          width: 500.w,
          margin: EdgeInsets.symmetric(
            vertical: 50.h,
            horizontal: 40.w,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  myContainers(
                    'Question',
                    360.w,
                    85.h,
                    2,
                    hideColor,
                    questionController.question,
                  ),
                  Container(
                    width: 40.w,
                    height: 40.h,
                    margin: EdgeInsets.only(top: 10.h),
                  ),
                ],
              ),
              SizedBox(
                width: 500.w,
                height: 400.h,
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          myContainers(
                            txtList[index],
                            360.w,
                            60.h,
                            1,
                            containerBorder[index],
                            textConList[index],
                          ),
                          GestureDetector(
                            onTap: () {
                              for (int i = 0; i < 4; i++) {
                                containerBorder[i] = containerWrongBorder;
                                containercolor[i] = whiteColor;
                              }
                              containerBorder[index] = containerCorrectBorder;
                              containercolor[index] = containerCorrectBorder;
                              setState(() {});
                              questionController.answer = index + 1;
                              questionController.update();
                            },
                            child: Container(
                              width: 20.w,
                              height: 20.h,
                              margin: EdgeInsets.only(left: 10.w, top: 15.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.h),
                                border: Border.all(color: containerBorder[index], width: 1.h),
                                color: containercolor[index],
                              ),
                            ),
                          ),
                          containercolor[index] == containerCorrectBorder ? greenText() : Text('')
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

Widget myContainers(var label, var width, var height, var maXLine, bcolor, var controller) {
  return Container(
    width: width,
    height: height,
    margin: EdgeInsets.only(top: 20.h),
    decoration: BoxDecoration(
      border: Border.all(color: bcolor, width: 1.w),
    ),
    child: Stack(
      children: [
        Container(
          width: 54.w,
          height: 16.h,
          margin: EdgeInsets.only(top: 10.h, left: 5.w),
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
          margin: EdgeInsets.only(left: 10.w, top: label == 'Question' ? 12.h : 5.h, bottom: 5.h),
          child: Scrollbar(
            child: TextField(
              controller: controller,
              maxLines: maXLine,

              // maxLength: label != 'Question' ? 10 : 100,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget greenText() {
  return Padding(
    padding: EdgeInsets.only(left: 10.w, top: 10.h),
    child: Text(
      'Correct Answer',
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: Color(0xff00D579),
      ),
    ),
  );
}
