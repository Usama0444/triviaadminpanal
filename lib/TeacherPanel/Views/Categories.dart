import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/QuestionsController.dart';
import 'package:triviaadminpanal/TeacherPanel/Services/LoginServices.dart';
import 'package:triviaadminpanal/TeacherPanel/Services/QuestionServices.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/AddQuestions.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/CustomWidgets/MyText.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/CustomWidgets/Reusable.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Draft.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/LoginPage.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/SubCategory.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/components/GlobalVar.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/components/style.dart';
import 'package:triviaadminpanal/main.dart';

Reusable reusableInstance = Reusable();

class Categories extends StatefulWidget {
  Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  CategoryController cateController = Get.find<CategoryController>();
  QuestionController questionController = Get.put(QuestionController(), permanent: true);
  @override
  void initState() {
    super.initState();
    cateController.getCategories().whenComplete(() async {
      await questionController.getDraftQuestionsLength();
      await cateController.getSubCategories();
      await cateController.fillSubCategoryForDrawer();
      await questionController.getTotalQuestionsOfSepecificSubcategoryForAddQuestion();

      cateController.resetLodaing();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<CategoryController>(
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
                                        controller: cateController.categoryNameSearch,
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          color: greyColor,
                                        ),
                                        onChanged: (value) {
                                          cateController.categorySearchTap();
                                        },
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
                            child: InkWell(
                              onTap: () {
                                controller.isLoading != true ? Get.to(AddQuestion(callingFor: 'Add')) : reusableInstance.toast('Wait', 'wait tell Loading Complete');
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
                              await reusableInstance.logOut();
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
                                    ? index == 4
                                        ? 800.w
                                        : 120.w
                                    : 40.w,
                              ),
                              child: MyText(
                                txt: index != 4
                                    ? cateController.cateHeader[index]
                                    : cateController.totalQuestions != 0
                                        ? '${cateController.totalQuestions} Questions'
                                        : '',
                                color: index != 4 ? Colors.black : basicColor,
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
                          child: controller.isLoading == true
                              ? reusableInstance.loader()
                              : ListView.builder(
                                  itemCount: cateController.searchCategory.isEmpty
                                      ? cateController.isCategorySearchNotMatch
                                          ? 0
                                          : cateController.catList.length
                                      : cateController.searchCategory.length,
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
                                                  child: ClipOval(
                                                    child: Image.memory(
                                                      base64.decode(cateController.searchCategory.isEmpty ? cateController.catList[index].image : cateController.searchCategory[index].image),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )),
                                            Expanded(
                                              flex: 3,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: MyText(
                                                      txt: cateController.searchCategory.isEmpty ? cateController.catList[index].name : cateController.searchCategory[index].name,
                                                      color: Colors.black,
                                                      fontweight: FontWeight.w500,
                                                      size: 20.sp,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: MyText(
                                                      txt: cateController.searchCategory.isEmpty ? '${cateController.totalSubCate[index]}' : '${cateController.totalSubCatForSearch[index]}',
                                                      color: Colors.black,
                                                      fontweight: FontWeight.w500,
                                                      size: 20.sp,
                                                    ),
                                                  ),
                                                  GetBuilder<QuestionController>(builder: (qcontroller) {
                                                    return Expanded(
                                                      flex: 1,
                                                      child: MyText(
                                                        txt: cateController.searchCategory.isEmpty
                                                            ? '${qcontroller.totalUploadSubCategoryQuestionList[index]}'
                                                            : '${cateController.questionListSearchCat[index]}',
                                                        color: Colors.black,
                                                        fontweight: FontWeight.w500,
                                                        size: 20.sp,
                                                      ),
                                                    );
                                                  }),
                                                  Expanded(
                                                    flex: 1,
                                                    child: InkWell(
                                                      onTap: () {
                                                        if (cateController.searchCategory.isEmpty) {
                                                          cateController.categoryName = cateController.catList[index].name;
                                                          cateController.cid = cateController.catList[index].cid;
                                                        } else {
                                                          cateController.categoryName = cateController.searchCategory[index].name;
                                                          cateController.cid = cateController.searchCategory[index].cid;
                                                        }
                                                        cateController.update();
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
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                        ),
                        Container(width: 575.w, height: 882.h, child: reusableInstance.profile(cateController.isLoading))
                      ],
                    ),
                  ],
                )
              ],
            );
          },
        ));
  }
}
