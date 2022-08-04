import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:triviaadminpanal/AdminPanel/Services/ApprovedQuestionServices.dart';
import 'package:triviaadminpanal/AdminPanel/views/MyDrawer.dart';

import '../Controllers/CategoryController.dart';
import 'CustomWidgets/MyText.dart';
import 'CustomWidgets/colorContainer.dart';
import 'components/style.dart';

class AddSubCategroy extends StatefulWidget {
  const AddSubCategroy({Key? key}) : super(key: key);

  @override
  State<AddSubCategroy> createState() => _AddCategroyState();
}

class _AddCategroyState extends State<AddSubCategroy> {
  @override
  Widget build(BuildContext context) {
    return MyDrawer(child: CategoryDesign());
  }
}

class CategoryDesign extends StatefulWidget {
  const CategoryDesign({Key? key}) : super(key: key);

  @override
  State<CategoryDesign> createState() => _CategoryDesignState();
}

class _CategoryDesignState extends State<CategoryDesign> {
  File? pcikedImage;
  var controller = Get.put(CategoryController());
  countSubCatLength() async {
    await controller.getCategories();
    controller.subCatLength.clear();
    for (int i = 0; i < controller.catList.length; i++) {
      await controller.getSubCategories(controller.catList[i][2]);
      controller.subCatLength.add(controller.subcatList.length);
    }
    controller.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<CategoryController>(builder: (controler) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 1586.w,
            height: 70.h,
            child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 40.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      txt: controller.isCategoryEdit == true ? 'Update Sub-Category' : 'Add Sub-Category',
                      color: drawerColor,
                      fontweight: FontWeight.w700,
                      size: 16.sp,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (controller.isSUbCategoryEdit == false && controller.subcategoryTextControllr.text.trim() != '' && controller.subcategoryLogo != null) {
                          await controller.addSubCategories(controller.subcategoryTextControllr.text, controller.subcategoryLogo, controler.cid);
                          controller.getSubCategories(controler.cid);
                          countSubCatLength();
                        } else if (controller.isSUbCategoryEdit == true && controller.subcategoryTextControllr.text.trim() != '' && controller.subcategoryLogo != null) {
                          await controller.updateSubCategory(controller.subcategoryTextControllr.text, controler.subcategoryLogo, controler.sid);
                          controller.getSubCategories(controler.cid);
                          countSubCatLength();
                        } else {
                          Get.snackbar('Error', 'invalid Data');
                        }
                        // Get.back();
                      },
                      child: colorContainer(
                        basicColor,
                        Center(
                          child: MyText(
                            txt: controller.isSUbCategoryEdit != true ? 'Add' : 'Update',
                            color: whiteColor,
                            fontweight: FontWeight.w600,
                            size: 15.sp,
                          ),
                        ),
                        60.w,
                        30.h,
                        5.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 80.h,
              left: 40.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    TakePhoto(ImageSource.gallery);
                  },
                  child: Container(
                    width: 112.w,
                    height: 112.h,
                    decoration: BoxDecoration(
                      color: Color(0xffE6E6E6),
                      borderRadius: BorderRadius.circular(10.h),
                    ),
                    child: controller.subcategoryLogo != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10.h),
                            child: Image.memory(
                              base64.decode(controller.subcategoryLogo),
                              fit: BoxFit.cover,
                            ),
                          )
                        : Text(''),
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                InkWell(
                  onTap: () {
                    TakePhoto(ImageSource.gallery);
                  },
                  child: MyText(
                    txt: 'Add Logo',
                    color: basicColor,
                    fontweight: FontWeight.w700,
                    size: 14.sp,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  width: 360.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: hideColor),
                    borderRadius: BorderRadius.circular(10.h),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w, bottom: 17.h),
                    child: TextField(
                      controller: controller.subcategoryTextControllr,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Title',
                          hintStyle: TextStyle(
                            fontSize: 12.sp,
                            color: hideColor,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }));
  }

  TakePhoto(ImageSource source) async {
    try {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final bytes = await image.readAsBytes();
        controller.subcategoryLogo = base64.encode(bytes);
        controller.update();
      } else {
        print('Not picked');
      }
    } on PlatformException catch (e) {
      print('Faild to pick Image : $e');
    }
  }
}
