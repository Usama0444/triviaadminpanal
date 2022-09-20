import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Controller/QuestionsController.dart';
import 'Categories.dart';
import 'CustomWidgets/MyText.dart';
import 'components/style.dart';

class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  QuestionController questionController = Get.find<QuestionController>();
  bool t = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 740.w,
        height: 500.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: greyColor,
            width: 1.h,
          ),
          borderRadius: BorderRadius.circular(10.h),
        ),
        child: Stack(
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
                      GetBuilder<QuestionController>(builder: (con) {
                        return MyText(txt: '${questionController.textCounter}/500', color: Colors.black, fontweight: FontWeight.w300, size: 15.sp);
                      })
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
                child: TextFormField(
                  controller: t == false ? questionController.article : null,
                  onChanged: (value) {
                    if (value.split(' ').length <= 5) {
                      questionController.increaseTextCounter(value.split(' ').length);
                    } else {
                      t = true;
                      setState(() {});
                    }
                  },
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 200,
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 17.h,
                right: 24.w,
                child: Row(
                  children: [
                    reusableInstance.buttons(
                      100.w,
                      37.w,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 25.h,
                            child: FittedBox(
                              child: Icon(
                                Icons.add,
                                color: whiteColor,
                              ),
                            ),
                          ),
                          MyText(
                            txt: 'Image',
                            color: whiteColor,
                            fontweight: FontWeight.w300,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 27.w,
                    ),
                    InkWell(
                      onTap: () async {
                        await questionController.draftBtnClick();
                      },
                      child: reusableInstance.buttons(
                        86.w,
                        37.w,
                        Container(
                          height: 20.h,
                          child: Center(
                            child: MyText(
                              txt: 'Draft',
                              color: whiteColor,
                              fontweight: FontWeight.w300,
                              size: 19.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 27.w,
                    ),
                    reusableInstance.buttons(
                      86.w,
                      37.w,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 20.h,
                            child: MyText(
                              txt: 'Edit',
                              color: whiteColor,
                              fontweight: FontWeight.w300,
                              size: 19.sp,
                            ),
                          ),
                          Container(
                            height: 25.h,
                            child: FittedBox(
                              child: Icon(
                                Icons.edit,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 27.w,
                    ),
                    reusableInstance.buttons(
                      86.w,
                      37.w,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 25.h,
                            child: FittedBox(
                              child: Icon(
                                Icons.add,
                                color: whiteColor,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {},
                            child: Container(
                              height: 20.h,
                              child: MyText(
                                txt: 'Past',
                                color: whiteColor,
                                fontweight: FontWeight.w300,
                                size: 19.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
