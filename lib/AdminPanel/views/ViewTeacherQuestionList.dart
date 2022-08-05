import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/TeacherQuestionsListController.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/AdminQuestionsListController.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/DashBoradController.dart';
import 'package:triviaadminpanal/AdminPanel/views/CustomWidgets/CustomAppbar.dart';

import 'CustomWidgets/MyText.dart';
import 'CustomWidgets/colorContainer.dart';
import 'components/style.dart';

class ViewTeacherQuestionList extends StatefulWidget {
  ViewTeacherQuestionList({Key? key}) : super(key: key);

  @override
  State<ViewTeacherQuestionList> createState() => _AddedQuestionsListState();
}

class _AddedQuestionsListState extends State<ViewTeacherQuestionList> {
  var controller = Get.put(TeacherQuestionContoller());
  var dashboradCont = Get.put(DashboardController());
  List<String> subcategoryList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
            future: controller.getApprovedquestionByteacherEmail(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GetBuilder<TeacherQuestionContoller>(builder: ((questionController) {
                  return Column(children: [
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
                                width: 260.w,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                    color: basicColor,
                                    width: 1.0,
                                  )),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search',
                                      contentPadding: EdgeInsets.only(left: 5.w, bottom: 30.h),
                                      hintStyle: TextStyle(color: hideColor, fontSize: 14.sp),
                                      suffixIcon: Container(
                                        width: 20.w,
                                        height: 20.h,
                                        // color: hideColor,
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Icon(
                                            Icons.search,
                                            color: basicColor,
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  dashboradCont.showTeacherApprovedQuestionsList = false;
                                  dashboradCont.update();
                                },
                                child: colorContainer(
                                  basicColor,
                                  Center(
                                    child: MyText(
                                      txt: 'Back',
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
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        SizedBox(
                          width: 1586.w,
                          height: 24.h,
                          child: ListView.builder(
                              itemCount: 6,
                              padding: EdgeInsets.only(
                                left: 40.w,
                                right: 10.w,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) {
                                return Row(
                                  children: [
                                    i == 5
                                        ? Container(
                                            width: 194.w,
                                            height: 21.h,
                                            margin: EdgeInsets.only(right: 10.w),
                                            child: MyText(
                                              txt: controller.headingText[i],
                                              color: hideColor,
                                              fontweight: FontWeight.w700,
                                              size: 18.sp,
                                            ))
                                        : Container(
                                            width: 160.w,
                                            height: 24.h,
                                            margin: i == 0
                                                ? EdgeInsets.only(right: 280.w)
                                                : i < 4
                                                    ? EdgeInsets.only(right: 80.w)
                                                    : EdgeInsets.only(right: 20.w),
                                            child: MyText(
                                              txt: controller.headingText[i],
                                              color: secondColor,
                                              fontweight: FontWeight.w700,
                                              size: 18.sp,
                                            )),
                                  ],
                                );
                              }),
                        ),
                        SizedBox(
                          height: 946.h,
                          width: 1586.w,
                          child: ListView.builder(
                              itemCount: questionController.questionModelList.length,
                              padding: EdgeInsets.only(
                                left: 40.w,
                                right: 10.w,
                                top: 40.h,
                                bottom: 40.h,
                              ),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 24.h,
                                      child: ListView.builder(
                                          itemCount: 6,
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, i) {
                                            return Row(
                                              children: [
                                                i < 5
                                                    ? i == 0
                                                        ? Container(
                                                            width: 400.w,
                                                            height: 24.h,
                                                            margin: EdgeInsets.only(right: 40.w),
                                                            child: MyText(
                                                              txt: '${questionController.questionList[index][i]}',
                                                              color: secondColor,
                                                              fontweight: FontWeight.w800,
                                                              size: 18.sp,
                                                            ),
                                                          )
                                                        : Container(
                                                            width: 200.w,
                                                            height: 24.h,
                                                            margin: EdgeInsets.only(right: 40.w),
                                                            child: MyText(
                                                              txt: '${questionController.choicesList[index][i - 1]}',
                                                              color: secondColor,
                                                              fontweight: FontWeight.w800,
                                                              size: 18.sp,
                                                            ),
                                                          )
                                                    : Container(
                                                        width: 120.w,
                                                        height: 24.h,
                                                        margin: EdgeInsets.only(right: 50.w),
                                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                          InkWell(
                                                            onTap: () async {
                                                              questionController.question.text = questionController.questionList[index][0];
                                                              questionController.option1.text = questionController.choicesList[index][0];
                                                              questionController.option2.text = questionController.choicesList[index][1];
                                                              questionController.option3.text = questionController.choicesList[index][2];
                                                              questionController.option4.text = questionController.choicesList[index][3];
                                                              questionController.isEdit = true;
                                                              questionController.qid = questionController.questionList[index][1];
                                                              questionController.update();
                                                              await questionController.approveQuestion();
                                                            },
                                                            child: MyText(txt: 'Add', color: Color(0xff00C2FF), fontweight: FontWeight.w800, size: 16.sp),
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              questionController.qid = questionController.questionList[index][1];
                                                              questionController.update();
                                                              questionController.removeApprovedQuestion();
                                                              await questionController.getApprovedquestionByteacherEmail();
                                                              questionController.qid = '';
                                                              questionController.update();
                                                            },
                                                            child: MyText(txt: 'Delete', color: Color(0xffDF0808), fontweight: FontWeight.w800, size: 16.sp),
                                                          ),
                                                        ]),
                                                      ),
                                              ],
                                            );
                                          }),
                                    ),
                                    SizedBox(
                                      height: 36.h,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    )
                  ]);
                }));
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Center(child: CircularProgressIndicator())],
                );
              }
            }));
  }
}
