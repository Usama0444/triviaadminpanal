import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/ApproveQuestionsListController.dart';
import 'package:triviaadminpanal/AdminPanel/views/AddedQuestionsList.dart';

import '../../TeacherPanel/Controller/DashBoradController.dart';
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
  var controller = Get.put(DashboardController());
  var addController = Get.put(ApproveQuestionsListController());
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
                        GestureDetector(
                          onTap: () {
                            controller.addQuestion = false;
                            controller.update();
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
                        GestureDetector(
                          onTap: () async {
                            if (addController.isEdit) {
                              await addController.updateQuestion(controller.category, controller.subCategory, FirebaseAuth.instance.currentUser?.email);
                              addController.isEdit = false;
                              addController.update();
                            } else {
                              await addController.addNewQuestions(controller.category, controller.subCategory, FirebaseAuth.instance.currentUser?.email);
                            }

                            // if (addController.isValid) {
                            await addController.getquestion();
                            addController.question.text = '';
                            addController.option1.text = '';
                            addController.option2.text = '';
                            addController.option3.text = '';
                            addController.option4.text = '';
                            addController.qid = '';
                            addController.update();
                            var dashboradCont = Get.put(DashboardController());
                            dashboradCont.addQuestion = false;
                            dashboradCont.update();
                            // }
                          },
                          child: colorContainer(
                            basicColor,
                            Center(
                              child: MyText(
                                txt: addController.isEdit != true ? 'Save' : 'Update',
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
          margin: EdgeInsets.symmetric(vertical: 30.h, horizontal: 40.w),
          child: Column(
            children: [
              Containers(
                'Question',
                360.w,
                85.h,
                2,
                addController.question,
              ),
              Containers(
                'Option 1',
                360.w,
                60.h,
                1,
                addController.option1,
              ),
              Containers(
                'Option 2',
                360.w,
                60.h,
                1,
                addController.option2,
              ),
              Containers(
                'Option 3',
                360.w,
                60.h,
                1,
                addController.option3,
              ),
              Containers(
                'Option 4',
                360.w,
                60.h,
                1,
                addController.option4,
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
          margin: EdgeInsets.only(top: 10.h, left: 10.w),
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
          margin: EdgeInsets.only(left: 10.w, top: 10.h),
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
