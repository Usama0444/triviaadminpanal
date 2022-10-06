import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/QuestionsController.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/CustomWidgets/MyText.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/SubCategory.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/components/style.dart';

class DraftArticlePage extends StatefulWidget {
  int index;
  DraftArticlePage({Key? key, required this.index}) : super(key: key);

  @override
  State<DraftArticlePage> createState() => _DraftArticlePageState();
}

class _DraftArticlePageState extends State<DraftArticlePage> {
  CategoryController cateController = Get.find<CategoryController>();
  QuestionController questionController = Get.find<QuestionController>();

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
                    //
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
              // SizedBox(
              //     height: 31.h,
              //     child: Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 40.w),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           MyText(
              //             txt: '${cateController.categoryName}/',
              //             color: Colors.black,
              //             fontweight: FontWeight.w800,
              //             size: 25.sp,
              //           ),
              //           MyText(
              //             txt: '${cateController.subCategoryName}',
              //             color: Colors.black,
              //             fontweight: FontWeight.w300,
              //             size: 25.sp,
              //           ),
              //         ],
              //       ),
              //     )),
              // SizedBox(height: 44.h),
              Container(
                width: 1200,
                height: 800.h,
                margin: EdgeInsets.all(40.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: greyColor,
                    width: 1.h,
                  ),
                  borderRadius: BorderRadius.circular(10.h),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      width: 1200,
                      height: 800.h,
                    ),
                    Positioned(
                      top: 0,
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Container(
                          width: 720.w,
                          margin: EdgeInsets.zero,
                          child: Row(
                            children: [
                              MyText(txt: 'Article/Description', color: Colors.black, fontweight: FontWeight.bold, size: 15.sp),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 30.h,
                      left: 10.w,
                      child: SizedBox(
                        width: 1180.w,
                        height: 780.h,
                        child: SingleChildScrollView(
                          child: MyText(
                            txt: questionController.draftQuestionModelList[widget.index].article,
                            color: Colors.black,
                            align: TextAlign.justify,
                            maxline: 200,
                            fontweight: FontWeight.bold,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20.h,
                      right: 20.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // InkWell(
                          //   onTap: () {
                          //     questionController.copyBtnClick(widget.index);
                          //     reusableInstance.toast('Copied', 'copy to Clipboard');
                          //   },
                          //   child: MyText(
                          //     txt: 'Copy',
                          //     color: const Color(0xff00D579),
                          //     fontweight: FontWeight.w800,
                          //     size: 20.sp,
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 20.w,
                          // ),
                          InkWell(
                            onTap: () {
                              questionController.editDraftBtnClick(widget.index);
                            },
                            child: MyText(
                              txt: 'Edit',
                              color: const Color(0xff2CB4B3),
                              fontweight: FontWeight.w800,
                              size: 20.sp,
                            ),
                          ),
                          // SizedBox(
                          //   width: 20.w,
                          // ),
                          // InkWell(
                          //   onTap: () async {
                          //     await questionController.deleteDraftBtnClick(widget.index);
                          //   },
                          //   child: MyText(
                          //     txt: 'Delete',
                          //     color: const Color(0xffFF0000),
                          //     fontweight: FontWeight.w800,
                          //     size: 20.sp,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
