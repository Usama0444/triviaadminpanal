import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/QuestionsController.dart';

import '../../Controller/DashBoradController.dart';
import '../../Controller/EducationController.dart';
import '../CustomWidgets/MyText.dart';
import '../CustomWidgets/colorContainer.dart';
import '../components/style.dart';

class CustomAppBar extends StatefulWidget {
  CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _ScienceState();
}

class _ScienceState extends State<CustomAppBar> {
  var controller = Get.put(QuestionController());
  var dashboradCont = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Card(
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
                              icon: Container(
                                margin: EdgeInsets.only(bottom: 18.h, right: 15.w),
                                width: 12.w,
                                height: 7.75.h,
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: basicColor,
                                  // size: 20.h,
                                ),
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
                              items: dashboradCont.fillcat == 0
                                  ? ['', ''].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList()
                                  : dashcon.categoryList.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                              onChanged: (val) {
                                dashcon.category = val.toString();
                                dashcon.catIndex = dashcon.categoryList.indexOf(val.toString());
                                dashcon.subCategory = 'Select Sub-Category';
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
                              icon: Container(
                                margin: EdgeInsets.only(bottom: 18.h, right: 15.w),
                                width: 12.w,
                                height: 7.75.h,
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: basicColor,
                                  // size: 20.h,
                                ),
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
                              items: dashboradCont.fillcat == 0
                                  ? ['', ''].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList()
                                  : dashcon.subCategoryList[dashcon.catIndex].map((String value) {
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
                  if (dashboradCont.category != 'Select Category' && dashboradCont.subCategory != 'Select Sub-Category') {
                    dashboradCont.addQuestion = true;
                    dashboradCont.update();
                  } else {
                    Get.snackbar('Error', 'Please Select Category and SubCategory first');
                  }
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
    );
  }
}
