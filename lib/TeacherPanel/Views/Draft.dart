import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/ArticleList.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Categories.dart';

import '../Controller/CategoryController.dart';
import '../Controller/QuestionsController.dart';
import '../Services/LoginServices.dart';
import 'CustomWidgets/MyText.dart';
import 'LoginPage.dart';
import 'components/style.dart';

class Draft extends StatefulWidget {
  const Draft({Key? key}) : super(key: key);

  @override
  State<Draft> createState() => _DraftState();
}

class _DraftState extends State<Draft> {
  CategoryController catController = Get.find<CategoryController>();
  QuestionController questionController = Get.find<QuestionController>();

  var show = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
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
  var isChecked = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    catController.fillSubCategoryForDrawer().whenComplete(() async {
      setState(() {
        isLoading = false;
      });
    });
  }

  List<Color> highlight = [];
  bool isShowQuestionsList = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<QuestionController>(
          builder: (controller) {
            return Column(
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
                            child: InkWell(
                              onTap: () async {
                                for (int i = 0; i < isChecked.length; i++) {
                                  if (isChecked[i] == true) {
                                    questionController.draftCheckedIndex.add(i);
                                  }
                                }
                                questionController.update();
                                await questionController.uploadBtnClick();
                              },
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
                      child: Stack(
                        children: [
                          Container(
                            width: 375.w,
                            height: 924.h,
                            color: Color(0xffFAFAFA),
                            child: isLoading
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 200.h,
                                      ),
                                      Text('Loading...'),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      CircularProgressIndicator(),
                                    ],
                                  )
                                : ListView.builder(
                                    itemCount: catController.catList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          print(index);
                                          questionController.questionCategory = catController.catList[index].name;
                                          questionController.update();
                                          setState(() {
                                            for (int i = 0; i < 10; i++) {
                                              hide[i] = true;
                                              show[i] = false;
                                            }
                                            for (int i = 0; i < 10; i++) {
                                              highlight.add(Colors.white);
                                            }
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
                                                                child: Image.memory(base64Decode(catController.catList[index].image)),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            MyText(
                                                              txt: catController.catList[index].name,
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
                                                  height: (catController.subCategoriesForDrawer[index].length + 2) * 60.h,
                                                  color: Color(0xffC4C4C4),
                                                  child: ListView.builder(
                                                      itemCount: catController.subCategoriesForDrawer[index].length + 1,
                                                      itemBuilder: (context, j) {
                                                        return InkWell(
                                                          onTap: () async {
                                                            for (int i = 0; i < 10; i++) {
                                                              highlight[i] = whiteColor;
                                                            }
                                                            highlight[j] = Colors.green.withOpacity(0.5);

                                                            if (j != 0) {
                                                              questionController.questionSubCategory = catController.subCategoriesForDrawer[index][j - 1].name;
                                                              questionController.update();
                                                              var isDraftQuestionGet = await questionController.getDraftQuestions(
                                                                  questionController.questionCategory.toString(), questionController.questionSubCategory.toString());
                                                              if (isDraftQuestionGet) {
                                                                isShowQuestionsList = true;
                                                              }
                                                              print(questionController.draftQuestionModelList.length);
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
                                                              print(index);
                                                            }
                                                          },
                                                          child: Container(
                                                              width: 355.w,
                                                              height: 60.h,
                                                              margin: EdgeInsets.only(top: 14.h, left: 14.w, right: 14.w),
                                                              decoration: BoxDecoration(
                                                                color: j != 0 ? highlight[j] : whiteColor,
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
                                                                            child: Image.memory(j == 0
                                                                                ? base64Decode(catController.catList[index].image)
                                                                                : base64Decode(catController.subCategoriesForDrawer[index][j - 1].image)),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width: 10.w,
                                                                        ),
                                                                        MyText(
                                                                          txt: j == 0 ? catController.catList[index].name : catController.subCategoriesForDrawer[index][j - 1].name,
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
                                                                          j != 0 ? Icons.arrow_forward_ios_outlined : Icons.expand_less,
                                                                          size: j != 0 ? 17.sp : 25.sp,
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
                          Positioned(
                            top: 400.h,
                            child: InkWell(
                              onTap: () {
                                Get.to(ArticleList());
                              },
                              child: Container(
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
                                            txt: 'Drafts',
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
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isShowQuestionsList,
                      child: Container(
                        width: 1545.w,
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
                                            txt: '${questionController.questionCategory}/',
                                            color: Colors.black,
                                            fontweight: FontWeight.w800,
                                            size: 25.sp,
                                          ),
                                          MyText(
                                            txt: '${questionController.questionSubCategory}',
                                            color: Colors.black,
                                            fontweight: FontWeight.w300,
                                            size: 25.sp,
                                          ),
                                        ],
                                      ),
                                      MyText(
                                        txt: '500 Questions',
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
                                itemCount: questionController.draftQuestionModelList.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  if (isChecked.isEmpty) {
                                    for (int i = 0; i < questionController.draftQuestionModelList.length; i++) {
                                      isChecked.add(false);
                                    }
                                  }
                                  return Container(
                                    height: 121.h,
                                    margin: EdgeInsets.only(bottom: 29.h),
                                    decoration: BoxDecoration(
                                      color: cateContainerColor,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 12.h),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    MyText(
                                                      txt: '${index + 1}.',
                                                      color: basicColor,
                                                      fontweight: FontWeight.w800,
                                                      size: 25.sp,
                                                    ),
                                                    MyText(
                                                      txt: ' ${questionController.draftQuestionModelList[index].question}',
                                                      color: Colors.black,
                                                      fontweight: FontWeight.w800,
                                                      size: 25.sp,
                                                    ),
                                                    Container(
                                                      width: 30.w,
                                                      height: 30.h,
                                                      child: Checkbox(
                                                        hoverColor: Colors.transparent,
                                                        value: isChecked[index],
                                                        onChanged: (val) {
                                                          if (val != null) {
                                                            isChecked[index] = val;
                                                            setState(() {});
                                                          }
                                                        },
                                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                                        side: BorderSide(
                                                          color: basicColor, //your desire colour here
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    questionController.editDraftBtnClick(index);
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(right: 25.w),
                                                    child: MyText(
                                                      txt: 'Edit',
                                                      color: basicColor,
                                                      fontweight: FontWeight.w800,
                                                      size: 20.sp,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 50.w, right: 30.w, top: 20.h),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 1000.w,
                                                  height: 45.h,
                                                  child: ListView.builder(
                                                      itemCount: 4,
                                                      scrollDirection: Axis.horizontal,
                                                      itemBuilder: (context, j) {
                                                        return Container(
                                                          margin: EdgeInsets.only(right: 20.w),
                                                          child: reusableInstance.inputBox(
                                                              200.w,
                                                              45.h,
                                                              j + 1 != questionController.draftQuestionModelList[index].answer ? containerWrongBorder : containerCorrectBorder,
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 10.w),
                                                                    child: MyText(
                                                                      txt: '${optionNumber[index]}',
                                                                      color: basicColor,
                                                                      fontweight: FontWeight.w800,
                                                                      size: 25.sp,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 100.w,
                                                                    margin: EdgeInsets.only(right: 20.w),
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      children: [
                                                                        MyText(
                                                                          txt: '${questionController.draftQuestionModelList[index].choiceList[j]}',
                                                                          color: Colors.black,
                                                                          fontweight: FontWeight.w800,
                                                                          size: 25.sp,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),
                                                        );
                                                      }),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    questionController.deleteDraftBtnClick(index);
                                                  },
                                                  child: MyText(
                                                    txt: 'Delete',
                                                    color: Color(0xffFF0000),
                                                    fontweight: FontWeight.w800,
                                                    size: 20.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ));
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
