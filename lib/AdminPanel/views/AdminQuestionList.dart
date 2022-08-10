import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/AdminQuestionsListController.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/DashBoradController.dart';
import 'package:triviaadminpanal/AdminPanel/views/CustomWidgets/CustomAppbar.dart';

import '../../main.dart';
import '../Controllers/CategoryController.dart';
import 'CustomWidgets/MyText.dart';
import 'CustomWidgets/colorContainer.dart';
import 'components/style.dart';

class AdminQuestionList extends StatefulWidget {
  AdminQuestionList({Key? key}) : super(key: key);

  @override
  State<AdminQuestionList> createState() => _AdminQuestionListState();
}

class _AdminQuestionListState extends State<AdminQuestionList> {
  var controller = Get.put(AdminQuestionsListController());
  var dashboradCont = Get.put(DashboardController());
  var categroy = Get.find<CategoryController>();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   categroy.getCatForDropDown();
  // }

  @override
  Widget build(BuildContext context) {
    // print('email ${pref?.getString('email')}');
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
            future: controller.getquestion(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && dashboradCont.categoryList.length != 0) {
                return GetBuilder<AdminQuestionsListController>(builder: ((questionController) {
                  return Column(children: [
                    SizedBox(width: 1586.w, height: 70.h, child: CustomAppBar()),
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
                              itemCount: questionController.searchQuestion.length == 0 ? questionController.questionModelList.length : questionController.searchQuestion.length,
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
                                                            // MyText(
                                                            // txt: questionController.searchQuestion.length == 0
                                                            //     ? '${questionController.questionList[index][i]}'
                                                            //     : questionController.searchQuestion[index],
                                                            // color: secondColor,
                                                            // fontweight: FontWeight.w800,
                                                            // size: 18.sp,
                                                            // ),
                                                            SizedBox(
                                                              width: 360.w,
                                                              child: Text(
                                                                questionController.searchQuestion.length == 0
                                                                    ? '''${questionController.questionList[index][i]}'''
                                                                    : '''${questionController.searchQuestion[index]}''',
                                                                style: TextStyle(
                                                                  color: secondColor,
                                                                  fontWeight: FontWeight.w800,
                                                                  fontSize: 18.sp,
                                                                ),
                                                                overflow: TextOverflow.visible,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    : Container(
                                                        width: 160.w,
                                                        margin: EdgeInsets.only(right: 65.w),
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: 160.w,
                                                              child: Text(
                                                                questionController.searchQuestion.length == 0
                                                                    ? '''${questionController.choicesList[index][i - 1]}'''
                                                                    : '''${questionController.searchChoice[index][i - 1]}''',
                                                                style: TextStyle(
                                                                  color: secondColor,
                                                                  fontWeight: FontWeight.w800,
                                                                  fontSize: 18.sp,
                                                                ),
                                                                overflow: TextOverflow.visible,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                : Container(
                                                    width: 150.w,
                                                    height: 28.h,
                                                    margin: EdgeInsets.only(left: 20.w),
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
                                                          questionController.answer = questionController.questionList[index][2];
                                                          questionController.update();

                                                          dashboradCont.addQuestion = true;
                                                          dashboradCont.update();
                                                        },
                                                        child: MyText(txt: 'Edit', color: Color(0xff00C2FF), fontweight: FontWeight.w800, size: 16.sp),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          questionController.qid = questionController.questionList[index][1];
                                                          questionController.update();
                                                          questionController.removeQuestion();
                                                          await questionController.getquestion();
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
