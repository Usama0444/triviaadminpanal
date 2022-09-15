import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Services/LoginServices.dart';
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
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cateController.getCategories().whenComplete(() async {
      await cateController.getSubCategories();
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
          reusableInstance.appBar('category'),
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
                    child: isLoading == true
                        ? reusableInstance.loader()
                        : ListView.builder(
                            itemCount: cateController.catList.length,
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
                                            child: Image.memory(
                                              base64.decode(cateController.catList[index].image),
                                            ),
                                          )),
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: MyText(
                                                txt: cateController.catList[index].name,
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
                                              child: InkWell(
                                                onTap: () {
                                                  cateController.categoryName = cateController.catList[index].name;
                                                  cateController.cid = cateController.catList[index].cid;
                                                  cateController.callingScreenName = 'subCategory';
                                                  cateController.update();
                                                  isCategoryViewBtnClick = true;
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
                  Container(width: 575.w, height: 882.h, child: reusableInstance.profile())
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
