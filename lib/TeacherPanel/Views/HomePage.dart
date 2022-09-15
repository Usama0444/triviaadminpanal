import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Controller/CategoryController.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Categories.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/CustomWidgets/Reusable.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/SubCategory.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/components/GlobalVar.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  Reusable reusableInstance = Reusable();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<CategoryController>(
      builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            reusableInstance.appBar(controller.callingScreenName),
            Container(width: 1920.w, height: 1000.h, child: isCategoryViewBtnClick == false ? Categories() : SubCategory()),
          ],
        );
      },
    ));
  }
}
