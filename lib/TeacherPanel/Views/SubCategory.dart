import 'dart:convert';

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
import 'package:triviaadminpanal/TeacherPanel/Views/QuestionList.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/components/style.dart';

import '../Controller/QuestionsController.dart';
import '../Services/LoginServices.dart';
import 'Draft.dart';
import 'LoginPage.dart';

Reusable reusableInstance = Reusable();

class SubCategory extends StatefulWidget {
  SubCategory({Key? key}) : super(key: key);

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  CategoryController cateController = Get.find<CategoryController>();
  QuestionController questionController = Get.find<QuestionController>();

  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cateController.categoryViewBtnClick(cateController.cid).whenComplete(() async {
      await questionController.getTotalNumberOfQuestion();
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
          reusableInstance.appBar('subCategory'),
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
                    itemCount: cateController.subCateHeader.length,
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
                          txt: index != 3 ? cateController.subCateHeader[index] : '${questionController.totalQuestions} Questions',
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
                    child: isLoading == true
                        ? reusableInstance.loader()
                        : ListView.builder(
                            itemCount: cateController.subCatList.length,
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
                                            child: Image.memory(base64Decode(cateController.subCatList[index].image)),
                                          )),
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: MyText(
                                                txt: cateController.subCatList[index].name,
                                                color: Colors.black,
                                                fontweight: FontWeight.w500,
                                                size: 20.sp,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: MyText(
                                                txt: '${questionController.totalQuestionOfspecificSubCategory[index]}',
                                                color: Colors.black,
                                                fontweight: FontWeight.w500,
                                                size: 20.sp,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  cateController.subCategoryName = cateController.subCatList[index].name;
                                                  cateController.update();
                                                  Get.to(QuestionList(
                                                    totalQuestion: questionController.totalQuestionOfspecificSubCategory[index],
                                                  ));
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
                  Container(width: 575.w, height: 882.h, child: reusableInstance.profile(isLoading))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
