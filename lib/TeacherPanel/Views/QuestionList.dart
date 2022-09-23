import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/QuestionsController.dart';
import 'package:triviaadminpanal/TeacherPanel/Services/QuestionServices.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/AddQuestions.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/CustomWidgets/MyText.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/CustomWidgets/Reusable.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/SubCategory.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/components/style.dart';

import '../Services/LoginServices.dart';
import 'LoginPage.dart';

Reusable reusableInstance = Reusable();

class QuestionList extends StatefulWidget {
  QuestionList({Key? key}) : super(key: key);

  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  CategoryController cateController = Get.find<CategoryController>();
  QuestionController questionController = Get.find<QuestionController>();
  var optionNumber = [
    'a)',
    'b)',
    'c)',
    'd)',
  ];

  bool isLoading = true;
  var catName, subCateName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questionController.getQuestions(cateController.categoryName!, cateController.subCategoryName!).whenComplete(() async {
      setState(() {
        catName = cateController.categoryName!;
        subCateName = cateController.subCategoryName!;
        isLoading = false;
      });
    });
  }

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
                    InkWell(
                      onTap: () {
                        cateController.appBarLogoClick();
                      },
                      child: Row(
                        children: [
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
                        ],
                      ),
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
                                  controller: questionController.questionSerach,
                                  onChanged: (value) {
                                    questionController.questionSearchTap();
                                  },
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
                      padding: EdgeInsets.only(top: 29.h, right: 60.w),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
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
                              Container(
                                height: 20.h,
                                child: MyText(
                                  txt: 'Back',
                                  color: whiteColor,
                                  fontweight: FontWeight.w300,
                                  size: 21.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 29.h),
                      child: InkWell(
                        onTap: () {
                          Get.to(AddQuestion(callingFor: 'Add'));
                        },
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
                                onTap: () async {
                                  await questionController.erasedData();
                                  Get.to(AddQuestion(callingFor: 'Add'));
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
          GetBuilder<QuestionController>(builder: (controller) {
            return isLoading
                ? Column(
                    children: [
                      SizedBox(
                        height: 400.h,
                      ),
                      reusableInstance.loader(),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 31.h,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    MyText(
                                      txt: '${catName}/',
                                      color: Colors.black,
                                      fontweight: FontWeight.w800,
                                      size: 25.sp,
                                    ),
                                    MyText(
                                      txt: '$subCateName',
                                      color: Colors.black,
                                      fontweight: FontWeight.w300,
                                      size: 25.sp,
                                    ),
                                  ],
                                ),
                                MyText(
                                  txt: '${questionController.teacherQuestionModelList.length} Questions',
                                  color: basicColor,
                                  fontweight: FontWeight.w500,
                                  size: 20.sp,
                                ),
                              ],
                            ),
                          )),
                      SizedBox(height: 44.h),
                      SizedBox(
                        height: 882.h,
                        child: ListView.builder(
                          itemCount: questionController.searchQuestion.isEmpty
                              ? questionController.questionSearchNotMatch
                                  ? 0
                                  : questionController.teacherQuestionModelList.length
                              : questionController.searchQuestion.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
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
                                                txt: questionController.searchQuestion.isEmpty
                                                    ? ' ${questionController.teacherQuestionModelList[index].question}'
                                                    : ' ${questionController.searchQuestion[index].question}',
                                                color: Colors.black,
                                                fontweight: FontWeight.w800,
                                                size: 25.sp,
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              questionController.editBtnClick(index);
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
                                      padding: EdgeInsets.only(left: 40.w, right: 30.w, top: 20.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 1700.w,
                                            height: 45.h,
                                            child: ListView.builder(
                                                itemCount: 4,
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (context, j) {
                                                  return Container(
                                                    margin: EdgeInsets.only(right: 20.w),
                                                    child: reusableInstance.inputBox(
                                                        321.w,
                                                        45.h,
                                                        j !=
                                                                questionController
                                                                        .teacherQuestionModelList[questionController.questionSearchIndex == -1 ? index : questionController.questionSearchIndex]
                                                                        .answer -
                                                                    1
                                                            ? containerWrongBorder
                                                            : containerCorrectBorder,
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(left: 10.w),
                                                              child: MyText(
                                                                txt: optionNumber[j],
                                                                color: basicColor,
                                                                fontweight: FontWeight.w800,
                                                                size: 25.sp,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 250.w,
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  MyText(
                                                                    txt: questionController.searchQuestion.isEmpty
                                                                        ? '${questionController.teacherQuestionModelList[index].choiceList[j]}'
                                                                        : '${questionController.searchQuestion[index].choiceList[j]}',
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
                                            onTap: () async {
                                              await questionController.deleteBtnClick(index);
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
                  );
          })
        ],
      ),
    );
  }
}
