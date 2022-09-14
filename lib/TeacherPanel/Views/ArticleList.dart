import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Categories.dart';

import 'CustomWidgets/MyText.dart';
import 'components/style.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({Key? key}) : super(key: key);

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  var show = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  var hide = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];
  var optionNumber = [
    'a)',
    'b)',
    'c)',
    'd)',
  ];
  var option = [
    1,
    2,
    3,
    4,
  ];
  var isChecked = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
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
                      child: Image.asset('assets/triviaLogo.png'),
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
                          width: 60.w,
                          height: 42.h,
                          margin: EdgeInsets.only(
                            top: 10.h,
                            left: 20.w,
                          ),
                          child: MyText(txt: 'Draft', color: whiteColor, fontweight: FontWeight.w800, size: 22.sp),
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
                        91.w,
                        42.h,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 25.h,
                              child: FittedBox(
                                child: Icon(
                                  Icons.arrow_back,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 20.h,
                                child: MyText(
                                  txt: 'Back',
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
                      width: 60.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 29.h),
                      child: reusableInstance.buttons(
                        110.w,
                        43.h,
                        Container(
                          height: 20.h,
                          child: Center(
                            child: MyText(
                              txt: 'Upload',
                              color: whiteColor,
                              fontweight: FontWeight.w300,
                              size: 23.sp,
                            ),
                          ),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Color(0xffFAFAFA),
                child: Column(
                  children: [
                    Container(
                      width: 375.w,
                      height: 400.h,
                      child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                for (int i = 0; i < 7; i++) {
                                  hide[i] = true;
                                  show[i] = false;
                                }
                                setState(() {
                                  if (hide[index]) {
                                    hide[index] = false;
                                    show[index] = true;
                                  } else {
                                    hide[index] = true;
                                    show[index] = false;
                                  }
                                });
                                print(hide);
                                print(show);
                              },
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: hide[index],
                                    child: Container(
                                        width: 355.w,
                                        height: 60.h,
                                        margin: EdgeInsets.only(top: 14.h, left: 14.w, right: 14.w),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10.h),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 20.w, right: 10.w),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 50.w,
                                                    height: 50.h,
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Color(0xffF5F5F5),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(5.h),
                                                      child: Image.asset('assets/triviaLogo.png'),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 30.w,
                                                  ),
                                                  MyText(
                                                    txt: 'Education',
                                                    color: drawerColor,
                                                    fontweight: FontWeight.w300,
                                                    size: 14.sp,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  MyText(
                                                    txt: '500',
                                                    color: Colors.black,
                                                    fontweight: FontWeight.w300,
                                                    size: 14.sp,
                                                  ),
                                                  SizedBox(
                                                    width: 20.w,
                                                  ),
                                                  Icon(
                                                    Icons.expand_more,
                                                    size: 25.sp,
                                                    color: basicColor,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                  Visibility(
                                      visible: show[index],
                                      child: Container(
                                        width: 375.w,
                                        height: 400.h,
                                        color: Color(0xffC4C4C4),
                                        child: ListView.builder(
                                            itemCount: 5,
                                            itemBuilder: (context, j) {
                                              return InkWell(
                                                onTap: () {
                                                  if (j != 0) {
                                                    setState(() {
                                                      if (hide[index]) {
                                                        hide[index] = true;
                                                        show[index] = false;
                                                      } else {
                                                        hide[index] = false;
                                                        show[index] = true;
                                                      }
                                                    });
                                                  } else {
                                                    setState(() {
                                                      if (hide[index]) {
                                                        hide[index] = false;
                                                        show[index] = true;
                                                      } else {
                                                        hide[index] = true;
                                                        show[index] = false;
                                                      }
                                                    });
                                                  }
                                                  print(hide);
                                                  print(show);
                                                },
                                                child: Container(
                                                    width: 355.w,
                                                    height: 60.h,
                                                    margin: EdgeInsets.only(top: 14.h, left: 14.w, right: 14.w),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(10.h),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(left: 20.w, right: 10.w),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 50.w,
                                                                height: 50.h,
                                                                decoration: const BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: Color(0xffF5F5F5),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(5.h),
                                                                  child: Image.asset('assets/triviaLogo.png'),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 30.w,
                                                              ),
                                                              MyText(
                                                                txt: j != 0 ? 'Sports' : 'Education',
                                                                color: drawerColor,
                                                                fontweight: FontWeight.w300,
                                                                size: 14.sp,
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              MyText(
                                                                txt: '500',
                                                                color: Colors.black,
                                                                fontweight: FontWeight.w300,
                                                                size: 14.sp,
                                                              ),
                                                              SizedBox(
                                                                width: 10.w,
                                                              ),
                                                              Icon(
                                                                index != 0 ? Icons.arrow_forward_ios_outlined : Icons.expand_less,
                                                                size: index != 0 ? 17.sp : 25.sp,
                                                                color: basicColor,
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              );
                                            }),
                                      ))
                                ],
                              ),
                            );
                          }),
                    ),
                    Container(
                      width: 355.w,
                      height: 60.h,
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 40.h),
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.w, right: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.mail_outline_outlined, size: 40.h),
                                SizedBox(
                                  width: 10.w,
                                ),
                                SizedBox(width: 30.w),
                                MyText(
                                  txt: 'Draft',
                                  color: drawerColor,
                                  fontweight: FontWeight.w300,
                                  size: 14.sp,
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20.h,
                              color: basicColor,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: 1500.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 30.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  MyText(
                                    txt: 'Articles /',
                                    color: Colors.black,
                                    fontweight: FontWeight.w800,
                                    size: 25.sp,
                                  ),
                                  MyText(
                                    txt: ' Blogs',
                                    color: Colors.black,
                                    fontweight: FontWeight.w300,
                                    size: 25.sp,
                                  ),
                                ],
                              ),
                              MyText(
                                txt: '15 Articles',
                                color: basicColor,
                                fontweight: FontWeight.w500,
                                size: 20.sp,
                              ),
                            ],
                          ),
                        )),
                    SizedBox(height: 45.h),
                    SizedBox(
                      height: 882.h,
                      child: ListView.builder(
                        itemCount: 7,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 121.h,
                            margin: EdgeInsets.only(bottom: 29.h),
                            decoration: BoxDecoration(
                              color: cateContainerColor,
                            ),
                            child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                          txt: 'Article no : 01',
                                          color: Colors.black,
                                          fontweight: FontWeight.w800,
                                          size: 16.sp,
                                        ),
                                        MyText(
                                          txt: '25/3/2021',
                                          color: basicColor,
                                          fontweight: FontWeight.w800,
                                          size: 10.sp,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          overflow: TextOverflow.visible,
                                          '''here a question of maths which increase your knowledge here a question of maths which increaseyour knowledge here a question of maths which increase your knowledge here a question of mathswhich increase your knowladge here a question of maths which increase your knowladge',
''',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        MyText(
                                          txt: 'Copy',
                                          color: Color(0xff00D579),
                                          fontweight: FontWeight.w800,
                                          size: 20.sp,
                                        ),
                                        MyText(
                                          txt: 'Edit',
                                          color: Color(0xff2CB4B3),
                                          fontweight: FontWeight.w800,
                                          size: 20.sp,
                                        ),
                                        MyText(
                                          txt: 'Delete',
                                          color: Color(0xffFF0000),
                                          fontweight: FontWeight.w800,
                                          size: 20.sp,
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget myContainers(
    var label,
    var width,
    var height,
    var maXLine,
  ) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(top: 10.h),
      child: Stack(
        children: [
          Container(
            width: 54.w,
            height: 16.h,
            margin: EdgeInsets.only(left: 5.w),
            child: FittedBox(
              child: MyText(
                txt: label,
                color: hideColor,
                fontweight: FontWeight.normal,
                size: 12.sp,
              ),
            ),
          ),
          Container(
            width: width,
            height: height,
            margin: EdgeInsets.only(left: 5.w),
            child: TextField(
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
              maxLength: label == 'Question' ? 40 : 30,
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
