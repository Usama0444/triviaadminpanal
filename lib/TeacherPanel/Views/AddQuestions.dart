import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/QuestionsController.dart';

import '../Controller/DashBoradController.dart';
import 'CustomWidgets/MyText.dart';
import 'CustomWidgets/colorContainer.dart';
import 'CustomWidgets/colorContainer.dart';
import 'components/style.dart';

class AddQuestions extends StatefulWidget {
  AddQuestions({Key? key}) : super(key: key);

  @override
  State<AddQuestions> createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  var dashboard = Get.put(DashboardController());
  var questionController = Get.put(QuestionController());
  var checbox = [false, false, false, false];

  updateQuestion() async {
    setState(() {
      checbox[questionController.answer - 1] = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (questionController.isEdit) {
      updateQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  Container(
                    width: 113.w,
                    height: 24.h,
                    margin: EdgeInsets.zero,
                    child: FittedBox(
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
                            Center(
                              child: MyText(
                                txt: 'Cancel',
                                color: whiteColor,
                                fontweight: FontWeight.w600,
                                size: 15.sp,
                              ),
                            ),
                            70.w,
                            30.h,
                            5.h,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            var teacherEmail = FirebaseAuth.instance.currentUser?.email;
                            if (questionController.isEdit) {
                              await questionController.teacherUpdateQuestion(teacherEmail);
                              questionController.isEdit = false;
                              questionController.update();
                            } else {
                              print('teacherEmail $teacherEmail');
                              await questionController.addNewQuestions(teacherEmail);
                            }
                            questionController.question.text = '';
                            questionController.option1.text = '';
                            questionController.option2.text = '';
                            questionController.option3.text = '';
                            questionController.option4.text = '';
                            questionController.qid = '';
                            questionController.update();
                            var dashboradCont = Get.put(DashboardController());
                            dashboradCont.addQuestion = false;
                            dashboradCont.update();
                            print('Catgory : ${dashboard.category}');
                            print('Sub-Catgory : ${dashboard.subCategory}');
                          },
                          child: colorContainer(
                            basicColor,
                            Center(
                              child: MyText(
                                txt: questionController.isEdit == true ? 'Update' : 'Save',
                                color: whiteColor,
                                fontweight: FontWeight.w600,
                                size: 15.sp,
                              ),
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
          height: 500.h,
          width: 400.w,
          margin: EdgeInsets.symmetric(
            vertical: 50.h,
            horizontal: 40.w,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Containers(
                    'Question',
                    360.w,
                    85.h,
                    2,
                    questionController.question,
                  ),
                  Container(
                    width: 40.w,
                    height: 40.h,
                    margin: EdgeInsets.only(top: 10.h),
                  ),
                ],
              ),
              Row(
                children: [
                  Containers(
                    'Option 1',
                    360.w,
                    60.h,
                    1,
                    questionController.option1,
                  ),
                  Container(
                    width: 40.w,
                    height: 40.h,
                    margin: EdgeInsets.only(top: 10.h),
                    child: Checkbox(
                      fillColor: MaterialStateProperty.all(hideColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.h),
                      ),
                      value: checbox[0],
                      onChanged: (val) {
                        setState(() {
                          for (int i = 0; i < 4; i++) {
                            checbox[i] = false;
                          }
                          checbox[0] = true;
                          questionController.answer = 1;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Containers(
                    'Option 2',
                    360.w,
                    60.h,
                    1,
                    questionController.option2,
                  ),
                  Container(
                    width: 40.w,
                    height: 40.h,
                    margin: EdgeInsets.only(top: 10.h),
                    child: Checkbox(
                      fillColor: MaterialStateProperty.all(hideColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.h),
                      ),
                      value: checbox[1],
                      onChanged: (val) {
                        setState(() {
                          for (int i = 0; i < 4; i++) {
                            checbox[i] = false;
                          }
                          checbox[1] = true;
                          questionController.answer = 2;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Containers(
                    'Option 3',
                    360.w,
                    60.h,
                    1,
                    questionController.option3,
                  ),
                  Container(
                    width: 40.w,
                    height: 40.h,
                    margin: EdgeInsets.only(top: 10.h),
                    child: Checkbox(
                      fillColor: MaterialStateProperty.all(hideColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.h),
                      ),
                      value: checbox[2],
                      onChanged: (val) {
                        setState(() {
                          for (int i = 0; i < 4; i++) {
                            checbox[i] = false;
                          }
                          checbox[2] = true;
                          questionController.answer = 3;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Containers(
                    'Option 4',
                    360.w,
                    60.h,
                    1,
                    questionController.option4,
                  ),
                  Container(
                    width: 40.w,
                    height: 40.h,
                    margin: EdgeInsets.only(top: 10.h),
                    child: Checkbox(
                      fillColor: MaterialStateProperty.all(hideColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.h),
                      ),
                      value: checbox[3],
                      onChanged: (val) {
                        setState(() {
                          for (int i = 0; i < 4; i++) {
                            checbox[i] = false;
                          }
                          checbox[3] = true;
                          questionController.answer = 4;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

Widget Containers(var label, var width, var height, var maXLine, var controller) {
  return Container(
    width: width,
    height: height,
    margin: EdgeInsets.only(top: 20.h),
    decoration: BoxDecoration(
      border: Border.all(color: hideColor, width: 1.h),
    ),
    child: Stack(
      children: [
        Container(
          width: 54.w,
          height: 16.h,
          margin: EdgeInsets.only(top: 2.sp, left: 10.sp),
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
          height: (height * 0.65),
          margin: EdgeInsets.only(left: 10.sp),
          child: TextField(
            controller: controller,
            maxLines: maXLine,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}
