import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/TeacherQuestionsListController.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/AdminQuestionsListController.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/DashBoradController.dart';

import 'CustomWidgets/MyText.dart';
import 'CustomWidgets/colorContainer.dart';
import 'components/style.dart';

class ApproveQuestionsList extends StatefulWidget {
  ApproveQuestionsList({Key? key}) : super(key: key);

  @override
  State<ApproveQuestionsList> createState() => _AddedQuestionsListState();
}

class _AddedQuestionsListState extends State<ApproveQuestionsList> {
  var controller = Get.put(TeacherQuestionContoller());
  var dashboradCont = Get.put(DashboardController());
  List<String> subcategoryList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
            future: controller.getquestionByteacherEmail(),
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
                              Row(
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
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 4.w, bottom: 10.h, top: 1.h),
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Search',
                                            hintStyle: TextStyle(color: hideColor, fontSize: 14.sp),
                                            suffixIcon: Icon(
                                              Icons.search,
                                              color: basicColor,
                                              size: 20.h,
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 217.w,
                                  ),
                                  GetBuilder<DashboardController>(builder: (dashcon) {
                                    return Row(
                                      children: [
                                        Container(
                                          width: 260.w,
                                          height: 31.h,
                                          margin: EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                              color: basicColor,
                                              width: 1.0,
                                            )),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 4.w, bottom: 10.h),
                                            child: DropdownButton(
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: basicColor,
                                                size: 20.h,
                                              ),
                                              underline: Container(),
                                              hint: Text(
                                                dashcon.category,
                                                style: TextStyle(
                                                  color: dashcon.category != 'Select Category' ? basicColor : hideColor,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              isExpanded: true,
                                              items: dashcon.mainHeading.map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (val) {
                                                dashcon.category = val.toString();
                                                if (val.toString() == 'Education') {
                                                  subcategoryList = dashcon.subjectsNameList;
                                                } else {
                                                  subcategoryList = dashcon.sportNameList;
                                                }
                                                dashcon.update();
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 260.w,
                                          height: 31.h,
                                          margin: EdgeInsets.only(left: 48.h),
                                          decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                              color: basicColor,
                                              width: 1.0,
                                            )),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 4.w, bottom: 10.h),
                                            child: DropdownButton(
                                              focusColor: Colors.transparent,
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: basicColor,
                                                size: 20.h,
                                              ),
                                              underline: Container(),
                                              hint: Text(
                                                dashcon.subCategory,
                                                style: TextStyle(
                                                  color: dashcon.subCategory != 'Select Sub-Category' ? basicColor : hideColor,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              isExpanded: true,
                                              items: subcategoryList.map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              onChanged: (val) {
                                                dashcon.subCategory = val.toString();
                                                dashcon.update();
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  })
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  dashboradCont.showTeacherQuestionsList = false;
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
