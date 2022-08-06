import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/DashBoradController.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/TeacherController.dart';
import 'CustomWidgets/MyText.dart';
import 'CustomWidgets/colorContainer.dart';
import 'components/style.dart';

class Teacher extends StatefulWidget {
  Teacher({Key? key}) : super(key: key);

  @override
  State<Teacher> createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  var teaController = Get.put(TeacherController());
  // @override
  // initState() {
  //   super.initState();
  //   teaController.getTeacher();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
            future: teaController.getTeacher(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GetBuilder<TeacherController>(builder: ((controller) {
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
                                margin: EdgeInsets.zero,
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
                                      hintText: 'Search Teacher',
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
                              InkWell(
                                onTap: () {
                                  var dashboradCont = Get.put(DashboardController());
                                  dashboradCont.addTeachers = true;
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 900.h,
                              width: 850.w,
                              child: ListView.builder(
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  controller: ScrollController(),
                                  itemCount: controller.TeacherModelList.length,
                                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 36.h),
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
                                                            child: MyText(
                                                              txt: '${controller.teacherList[index][i]}',
                                                              color: secondColor,
                                                              fontweight: FontWeight.w800,
                                                              size: 16.sp,
                                                            ))
                                                        : Container(
                                                            width: 200.w,
                                                            margin: EdgeInsets.only(right: 50.w),
                                                            child: MyText(
                                                              txt: '${controller.teacherList[index][i]}',
                                                              color: secondColor,
                                                              fontweight: FontWeight.w800,
                                                              size: 16.sp,
                                                            ),
                                                          )
                                                    : Container(
                                                        width: 33.w,
                                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                          InkWell(
                                                            onTap: () {
                                                              controller.isTeacherEdit = true;
                                                              controller.email.text = controller.teacherList[index][0];
                                                              controller.password.text = controller.teacherList[index][1];
                                                              controller.tid = controller.teacherList[index][2];
                                                              controller.update();
                                                              var dashboradCont = Get.put(DashboardController());
                                                              dashboradCont.addTeachers = true;
                                                              dashboradCont.update();
                                                            },
                                                            child: MyText(txt: 'Edit', color: Color(0xff00C2FF), fontweight: FontWeight.w800, size: 16.sp),
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
