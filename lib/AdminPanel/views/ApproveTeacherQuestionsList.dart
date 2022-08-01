import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/ApproveQuestionsListController.dart';

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
  var controller = Get.put(ApproveQuestionsListController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getTeachers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: GetBuilder<TeacherController>(builder: ((teacherController) {
          return teacherController.teacherList.length == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Center(child: CircularProgressIndicator())],
                )
              : Column(children: [
                  SizedBox(
                    width: 1586.w,
                    height: 70.h,
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 40.w),
                        child: Row(
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
                            SizedBox(
                              width: 425.w,
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
                                                            dashboradCont.showApprovedList = true;
                                                            dashboradCont.update();
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
        })));
  }
}
