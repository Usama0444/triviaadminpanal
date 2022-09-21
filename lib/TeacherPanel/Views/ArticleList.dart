import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Categories.dart';

import '../Controller/CategoryController.dart';
import '../Controller/QuestionsController.dart';
import '../Services/LoginServices.dart';
import 'CustomWidgets/MyText.dart';
import 'LoginPage.dart';
import 'components/style.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({Key? key}) : super(key: key);

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
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
  var isChecked = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  List<Color> highlight = [];
  bool isShowArticleList = false;
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
                        SizedBox(
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
                    InkWell(
                      onTap: () async {
                        var logout = await userLogOut();
                        if (logout) {
                          Get.offAll(LoginPage());
                        }
                      },
                      child: Container(
                        width: 38.w,
                        height: 38.w,
                        child: FittedBox(
                          child: Icon(
                            Icons.power_settings_new,
                            color: basicColor,
                          ),
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
                    itemCount: catController.catList.length + 1,
                    itemBuilder: (context, index) {
                      return index != catController.catList.length
                          ? InkWell(
                              onTap: () async {
                                questionController.questionCategory = catController.catList[index].name;
                                questionController.update();

                                setState(() {
                                  for (int i = 0; i < 10; i++) {
                                    hide[i] = true;
                                    show[i] = false;
                                  }
                                  highlight.clear();
                                  for (int i = 0; i < 10; i++) {
                                    highlight.add(Colors.white);
                                  }
                                  for (int i = 0; i < 10; i++) {
                                    highlight[i] = whiteColor;
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
                                                      child: ClipOval(
                                                          child: Image.memory(
                                                        base64Decode(catController.catList[index].image),
                                                        fit: BoxFit.cover,
                                                      )),
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
                                                    txt: '${catController.totalSubCate[index]}',
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
                                                    var isDraftQuestionGet =
                                                        await questionController.getDraftQuestions(questionController.questionCategory.toString(), questionController.questionSubCategory.toString());
                                                    if (isDraftQuestionGet) {
                                                      isShowArticleList = true;
                                                    }
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
                                                                  child: ClipOval(
                                                                    child: Image.memory(
                                                                      j == 0
                                                                          ? base64Decode(catController.catList[index].image)
                                                                          : base64Decode(catController.subCategoriesForDrawer[index][j - 1].image),
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ),
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
                                                                txt: j != 0 ? '0' : '${catController.totalSubCate[index]}',
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
                            )
                          : InkWell(
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
                            );
                    }),
              ),
              Visibility(
                visible: isShowArticleList,
                child: Container(
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
                                  txt: '${questionController.draftQuestionModelList.length} Articles',
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
                                            txt: 'Article no : 0${index + 1}',
                                            color: Colors.black,
                                            fontweight: FontWeight.w800,
                                            size: 16.sp,
                                          ),
                                          MyText(
                                            txt: '21/2/2022',
                                            color: basicColor,
                                            fontweight: FontWeight.w800,
                                            size: 10.sp,
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          SizedBox(
                                            width: 1300.w,
                                            child: Text(
                                              overflow: TextOverflow.visible,
                                              '''${questionController.draftQuestionModelList[index].article}''',
                                              maxLines: 3,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              questionController.copyBtnClick(index);
                                              reusableInstance.toast('Copied', 'copy to Clipboard');
                                            },
                                            child: MyText(
                                              txt: 'Copy',
                                              color: Color(0xff00D579),
                                              fontweight: FontWeight.w800,
                                              size: 20.sp,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              questionController.editDraftBtnClick(index);
                                            },
                                            child: MyText(
                                              txt: 'Edit',
                                              color: Color(0xff2CB4B3),
                                              fontweight: FontWeight.w800,
                                              size: 20.sp,
                                            ),
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
                                      )
                                    ],
                                  )),
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
