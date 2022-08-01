import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/QuestionsController.dart';

import '../../Controller/DashBoradController.dart';
import '../../Controller/EducationController.dart';
import '../CustomWidgets/MyText.dart';
import '../CustomWidgets/colorContainer.dart';
import '../components/style.dart';

class Chemistry extends StatefulWidget {
  Chemistry({Key? key}) : super(key: key);

  @override
  State<Chemistry> createState() => _ChemistryState();
}

class _ChemistryState extends State<Chemistry> {
  var controller = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
          future: controller.getquestionByCategory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GetBuilder<QuestionController>(builder: (questionController) {
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
                                              hintText: 'Select Category',
                                              hintStyle: TextStyle(color: hideColor, fontSize: 14.sp),
                                              suffixIcon: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: basicColor,
                                                size: 20.h,
                                              )),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 260.w,
                                      height: 30.h,
                                      margin: EdgeInsets.only(left: 48.w),
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
                                              hintText: 'Select Sub-Category',
                                              hintStyle: TextStyle(color: hideColor, fontSize: 14.sp),
                                              suffixIcon: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: basicColor,
                                                size: 20.h,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                var dashboradCont = Get.put(DashboardController());
                                dashboradCont.addQuestion = true;
                                dashboradCont.update();
                              },
                              child: colorContainer(
                                basicColor,
                                Center(
                                  child: MyText(
                                    txt: 'Add',
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
                                                  : EdgeInsets.only(right: 50.w),
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
                            itemCount: questionController.teacherQuestionModelList.length,
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
                                                            txt: '${questionController.teacherQuestionList[index][i]}',
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
                                                            txt: '${questionController.teacherChoicesList[index][i - 1]}',
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
                                                          onTap: () {
                                                            questionController.question.text = questionController.teacherQuestionList[index][0];
                                                            questionController.option1.text = questionController.teacherChoicesList[index][0];
                                                            questionController.option2.text = questionController.teacherChoicesList[index][1];
                                                            questionController.option3.text = questionController.teacherChoicesList[index][2];
                                                            questionController.option4.text = questionController.teacherChoicesList[index][3];
                                                            questionController.isEdit = true;
                                                            questionController.qid = questionController.teacherQuestionList[index][1];
                                                            questionController.update();
                                                            var dashboradCont = Get.put(DashboardController());
                                                            dashboradCont.addQuestion = true;
                                                            dashboradCont.update();
                                                          },
                                                          child: MyText(txt: 'Edit', color: Color(0xff00C2FF), fontweight: FontWeight.w800, size: 16.sp),
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            questionController.qid = questionController.teacherQuestionList[index][1];
                                                            questionController.update();
                                                            questionController.removeQuestion();
                                                            await questionController.getquestionByCategory();
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
              });
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Center(child: CircularProgressIndicator())],
              );
            }
          }),
    );
  }
}
