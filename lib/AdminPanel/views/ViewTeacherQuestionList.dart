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
                          height: 28.h,
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
                                        ? Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width: 200.w,
                                                  margin: EdgeInsets.only(right: 20.w),
                                                  child: FittedBox(
                                                    child: MyText(
                                                      txt: controller.headingText[i],
                                                      color: hideColor,
                                                      fontweight: FontWeight.w700,
                                                      size: 18.sp,
                                                    ),
                                                  )),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width: i == 0 ? 360.w : 160.w,
                                                  margin: EdgeInsets.only(right: 65.w),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      FittedBox(
                                                        child: MyText(
                                                          txt: controller.headingText[i],
                                                          color: secondColor,
                                                          fontweight: FontWeight.w700,
                                                          size: 18.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                  ],
                                );
                              }),
                        ),
                        SizedBox(
                          height: 900.h,
                          width: 1586.w,
                          child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: ScrollController(),
                              itemCount: questionController.questionModelList.length,
                              padding: EdgeInsets.only(
                                left: 40.w,
                                right: 10.w,
                                top: 40.h,
                                bottom: 40.h,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: double.infinity,
                                  height: 28.h,
                                  margin: EdgeInsets.only(bottom: 36.h),
                                  child: ListView.builder(
                                      itemCount: 6,
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, i) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            i < 5
                                                ? i == 0
                                                    ? Container(
                                                        width: 360.w,
                                                        margin: EdgeInsets.only(right: 65.w),
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            FittedBox(
                                                              child: MyText(
                                                                txt: '${questionController.questionList[index][i]}',
                                                                color: secondColor,
                                                                fontweight: FontWeight.w800,
                                                                size: 18.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Container(
                                                        width: 160.w,
                                                        margin: EdgeInsets.only(right: 65.w),
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            FittedBox(
                                                              child: MyText(
                                                                txt: '${questionController.choicesList[index][i - 1]}',
                                                                color: secondColor,
                                                                fontweight: FontWeight.w800,
                                                                size: 18.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                : Container(
                                                    width: 150.w,
                                                    height: 28.h,
                                                    margin: EdgeInsets.only(left: 20.w),
                                                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                      InkWell(
                                                        onTap: () async {
                                                          questionController.qid = questionController.questionList[index][1];
                                                          questionController.update();
                                                          questionController.removeQuestion();
                                                          await questionController.getquestionByteacherEmail();
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
