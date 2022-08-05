import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/DashBoradController.dart';
import 'package:triviaadminpanal/AdminPanel/views/MyDrawer.dart';
import 'package:triviaadminpanal/AdminPanel/views/components/string.dart';
import 'package:triviaadminpanal/AdminPanel/views/components/style.dart';

import '../Controllers/CategoryController.dart';
import 'CustomWidgets/MyText.dart';

class UserDashboard extends StatefulWidget {
  UserDashboard({Key? key}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  var controller = Get.put(DashboardController());
  var getCategory = Get.put(CategoryController());
  @override
  void initState() {
    super.initState();
    getCategory.getCatForDropDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<DashboardController>(
      builder: (controller) {
        return Container(
          width: 1542.w,
          height: 966.h,
          margin: EdgeInsets.only(top: 96.h, left: 22.w, right: 22.w),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Column(children: [
            Row(
              children: [
                MyContainers(
                  409.w,
                  280.h,
                  10,
                  50.h,
                  0,
                  'Users',
                  Container(
                    width: 150.w,
                    height: 127.h,
                    // color: hideColor,
                    margin: EdgeInsets.zero,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyText(
                          txt: '1.7M',
                          color: secondColor,
                          fontweight: FontWeight.bold,
                          size: 32.sp,
                        ),
                        MyText(
                          txt: '43 Countries',
                          color: secondColor,
                          fontweight: FontWeight.w600,
                          size: 20.sp,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          width: 150.w,
                          height: 25.h,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: DropdownButton(
                              hint: MyText(
                                txt: controller.userCountryList[0],
                                color: secondColor,
                                fontweight: FontWeight.w400,
                                size: 12.sp,
                              ),
                              iconEnabledColor: basicColor,
                              value: controller.selectedUserCountry,
                              icon: Container(
                                width: 8.w,
                                height: 5.17.h,
                                margin: EdgeInsets.only(right: 20.w, bottom: 20.h),
                                child: Icon(Icons.expand_more),
                              ),
                              elevation: 0,
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(20),
                              dropdownColor: whiteColor,
                              underline: Container(),
                              alignment: AlignmentDirectional.center,
                              style: TextStyle(color: secondColor),
                              onChanged: (newValue) {
                                // setState(() {
                                //   direction = newValue!;
                                // });
                                controller.selectedUserCountry = newValue.toString();
                                controller.update();
                              },
                              items: controller.userCountryList.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Container(
                          width: 150.w,
                          height: 1.h,
                          color: secondColor,
                          margin: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ),
                MyContainers(
                  409.w,
                  280.h,
                  0,
                  50.h,
                  0,
                  winingAvg,
                  Container(
                    width: 150.w,
                    height: 127.h,
                    // color: hideColor,
                    margin: EdgeInsets.zero,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyText(
                          txt: '67%',
                          color: secondColor,
                          fontweight: FontWeight.bold,
                          size: 32.sp,
                        ),
                        MyText(
                          txt: '43 Countries',
                          color: secondColor,
                          fontweight: FontWeight.w600,
                          size: 20.sp,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          width: 150.w,
                          height: 25.h,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: DropdownButton(
                              hint: MyText(
                                txt: controller.AvgCountryList[0],
                                color: secondColor,
                                fontweight: FontWeight.w400,
                                size: 12.sp,
                              ),
                              iconEnabledColor: basicColor,
                              value: controller.selectedAvgCountry,
                              icon: Container(
                                width: 8.w,
                                height: 5.17.h,
                                margin: EdgeInsets.only(right: 20.w, bottom: 20.h),
                                child: Icon(Icons.expand_more),
                              ),
                              elevation: 0,
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(20),
                              dropdownColor: whiteColor,
                              underline: Container(),
                              alignment: AlignmentDirectional.center,
                              style: TextStyle(color: secondColor),
                              onChanged: (newValue) {
                                // setState(() {
                                //   direction = newValue!;
                                // });
                                controller.selectedAvgCountry = newValue.toString();
                                controller.update();
                              },
                              items: controller.AvgCountryList.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Container(
                          width: 150.w,
                          height: 1.h,
                          color: secondColor,
                          margin: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ),
                MyContainers(
                  724.w,
                  280.h,
                  0,
                  50.h,
                  10,
                  'Totals',
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20.h,
                      left: 109.w,
                      right: 109.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 115.w,
                          height: 80.h,
                          margin: EdgeInsets.zero,
                          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                            MyText(
                              txt: '12',
                              color: secondColor,
                              fontweight: FontWeight.bold,
                              size: 32.sp,
                            ),
                            MyText(
                              txt: 'Categories',
                              color: secondColor,
                              fontweight: FontWeight.w600,
                              size: 20.sp,
                            ),
                          ]),
                        ),
                        Container(
                          width: 148.w,
                          height: 80.h,
                          margin: EdgeInsets.zero,
                          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                            MyText(
                              txt: '44',
                              color: secondColor,
                              fontweight: FontWeight.bold,
                              size: 32.sp,
                            ),
                            MyText(
                              txt: 'Sub-Categories',
                              color: secondColor,
                              fontweight: FontWeight.w600,
                              size: 20.sp,
                            ),
                          ]),
                        ),
                        Container(
                          width: 115.w,
                          height: 80.h,
                          margin: EdgeInsets.zero,
                          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                            MyText(
                              txt: '9K',
                              color: secondColor,
                              fontweight: FontWeight.bold,
                              size: 32.sp,
                            ),
                            MyText(
                              txt: 'Questions',
                              color: secondColor,
                              fontweight: FontWeight.w600,
                              size: 20.sp,
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                MyContainers(
                  409.w,
                  686.h,
                  10,
                  10.h,
                  0,
                  worldRank,
                  Container(
                    width: 380.w,
                    height: 500.h,
                    margin: EdgeInsets.zero,
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 18.w),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: MyText(
                                      txt: controller.position[index],
                                      color: secondColor,
                                      fontweight: FontWeight.w400,
                                      size: 18.sp,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: MyText(
                                      txt: controller.nameList[index],
                                      color: secondColor,
                                      fontweight: FontWeight.w400,
                                      size: 18.sp,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: MyText(
                                      txt: controller.numberList[index],
                                      color: secondColor,
                                      fontweight: FontWeight.w400,
                                      size: 18.sp,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: MyText(
                                      txt: controller.lWeeklycountryList[index],
                                      color: secondColor,
                                      fontweight: FontWeight.w400,
                                      size: 18.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                            ],
                          );
                        }),
                  ),
                ),
                MyContainers(
                  409.w,
                  686.h,
                  0,
                  10.h,
                  0,
                  leaderWek,
                  Container(
                    width: 380.w,
                    height: 500.h,
                    margin: EdgeInsets.zero,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                txt: '43 Countries',
                                color: secondColor,
                                fontweight: FontWeight.w600,
                                size: 20.sp,
                              ),
                              // SizedBox(
                              //   width: 10.h,
                              // ),
                              SizedBox(
                                width: 150.w,
                                height: 25.h,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: DropdownButton(
                                    hint: MyText(
                                      txt: controller.lWeeklycountryList[0],
                                      color: secondColor,
                                      fontweight: FontWeight.w400,
                                      size: 12.sp,
                                    ),
                                    iconEnabledColor: basicColor,
                                    value: controller.selectedWeekCountry,
                                    icon: Container(
                                      width: 8.w,
                                      height: 5.17.h,
                                      margin: EdgeInsets.only(right: 20.w, bottom: 20.h),
                                      child: Icon(Icons.expand_more),
                                    ),
                                    elevation: 0,
                                    isExpanded: true,
                                    borderRadius: BorderRadius.circular(20.h),
                                    dropdownColor: whiteColor,
                                    underline: Container(),
                                    alignment: AlignmentDirectional.center,
                                    style: TextStyle(color: secondColor),
                                    onChanged: (newValue) {
                                      // setState(() {
                                      //   direction = newValue!;
                                      // });
                                      controller.selectedWeekCountry = newValue.toString();
                                      controller.update();
                                    },
                                    items: controller.lWeeklycountryList.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 150.w,
                          height: 1.h,
                          color: secondColor,
                          margin: EdgeInsets.only(left: 190.w, top: 5.h),
                        ),
                        Container(
                          width: 380.w,
                          height: 450.h,
                          child: ListView.builder(
                              padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 18.w),
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: MyText(
                                            txt: controller.position[index],
                                            color: secondColor,
                                            fontweight: FontWeight.w400,
                                            size: 18.sp,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: MyText(
                                            txt: controller.nameList[index],
                                            color: secondColor,
                                            fontweight: FontWeight.w400,
                                            size: 18.sp,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: MyText(
                                            txt: controller.numberList[index],
                                            color: secondColor,
                                            fontweight: FontWeight.w400,
                                            size: 18.sp,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: MyText(
                                            txt: controller.lWeeklycountryList[index],
                                            color: secondColor,
                                            fontweight: FontWeight.w400,
                                            size: 18.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                MyContainers(
                  724.w,
                  686.h,
                  0,
                  10.h,
                  10.h,
                  leaderMon,
                  Container(
                    width: 380.w,
                    height: 500.h,
                    margin: EdgeInsets.only(right: 370.h),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                txt: '43 Countries',
                                color: secondColor,
                                fontweight: FontWeight.w600,
                                size: 20.sp,
                              ),
                              // SizedBox(
                              //   width: 10.h,
                              // ),
                              SizedBox(
                                width: 150.w,
                                height: 25.h,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: DropdownButton(
                                    hint: MyText(
                                      txt: controller.lWeeklycountryList[0],
                                      color: secondColor,
                                      fontweight: FontWeight.w400,
                                      size: 12.sp,
                                    ),
                                    iconEnabledColor: basicColor,
                                    value: controller.selectedMonthCountry,
                                    icon: Container(
                                      width: 8.w,
                                      height: 5.17.h,
                                      margin: EdgeInsets.only(right: 20.w, bottom: 20.h),
                                      child: Icon(Icons.expand_more),
                                    ),
                                    elevation: 0,
                                    isExpanded: true,
                                    borderRadius: BorderRadius.circular(20),
                                    dropdownColor: whiteColor,
                                    underline: Container(),
                                    alignment: AlignmentDirectional.center,
                                    style: TextStyle(color: secondColor),
                                    onChanged: (newValue) {
                                      // setState(() {
                                      //   direction = newValue!;
                                      // });
                                      controller.selectedMonthCountry = newValue.toString();
                                      controller.update();
                                    },
                                    items: controller.lMonthlycountryList.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 150.w,
                          height: 1.h,
                          color: secondColor,
                          margin: EdgeInsets.only(left: 190.w, top: 5.h),
                        ),
                        Container(
                          width: 380.w,
                          height: 450.h,
                          child: ListView.builder(
                              padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 18.w),
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: MyText(
                                            txt: controller.position[index],
                                            color: secondColor,
                                            fontweight: FontWeight.w400,
                                            size: 18.sp,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: MyText(
                                            txt: controller.nameList[index],
                                            color: secondColor,
                                            fontweight: FontWeight.w400,
                                            size: 18.sp,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: MyText(
                                            txt: controller.numberList[index],
                                            color: secondColor,
                                            fontweight: FontWeight.w400,
                                            size: 18.sp,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: MyText(
                                            txt: controller.lMonthlycountryList[index],
                                            color: secondColor,
                                            fontweight: FontWeight.w400,
                                            size: 18.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ]),
        );
      },
    ));
  }
}

Widget MyContainers(
  width,
  height,
  radius,
  centerSized,
  rightRadius,
  AppBarHeading,
  CenterWidget,
) {
  return GetBuilder<DashboardController>(builder: ((controller) {
    return Container(
      width: width,
      height: height,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 50.h,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                bottomLeft: Radius.circular(radius),
                topRight: Radius.circular(rightRadius),
                bottomRight: Radius.circular(rightRadius),
              ),
              border: Border.all(color: basicColor, width: 1.h),
              color: basicColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
              child: MyText(
                txt: AppBarHeading,
                color: whiteColor,
                fontweight: FontWeight.w500,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(
            height: centerSized,
          ),
          CenterWidget,
          SizedBox(
            height: 47.h,
          ),
        ],
      ),
    );
  }));
}
