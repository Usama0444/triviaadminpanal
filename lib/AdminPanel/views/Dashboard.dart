import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/CategoryController.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/DashBoradController.dart';
import 'package:triviaadminpanal/AdminPanel/views/CustomWidgets/MyContainer.dart';
import 'package:triviaadminpanal/AdminPanel/views/CustomWidgets/MyText.dart';
import 'package:triviaadminpanal/AdminPanel/views/components/string.dart';
import 'package:triviaadminpanal/AdminPanel/views/components/style.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var dashboardCont = Get.put(DashboardController());
  var getCategory = Get.put(CategoryController());
  @override
  void initState() {
    super.initState();
    getCategory.getCatForDropDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DashboardController>(builder: ((controller) {
        return Column(children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 403.w,
              vertical: 325.h,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyContainer(
                        240.w,
                        200.h,
                        10.h,
                        Column(
                          children: [
                            SizedBox(
                              height: 57.h,
                            ),
                            MyText(
                              txt: '1.7M',
                              color: secondColor,
                              fontweight: FontWeight.bold,
                              size: 32.sp,
                            ),
                            MyText(
                              txt: users,
                              color: basicColor,
                              fontweight: FontWeight.bold,
                              size: 16.sp,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.w,
                                right: 10.w,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: MyText(
                                      txt: '43 Countries',
                                      color: secondColor,
                                      fontweight: FontWeight.normal,
                                      size: 12.sp,
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: 81.w,
                                      height: 45.h,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(color: basicColor, width: 1.0)),
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Expanded(
                                              child: DropdownButton(
                                                hint: MyText(
                                                  txt: controller.countryList[0],
                                                  color: secondColor,
                                                  fontweight: FontWeight.normal,
                                                  size: 12.sp,
                                                ),
                                                iconEnabledColor: basicColor,
                                                value: controller.selectedCountry,
                                                icon: Icon(Icons.expand_more),
                                                elevation: 0,
                                                isExpanded: true,
                                                borderRadius: BorderRadius.circular(20),
                                                dropdownColor: whiteColor,
                                                underline: Container(
                                                  margin: EdgeInsets.zero,
                                                ),
                                                alignment: AlignmentDirectional.center,
                                                style: TextStyle(color: secondColor),
                                                onChanged: (newValue) {
                                                  // setState(() {
                                                  //   direction = newValue!;
                                                  // });
                                                  controller.selectedCountry = newValue.toString();
                                                  controller.update();
                                                },
                                                items: controller.countryList.map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 14.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        )),
                    SizedBox(
                      width: 30.w,
                    ),
                    MyContainer(
                        240.w,
                        200.h,
                        10.h,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 50.h,
                            ),
                            MyText(
                              txt: '65%',
                              color: secondColor,
                              fontweight: FontWeight.bold,
                              size: 32.sp,
                            ),
                            MyText(
                              txt: winingAvg,
                              color: basicColor,
                              fontweight: FontWeight.bold,
                              size: 16.sp,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 10.w,
                                right: 10.w,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: MyText(
                                      txt: '43 Countries',
                                      color: secondColor,
                                      fontweight: FontWeight.normal,
                                      size: 12.sp,
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: 81.w,
                                      height: 45.h,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(color: basicColor, width: 1.0)),
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Expanded(
                                              child: DropdownButton(
                                                hint: MyText(
                                                  txt: controller.countryList[0],
                                                  color: secondColor,
                                                  fontweight: FontWeight.normal,
                                                  size: 14.sp,
                                                ),
                                                iconEnabledColor: basicColor,
                                                value: controller.selectedCountry,
                                                icon: Icon(Icons.expand_more),
                                                elevation: 0,
                                                isExpanded: true,
                                                borderRadius: BorderRadius.circular(20),
                                                dropdownColor: whiteColor,
                                                underline: Container(
                                                  margin: EdgeInsets.zero,
                                                ),
                                                alignment: AlignmentDirectional.center,
                                                style: TextStyle(color: secondColor),
                                                onChanged: (newValue) {
                                                  // setState(() {
                                                  //   direction = newValue!;
                                                  // });
                                                  controller.selectedCountry = newValue.toString();
                                                  controller.update();
                                                },
                                                items: controller.countryList.map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        )),
                    SizedBox(
                      width: 30.w,
                    ),
                    MyContainer(
                        240.w,
                        200.h,
                        10.h,
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(14.h),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                MyText(
                                                  txt: controller.totalString[index],
                                                  color: secondColor,
                                                  fontweight: FontWeight.normal,
                                                  size: 10.sp,
                                                ),
                                                MyText(
                                                  txt: '${controller.totalNumber[index]}',
                                                  color: secondColor,
                                                  fontweight: FontWeight.normal,
                                                  size: 10.sp,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    })),
                            MyText(
                              txt: total,
                              color: basicColor,
                              fontweight: FontWeight.bold,
                              size: 16.sp,
                            ),
                            SizedBox(
                              height: 19.h,
                            ),
                          ],
                        )),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyContainer(
                        240.w,
                        200.h,
                        10.h,
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                flex: 3,
                                child: ListView.builder(
                                    padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 18.w),
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              MyText(
                                                txt: controller.position[index],
                                                color: hideColor,
                                                fontweight: FontWeight.normal,
                                                size: 10.sp,
                                              ),
                                              MyText(
                                                txt: controller.nameList[index],
                                                color: secondColor,
                                                fontweight: FontWeight.normal,
                                                size: 10.sp,
                                              ),
                                              MyText(
                                                txt: controller.numberList[index],
                                                color: hideColor,
                                                fontweight: FontWeight.normal,
                                                size: 10.sp,
                                              ),
                                              MyText(
                                                txt: controller.countryList[index],
                                                color: secondColor,
                                                fontweight: FontWeight.normal,
                                                size: 10.sp,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                        ],
                                      );
                                    })),
                            Expanded(
                              flex: 1,
                              child: MyText(
                                txt: worldRank,
                                color: basicColor,
                                fontweight: FontWeight.bold,
                                size: 16.sp,
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      width: 30.w,
                    ),
                    MyContainer(
                        240.w,
                        200.h,
                        10.h,
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                flex: 2,
                                child: ListView.builder(
                                    padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 18.w),
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              MyText(
                                                txt: controller.position[index],
                                                color: hideColor,
                                                fontweight: FontWeight.normal,
                                                size: 10.sp,
                                              ),
                                              MyText(
                                                txt: controller.nameList[index],
                                                color: secondColor,
                                                fontweight: FontWeight.normal,
                                                size: 10.sp,
                                              ),
                                              MyText(
                                                txt: controller.numberList[index],
                                                color: hideColor,
                                                fontweight: FontWeight.normal,
                                                size: 10.sp,
                                              ),
                                              MyText(
                                                txt: controller.countryList[index],
                                                color: secondColor,
                                                fontweight: FontWeight.normal,
                                                size: 10.sp,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                        ],
                                      );
                                    })),
                            Expanded(
                              flex: 1,
                              child: MyText(
                                txt: leaderWek,
                                color: basicColor,
                                fontweight: FontWeight.bold,
                                size: 16.sp,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: MyText(
                                      txt: '43 Countries',
                                      color: secondColor,
                                      fontweight: FontWeight.normal,
                                      size: 12.sp,
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: 81.w,
                                      height: 45.h,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(color: basicColor, width: 1.0)),
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Expanded(
                                              child: DropdownButton(
                                                hint: MyText(
                                                  txt: controller.countryList[0],
                                                  color: secondColor,
                                                  fontweight: FontWeight.normal,
                                                  size: 14.sp,
                                                ),
                                                iconEnabledColor: basicColor,
                                                value: controller.selectedCountry,
                                                icon: Icon(Icons.expand_more),
                                                elevation: 0,
                                                isExpanded: true,
                                                borderRadius: BorderRadius.circular(20),
                                                dropdownColor: whiteColor,
                                                underline: Container(
                                                  margin: EdgeInsets.zero,
                                                ),
                                                alignment: AlignmentDirectional.center,
                                                style: TextStyle(color: secondColor),
                                                onChanged: (newValue) {
                                                  // setState(() {
                                                  //   direction = newValue!;
                                                  // });
                                                  controller.selectedCountry = newValue.toString();
                                                  controller.update();
                                                },
                                                items: controller.countryList.map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      width: 30.w,
                    ),
                    MyContainer(
                        240.w,
                        200.h,
                        10.h,
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                flex: 2,
                                child: ListView.builder(
                                    padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 18.w),
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              MyText(
                                                txt: controller.position[index],
                                                color: hideColor,
                                                fontweight: FontWeight.normal,
                                                size: 10.sp,
                                              ),
                                              MyText(
                                                txt: controller.nameList[index],
                                                color: secondColor,
                                                fontweight: FontWeight.normal,
                                                size: 10.sp,
                                              ),
                                              MyText(
                                                txt: controller.numberList[index],
                                                color: hideColor,
                                                fontweight: FontWeight.normal,
                                                size: 10.sp,
                                              ),
                                              MyText(
                                                txt: controller.countryList[index],
                                                color: secondColor,
                                                fontweight: FontWeight.normal,
                                                size: 10.sp,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                        ],
                                      );
                                    })),
                            Expanded(
                              flex: 1,
                              child: MyText(
                                txt: leaderMon,
                                color: basicColor,
                                fontweight: FontWeight.bold,
                                size: 16.sp,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: MyText(
                                      txt: '43 Countries',
                                      color: secondColor,
                                      fontweight: FontWeight.normal,
                                      size: 12.sp,
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: 81.w,
                                      height: 45.h,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(color: basicColor, width: 1.0)),
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20.w,
                                            ),
                                            Expanded(
                                              child: DropdownButton(
                                                hint: MyText(
                                                  txt: controller.countryList[0],
                                                  color: secondColor,
                                                  fontweight: FontWeight.normal,
                                                  size: 14.sp,
                                                ),
                                                iconEnabledColor: basicColor,
                                                value: controller.selectedCountry,
                                                icon: Icon(Icons.expand_more),
                                                elevation: 0,
                                                isExpanded: true,
                                                borderRadius: BorderRadius.circular(20),
                                                dropdownColor: whiteColor,
                                                underline: Container(
                                                  margin: EdgeInsets.zero,
                                                ),
                                                alignment: AlignmentDirectional.center,
                                                style: TextStyle(color: secondColor),
                                                onChanged: (newValue) {
                                                  // setState(() {
                                                  //   direction = newValue!;
                                                  // });
                                                  controller.selectedCountry = newValue.toString();
                                                  controller.update();
                                                },
                                                items: controller.countryList.map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          )
        ]);
      })),
    );
  }
}
