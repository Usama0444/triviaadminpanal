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

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
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
  bool? isCorrect1 = null, isCorrect2 = null, isCorrect3 = null, isCorrect4 = null;
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
                          width: 60.w,
                          height: 42.h,
                          margin: EdgeInsets.only(
                            top: 10.h,
                            left: 20.w,
                          ),
                          child: MyText(txt: 'Add Questions', color: whiteColor, fontweight: FontWeight.w800, size: 22.sp),
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
                        100.w,
                        42.h,
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
                      width: 60.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 29.h),
                      child: reusableInstance.buttons(
                        86.w,
                        42.h,
                        Container(
                          height: 20.h,
                          child: Center(
                            child: MyText(
                              txt: 'Draft',
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
                width: 375.w,
                height: 924.h,
                color: Color(0xffFAFAFA),
                child: ListView.builder(
                    itemCount: 7,
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
                                                child: SvgPicture.asset('assets/triviaLogo.svg'),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            MyText(
                                              txt: 'Education',
                                              color: Colors.black,
                                              fontweight: FontWeight.w600,
                                              size: 14.sp,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            MyText(
                                              txt: '500',
                                              color: Colors.black,
                                              fontweight: FontWeight.w600,
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
                                                            child: SvgPicture.asset('assets/triviaLogo.svg'),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        MyText(
                                                          txt: j != 0 ? 'Sports' : 'Education',
                                                          color: Colors.black,
                                                          fontweight: FontWeight.w600,
                                                          size: 14.sp,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        MyText(
                                                          txt: '500',
                                                          color: Colors.black,
                                                          fontweight: FontWeight.w600,
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
              SizedBox(
                width: 40.w,
              ),
              Column(
                children: [
                  reusableInstance.inputBox(740.w, 80.h, greyColor, myContainers('Question', 740.w, 80.h, 2)),
                  SizedBox(
                    height: 20.w,
                  ),
                  Row(
                    children: [
                      reusableInstance.inputBox(360.w, 60.h, greyColor, myContainers('Option 1', 740.w, 80.h, 2)),
                      SizedBox(
                        width: 20.w,
                      ),
                      reusableInstance.inputBox(360.w, 60.h, greyColor, myContainers('Option 2', 740.w, 80.h, 2))
                    ],
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isCorrect1 = true;
                            isCorrect2 = false;
                            isCorrect3 = false;
                            isCorrect4 = false;
                          });
                        },
                        child: Container(
                          width: 360.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isCorrect1 != null && isCorrect1 == false ? Color(0xffFF0000) : Color(0xff50A89F),
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: isCorrect1 != null && isCorrect1 == false
                                    ? Colors.white
                                    : isCorrect1 == true
                                        ? Colors.white
                                        : greyColor.withOpacity(1.0),
                                offset: Offset(
                                  3.0,
                                  3.0,
                                ),
                                blurRadius: 1.0,
                                spreadRadius: -2.0,
                              )
                            ],
                            color: isCorrect1 == true ? Color(0xff00D579) : Colors.white,
                          ),
                          child: Center(
                            child: MyText(
                              txt: isCorrect1 != null && isCorrect1 == false
                                  ? 'wrong answer'
                                  : isCorrect1 == true
                                      ? 'correct answer'
                                      : 'Select if this a correct answer',
                              color: isCorrect1 != null && isCorrect1 == false
                                  ? Colors.red
                                  : isCorrect1 == true
                                      ? Colors.white
                                      : Colors.green,
                              fontweight: FontWeight.w300,
                              size: 12.sp,
                            ),

                            // Text('Select if this a correct answer'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isCorrect1 = false;
                            isCorrect2 = true;
                            isCorrect3 = false;
                            isCorrect4 = false;
                          });
                        },
                        child: Container(
                          width: 360.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isCorrect2 != null && isCorrect2 == false ? Color(0xffFF0000) : Color(0xff50A89F),
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: isCorrect2 != null && isCorrect2 == false
                                    ? Colors.white
                                    : isCorrect2 == true
                                        ? Colors.white
                                        : greyColor.withOpacity(1.0),
                                offset: Offset(
                                  3.0,
                                  3.0,
                                ),
                                blurRadius: 1.0,
                                spreadRadius: -2.0,
                              )
                            ],
                            color: isCorrect2 == true ? Color(0xff00D579) : Colors.white,
                          ),
                          child: Center(
                            child: MyText(
                              txt: isCorrect2 != null && isCorrect2 == false
                                  ? 'wrong answer'
                                  : isCorrect2 == true
                                      ? 'correct answer'
                                      : 'Select if this a correct answer',
                              color: isCorrect2 != null && isCorrect2 == false
                                  ? Colors.red
                                  : isCorrect2 == true
                                      ? Colors.white
                                      : Colors.green,
                              fontweight: FontWeight.w300,
                              size: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  Row(
                    children: [
                      reusableInstance.inputBox(360.w, 60.h, greyColor, myContainers('Option 3', 740.w, 80.h, 2)),
                      SizedBox(
                        width: 20.w,
                      ),
                      reusableInstance.inputBox(360.w, 60.h, greyColor, myContainers('Option 4', 740.w, 80.h, 2))
                    ],
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isCorrect1 = false;
                            isCorrect2 = false;
                            isCorrect3 = true;
                            isCorrect4 = false;
                          });
                        },
                        child: Container(
                          width: 360.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isCorrect3 != null && isCorrect3 == false ? Color(0xffFF0000) : Color(0xff50A89F),
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: isCorrect3 != null && isCorrect3 == false
                                    ? Colors.white
                                    : isCorrect2 == true
                                        ? Colors.white
                                        : greyColor.withOpacity(1.0),
                                offset: Offset(
                                  3.0,
                                  3.0,
                                ),
                                blurRadius: 1.0,
                                spreadRadius: -2.0,
                              )
                            ],
                            color: isCorrect3 == true ? Color(0xff00D579) : Colors.white,
                          ),
                          child: Center(
                            child: MyText(
                              txt: isCorrect3 != null && isCorrect3 == false
                                  ? 'wrong answer'
                                  : isCorrect3 == true
                                      ? 'correct answer'
                                      : 'Select if this a correct answer',
                              color: isCorrect3 != null && isCorrect3 == false
                                  ? Colors.red
                                  : isCorrect3 == true
                                      ? Colors.white
                                      : Colors.green,
                              fontweight: FontWeight.w300,
                              size: 12.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isCorrect1 = false;
                            isCorrect2 = false;
                            isCorrect3 = false;
                            isCorrect4 = true;
                          });
                        },
                        child: Container(
                          width: 360.w,
                          height: 60.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isCorrect4 != null && isCorrect4 == false ? Color(0xffFF0000) : Color(0xff50A89F),
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: isCorrect4 != null && isCorrect4 == false
                                    ? Colors.white
                                    : isCorrect4 == true
                                        ? Colors.white
                                        : greyColor.withOpacity(1.0),
                                offset: Offset(
                                  3.0,
                                  3.0,
                                ),
                                blurRadius: 1.0,
                                spreadRadius: -2.0,
                              )
                            ],
                            color: isCorrect4 == true ? Color(0xff00D579) : Colors.white,
                          ),
                          child: Center(
                            child: MyText(
                              txt: isCorrect4 != null && isCorrect4 == false
                                  ? 'wrong answer'
                                  : isCorrect4 == true
                                      ? 'correct answer'
                                      : 'Select if this a correct answer',
                              color: isCorrect4 != null && isCorrect4 == false
                                  ? Colors.red
                                  : isCorrect4 == true
                                      ? Colors.white
                                      : Colors.green,
                              fontweight: FontWeight.w300,
                              size: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.w,
                  ),
                  reusableInstance.inputBox(
                      740.w,
                      500.h,
                      greyColor,
                      Stack(
                        children: [
                          Container(
                            width: 740,
                            height: 500.h,
                          ),
                          Positioned(
                            top: 0,
                            child: Padding(
                              padding: EdgeInsets.all(10.w),
                              child: Container(
                                width: 720.w,
                                margin: EdgeInsets.zero,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyText(txt: 'Article/Description', color: Colors.black, fontweight: FontWeight.bold, size: 15.sp),
                                    MyText(txt: '0/500', color: Colors.black, fontweight: FontWeight.w300, size: 15.sp),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20.h,
                            left: 10.w,
                            child: Container(
                              width: 700.w,
                              height: 400.h,
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 200,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20.w,
                  ),
                ],
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
