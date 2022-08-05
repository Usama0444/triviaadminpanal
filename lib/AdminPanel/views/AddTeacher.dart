import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/DashBoradController.dart';

import '../Controllers/TeacherController.dart';
import 'CustomWidgets/MyText.dart';
import 'CustomWidgets/colorContainer.dart';
import 'components/string.dart';
import 'components/style.dart';

class AddTeachers extends StatefulWidget {
  AddTeachers({Key? key}) : super(key: key);

  @override
  State<AddTeachers> createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddTeachers> {
  var controller = Get.put(TeacherController());
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
                        txt: 'Add Teachers',
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
                            controller.isTeacherEdit = false;
                            controller.email.text = '';
                            controller.password.text = '';
                            controller.update();
                            var dashboradCont = Get.put(DashboardController());
                            dashboradCont.addTeachers = false;
                            dashboradCont.update();
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
                        InkWell(
                          onTap: () async {
                            if (controller.email.text.trim() == '' ||
                                !controller.email.text.contains('@gmail.com') ||
                                !controller.email.text.endsWith('com') ||
                                controller.email.text.length > 30 ||
                                controller.password.text.trim() == '') {
                              Get.snackbar('Error', 'Invalid Teacher data!');
                            } else if (controller.password.text.trim().length < 6) {
                              Get.snackbar('Error', 'password length must be greater than or equal to 6!');
                            } else {
                              if (controller.isTeacherEdit) {
                                await controller.updateTeacher(controller.email.text, controller.password.text);
                                await controller.getTeacher();
                                controller.isTeacherEdit = false;
                                controller.email.text = '';
                                controller.password.text = '';
                                controller.update();
                                var dashboradCont = Get.put(DashboardController());
                                dashboradCont.addTeachers = false;
                                dashboradCont.update();
                              } else {
                                await controller.addNewTeachers(controller.email.text, controller.password.text);
                                await controller.getTeacher();
                                controller.isTeacherEdit = false;
                                controller.email.text = '';
                                controller.password.text = '';
                                controller.update();
                                var dashboradCont = Get.put(DashboardController());
                                dashboradCont.addTeachers = false;
                                dashboradCont.update();
                              }
                            }
                          },
                          child: colorContainer(
                            basicColor,
                            Center(
                              child: MyText(
                                txt: controller.isTeacherEdit == true ? 'Update' : 'Save',
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
              MyCustomContainer(
                'Email',
                360.w,
                40.h,
                controller.email,
              ),
              MyCustomContainer(
                'Password',
                360.w,
                40.h,
                controller.password,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

Widget MyCustomContainer(var label, var width, var height, var controller) {
  return Container(
    width: width,
    height: height,
    margin: EdgeInsets.only(top: 20.h),
    decoration: BoxDecoration(
      border: Border.all(color: hideColor, width: 1.h),
    ),
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,
          hintStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
            color: hideColor,
          ),
        ),
      ),
    ),
  );
}
