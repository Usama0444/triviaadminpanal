import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/QuestionsController.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/AddQuestions.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/CustomWidgets/MyText.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/CustomWidgets/Reusable.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/SubCategory.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/components/style.dart';

import '../Services/LoginServices.dart';
import 'LoginPage.dart';

Reusable reusableInstance = Reusable();

class QuestionList extends StatefulWidget {
  int totalQuestion = 0;
  QuestionList({Key? key, required this.totalQuestion}) : super(key: key);

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
          reusableInstance.appBar('question_list'),
          SizedBox(
            height: 41.h,
          ),
          isLoading
              ? reusableInstance.loader()
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
                                txt: '${widget.totalQuestion} Questions',
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
                        itemCount: questionController.teacherQuestionModelList.length,
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
                                              txt: ' ${questionController.teacherQuestionModelList[index].question}',
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
                                                print('answer');
                                                print(questionController.teacherQuestionModelList[index].answer - 1);
                                                print(j);
                                                return Container(
                                                  margin: EdgeInsets.only(right: 20.w),
                                                  child: reusableInstance.inputBox(
                                                      321.w,
                                                      45.h,
                                                      j != questionController.teacherQuestionModelList[index].answer - 1 ? containerWrongBorder : containerCorrectBorder,
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
                                                            width: 250.w,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                MyText(
                                                                  txt: '${questionController.teacherQuestionModelList[index].choiceList[j]}',
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
                )
        ],
      ),
    );
  }
}
