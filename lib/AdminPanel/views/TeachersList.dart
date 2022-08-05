import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/AdminQuestionsListController.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/TeacherQuestionsListController.dart';
import 'package:triviaadminpanal/AdminPanel/views/CustomWidgets/CustomAppbar.dart';
import 'package:triviaadminpanal/AdminPanel/views/components/string.dart';

import '../Controllers/DashBoradController.dart';
import '../Controllers/TeacherController.dart';
import 'CustomWidgets/MyText.dart';
import 'components/style.dart';

class ApproveTeacherQuestionsList extends StatefulWidget {
  ApproveTeacherQuestionsList({Key? key}) : super(key: key);

  @override
  State<ApproveTeacherQuestionsList> createState() => _ApproveQuestionsListState();
}

class _ApproveQuestionsListState extends State<ApproveTeacherQuestionsList> {
  var controller = Get.put(AdminQuestionsListController());
  var teacherQuestion = Get.put(TeacherQuestionContoller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        body: FutureBuilder(
            future: controller.getTeachers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GetBuilder<TeacherController>(builder: ((teacherController) {
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
                                ],
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
                              itemCount: 3,
                              padding: EdgeInsets.symmetric(horizontal: 40.w),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) {
                                return Row(
                                  children: [
                                    Container(
                                        width: 160.w,
                                        margin: i == 0
                                            ? EdgeInsets.only(right: 280.w)
                                            : i < 6
                                                ? EdgeInsets.only(right: 60.w)
                                                : EdgeInsets.only(right: 10.w),
                                        child: i == 5
                                            ? MyText(
                                                txt: controller.headingTxt[i],
                                                color: hideColor,
                                                fontweight: FontWeight.normal,
                                                size: 16.sp,
                                              )
                                            : MyText(
                                                txt: controller.headingTxt[i],
                                                color: secondColor,
                                                fontweight: FontWeight.w800,
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
                              itemCount: teacherController.teacherList.length,
                              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      height: 24.h,
                                      child: ListView.builder(
                                          itemCount: 3,
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, i) {
                                            return Row(
                                              children: [
                                                i < 2
                                                    ? i == 0
                                                        ? Container(
                                                            width: 400.w,
                                                            margin: EdgeInsets.only(right: 40.w),
                                                            child: MyText(txt: '${teacherController.teacherList[index][0]}', color: secondColor, fontweight: FontWeight.w800, size: 16.sp))
                                                        : Container(
                                                            width: 200.w,
                                                            margin: EdgeInsets.only(right: 50.w),
                                                            child: MyText(txt: '1500', color: secondColor, fontweight: FontWeight.w800, size: 16.sp),
                                                          )
                                                    : Container(
                                                        width: 42.w,
                                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                          InkWell(
                                                            onTap: () {
                                                              var dashboradCont = Get.put(DashboardController());
                                                              dashboradCont.showTeacherQuestionsList = true;
                                                              dashboradCont.teacherQuestionScreen = true;
                                                              dashboradCont.update();
                                                              teacherQuestion.teacherEmail = teacherController.teacherList[index][0];
                                                              teacherQuestion.update();
                                                            },
                                                            child: MyText(txt: 'View', color: Color(0xff00C2FF), fontweight: FontWeight.w800, size: 16.sp),
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
                    ),
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
