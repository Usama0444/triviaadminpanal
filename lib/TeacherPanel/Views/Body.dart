import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/DashBoradController.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/QuestionsController.dart';
import 'package:triviaadminpanal/main.dart';
import 'CustomWidgets/CustomAppBar.dart';
import 'CustomWidgets/MyText.dart';
import 'components/style.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _CircketState();
}

class _CircketState extends State<Body> {
  var controller = Get.put(QuestionController());
  List<String> subcategoryList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('teacher email ${pref?.getString('teacheremail')}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(children: [
        SizedBox(
          width: 1586.w,
          height: 70.h,
          child: CustomAppBar(),
        ),
        FutureBuilder(
            future: controller.getquestionByCategory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GetBuilder<QuestionController>(builder: (questionController) {
                  return Column(
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
                            itemCount: questionController.teacherQuestionModelList.length,
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
                                                              txt: '${questionController.teacherQuestionList[index][i]}',
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
                                                              txt: '${questionController.teacherChoicesList[index][i - 1]}',
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
                                                        questionController.answer = questionController.teacherQuestionList[index][2];
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
                              );
                            }),
                      ),
                    ],
                  );
                });
              } else {
                return SizedBox(
                  height: 900.h,
                  width: 1500.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Center(child: CircularProgressIndicator())],
                  ),
                );
              }
            })
      ]),
    );
  }
}
