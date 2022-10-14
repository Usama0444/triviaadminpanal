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
import 'package:triviaadminpanal/TeacherPanel/Views/ArticlePage.dart';
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
  State<QuestionList> createState() => _QuestionsState();
}

class _QuestionsState extends State<QuestionList> {
  CategoryController cateController = Get.find<CategoryController>();
  QuestionController questionController = Get.find<QuestionController>();
  var optionNumber = [
    'a)',
    'b)',
    'c)',
    'd)',
  ];

  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questionController.getQuestions(cateController.categoryName!, cateController.subCategoryName!).whenComplete(() async {
      setState(() {
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
                    InkWell(
                      onTap: () async {
                        await questionController.deleteAllQuestions();
                      },
                      child: reusableInstance.buttons(
                        180.w,
                        42.h,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20.h,
                              child: MyText(
                                txt: 'Delete All',
                                color: whiteColor,
                                fontweight: FontWeight.w300,
                                size: 21.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 62.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 60.w),
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
                    InkWell(
                      onTap: () {
                        questionController.questionLengthPerSubcateogryForAddQuestion = [];
                        questionController.update();
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
                            SizedBox(
                              height: 20.h,
                              child: MyText(
                                txt: 'Add Question',
                                color: whiteColor,
                                fontweight: FontWeight.w300,
                                size: 21.sp,
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
                    InkWell(
                      onTap: () async {
                        await reusableInstance.logOut();
                      },
                      child: SizedBox(
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
                                      txt: '${cateController.categoryName}/',
                                      color: Colors.black,
                                      fontweight: FontWeight.w800,
                                      size: 25.sp,
                                    ),
                                    MyText(
                                      txt: '${cateController.subCategoryName}',
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
                              margin: EdgeInsets.only(bottom: 20.h),
                              decoration: BoxDecoration(
                                color: cateContainerColor,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 940.w,
                                          height: 147.h,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              MyText(
                                                txt: '${index + 1}.',
                                                color: basicColor,
                                                fontweight: FontWeight.w800,
                                                size: 25.sp,
                                              ),
                                              SizedBox(
                                                width: 900.w,
                                                child: MyText(
                                                  txt: questionController.searchQuestion.isEmpty
                                                      ? ' ${questionController.teacherQuestionModelList[index].question}'
                                                      : ' ${questionController.searchQuestion[index].question}',
                                                  color: Colors.black,
                                                  maxline: 25,
                                                  align: TextAlign.left,
                                                  fontweight: FontWeight.w800,
                                                  size: 25.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 940.w,
                                          child: GridView.count(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10.0,
                                            mainAxisSpacing: 10.0,
                                            childAspectRatio: 500 / 60,
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            children: List.generate(
                                              4,
                                              (j) {
                                                return reusableInstance.inputBox(
                                                  321.w,
                                                  90.h,
                                                  j !=
                                                          questionController
                                                                  .teacherQuestionModelList[questionController.questionSearchIndex == -1 ? index : questionController.questionSearchIndex].answer -
                                                              1
                                                      ? containerWrongBorder
                                                      : containerCorrectBorder,
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                                      Expanded(
                                                        flex: 1,
                                                        child: SingleChildScrollView(
                                                          scrollDirection: Axis.vertical,
                                                          child: Center(
                                                            child: MyText(
                                                              txt: questionController.searchQuestion.isEmpty
                                                                  ? '${questionController.teacherQuestionModelList[index].choiceList[j]}'
                                                                  : '${questionController.searchQuestion[index].choiceList[j]}',
                                                              color: Colors.black,
                                                              maxline: 10,
                                                              fontweight: FontWeight.w800,
                                                              size: 25.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Container(
                                      height: 64,
                                      color: Color(0xffF5F5F5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 100.w,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.to(ArticlePage(index: index));
                                            },
                                            child: MyText(
                                              txt: 'Article',
                                              color: basicColor,
                                              fontweight: FontWeight.w800,
                                              size: 20.sp,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 150.w,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              questionController.editBtnClick(index);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(right: 7.w),
                                              child: MyText(
                                                txt: 'Edit',
                                                color: basicColor,
                                                fontweight: FontWeight.w800,
                                                size: 20.sp,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 150.w,
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
