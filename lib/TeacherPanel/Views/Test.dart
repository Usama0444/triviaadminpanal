import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Categories.dart';

import 'CustomWidgets/MyText.dart';
import 'components/style.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final QuillController controller = QuillController.basic();
  int count = 0;
  bool read = false;
  StreamSubscription? lis;
  void onDocumentChange() {
    final documentLength = controller.document.length;
    print(documentLength);
    if (count > 5) {
      int latestIndex = documentLength - 1;
      controller.replaceText(
        latestIndex,
        0,
        '#',
        null,
        ignoreFocus: false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    listner();
  }

  listner() {
    lis = controller.document.changes.listen((event) {
      setState(() {
        count = controller.document.toPlainText().split(' ').length;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
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
                SizedBox(
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
                          MyText(txt: '$count/500', color: Colors.black, fontweight: FontWeight.w300, size: 15.sp),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50.h,
                  left: 10.w,
                  child: SizedBox(
                    width: 700.w,
                    height: 500.h,
                    child: Column(
                      children: [
                        QuillToolbar.basic(controller: controller),
                        SizedBox(
                          height: 10.h,
                        ),
                        Expanded(
                          child: QuillEditor.basic(
                            controller: controller,
                            readOnly: count > 2 ? true : false,
                          ),
                        ),
                      ],
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
                              SizedBox(
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
                      ],
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 20.w,
          ),
          ElevatedButton(
              onPressed: () {
                reusableInstance.toast('heading', controller.document.toPlainText());
              },
              child: const Text('data'))
        ],
      ),
    );
  }
}
