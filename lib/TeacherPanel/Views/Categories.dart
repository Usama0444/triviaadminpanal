import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/AddQuestions.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/CustomWidgets/MyText.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/CustomWidgets/Reusable.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Draft.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/SubCategory.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/components/style.dart';

Reusable reusableInstance = Reusable();

class Categories extends StatelessWidget {
  Categories({Key? key}) : super(key: key);
  CategoryController cateController = Get.find<CategoryController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: 1920.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: headerColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 28.w,
                    ),
                    SizedBox(
                      width: 57.w,
                      height: 47.h,
                      child: SvgPicture.asset('assets/triviaLogo.svg'),
                    ),
                    Row(
                      children: [
                        MyText(
                          txt: 'Trivia ',
                          color: basicColor,
                          fontweight: FontWeight.bold,
                          size: 40.sp,
                        ),
                        MyText(
                          txt: 'star',
                          color: basicColor,
                          fontweight: FontWeight.w300,
                          size: 40.sp,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 51.h),
                          child: MyText(
                            txt: 'TEACHERS',
                            color: greyColor,
                            fontweight: FontWeight.w300,
                            size: 15.sp,
                          ),
                        ),
                        const VerticalDivider(
                          color: Color(0xff3B3B3B),
                        ),
                        Container(
                          width: 334.w,
                          height: 42.h,
                          margin: EdgeInsets.only(
                            top: 25.h,
                            left: 65.w,
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: greyColor,
                            width: 1.h,
                          ))),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 293.w,
                                child: TextField(
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: greyColor,
                                  ),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search',
                                      hintStyle: TextStyle(
                                        fontSize: 20.sp,
                                        color: greyColor,
                                      )),
                                ),
                              ),
                              SizedBox(
                                width: 41.w,
                                height: 41.w,
                                child: FittedBox(
                                  child: Icon(
                                    Icons.search,
                                    color: basicColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 29.h),
                      child: reusableInstance.buttons(
                        180.w,
                        42.h,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 20.w,
                              height: 20.h,
                              child: FittedBox(
                                child: Icon(
                                  Icons.add,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(AddQuestion());
                              },
                              child: Container(
                                height: 20.h,
                                child: MyText(
                                  txt: 'Add Question',
                                  color: whiteColor,
                                  fontweight: FontWeight.w300,
                                  size: 21.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 62.w,
                    ),
                    const VerticalDivider(
                      color: Color(0xff3B3B3B),
                    ),
                    SizedBox(
                      width: 28.w,
                    ),
                    Container(
                      width: 38.w,
                      height: 38.w,
                      child: FittedBox(
                        child: Icon(
                          Icons.power_settings_new,
                          color: basicColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25.w,
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 41.h,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cateController.cateHeader.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                          left: index != 0
                              ? index == 3
                                  ? 1075.w
                                  : 120.w
                              : 40.w,
                        ),
                        child: MyText(
                          txt: cateController.cateHeader[index],
                          color: index != 3 ? Colors.black : basicColor,
                          fontweight: FontWeight.w500,
                          size: 20.sp,
                        ),
                      );
                    }),
              ),
              SizedBox(height: 50.h),
              Row(
                children: [
                  SizedBox(
                    width: 1345.w,
                    height: 882.h,
                    child: ListView.builder(
                        itemCount: cateController.cateNameList.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 63.h,
                            margin: EdgeInsets.only(bottom: 50.h),
                            decoration: BoxDecoration(
                              color: cateContainerColor,
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Container(
                                      width: 60.w,
                                      height: 60.w,
                                      margin: EdgeInsets.only(left: 40.w),
                                      decoration: const BoxDecoration(
                                        color: Color(0xffF5F5F5),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Container(
                                        width: 40.w,
                                        height: 40.h,
                                        margin: EdgeInsets.all(5.h),
                                        child: SvgPicture.asset('assets/triviaLogo.svg'),
                                      )),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: MyText(
                                            txt: cateController.cateNameList[index],
                                            color: Colors.black,
                                            fontweight: FontWeight.w500,
                                            size: 20.sp,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: MyText(
                                            txt: '${cateController.totalSubCate[index]}',
                                            color: Colors.black,
                                            fontweight: FontWeight.w500,
                                            size: 20.sp,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.to(SubCategory());
                                            },
                                            child: MyText(
                                              txt: 'View',
                                              color: basicColor,
                                              fontweight: FontWeight.w500,
                                              size: 20.sp,
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: Text(''),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Container(
                    width: 575.w,
                    height: 882.h,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        MyText(
                          txt: 'PROFILE',
                          color: Colors.black,
                          fontweight: FontWeight.w800,
                          size: 20.sp,
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Container(
                          width: 119.w,
                          height: 119.w,
                          decoration: BoxDecoration(
                            color: greyColor,
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/defaultPic.jpg',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        MyText(
                          txt: 'USAMA GHAFOOR',
                          color: Colors.black,
                          fontweight: FontWeight.w300,
                          size: 22.sp,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        MyText(
                          txt: 'TEACHER',
                          color: basicColor,
                          fontweight: FontWeight.w300,
                          size: 18.sp,
                        ),
                        Container(
                          width: 570.w,
                          height: 97.h,
                          margin: EdgeInsets.only(top: 85.h),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50.w),
                            child: InkWell(
                              onTap: () {
                                Get.to(Draft());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.mail_outline_outlined, size: 40.h),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      MyText(
                                        txt: 'Drafts',
                                        color: Colors.black,
                                        fontweight: FontWeight.w300,
                                        size: 20.sp,
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 25.h,
                                    color: basicColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
