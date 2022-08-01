// ignore_for_file: unnecessary_string_escapes

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/CategoryController.dart';
import 'package:triviaadminpanal/AdminPanel/views/CustomWidgets/MyContainer.dart';
import 'package:triviaadminpanal/AdminPanel/views/CustomWidgets/MyText.dart';
import 'package:triviaadminpanal/AdminPanel/views/CustomWidgets/colorContainer.dart';
import 'package:triviaadminpanal/AdminPanel/views/components/style.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Categories extends StatefulWidget {
  Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  var contorller = Get.put(CategoryController());
  var educationTab = false;
  var addCat = false;
  var addSubCat = false;
  File? pcikedImage;
  var categoryLogo;
  var subCategoryLogo;
  var cid = '';
  var sid = '';

  var categoryTextControllr = TextEditingController();
  var subCategoryTextController = TextEditingController();
  var isEdit = false;
  var isSubCatEdit = false;
  @override
  void initState() {
    super.initState();
    countSubCatLength();
  }

  countSubCatLength() async {
    await contorller.getCategories();
    contorller.subCatLength.clear();
    for (int i = 0; i < contorller.catList.length; i++) {
      await contorller.getSubCategories(contorller.catList[i][2]);
      contorller.subCatLength.add(contorller.subcatList.length);
    }
    contorller.update();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: whiteColor,
          body: GetBuilder<CategoryController>(
            builder: (controller) {
              return controller.catList.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: CircularProgressIndicator()),
                      ],
                    )
                  : Row(
                      children: [
                        Container(
                            width: 550.w,
                            child: Stack(
                              children: [
                                Container(
                                  width: 550.w,
                                ),
                                Positioned(
                                  top: 20.h,
                                  child: Container(
                                    width: 460.w,
                                    margin: EdgeInsets.symmetric(horizontal: 40.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyText(
                                          txt: 'Categories   10',
                                          color: secondColor,
                                          fontweight: FontWeight.w600,
                                          size: 18.sp,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              if (addCat) {
                                                addCat = false;
                                              } else {
                                                addCat = true;
                                              }
                                            });
                                            if (isEdit == false && addCat == false && categoryTextControllr.text != '' && categoryLogo != null) {
                                              await controller.addCategories(categoryTextControllr.text, categoryLogo);
                                              await controller.getCategories();
                                            } else if (isEdit == true && categoryTextControllr.text != '' && categoryLogo != null) {
                                              await controller.updateCategory(categoryTextControllr.text, categoryLogo, cid);
                                              contorller.catList.clear();
                                              contorller.categoryModelList.clear();
                                              contorller.update();
                                              await controller.getCategories();
                                            } else if (addCat == false) {
                                              Get.snackbar('Error', 'Invalid Data');
                                            }
                                            setState(() {
                                              categoryTextControllr.text = '';
                                              categoryLogo = null;
                                              isEdit = false;
                                            });
                                          },
                                          child: colorContainer(
                                            basicColor,
                                            Center(
                                              child: MyText(
                                                txt: addCat == false ? 'Add' : 'Save',
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
                                Positioned(
                                  top: 70.h,
                                  child: colorContainer(
                                    basicColor,
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          MyText(
                                            txt: 'Total Questions : 5000',
                                            color: whiteColor,
                                            fontweight: FontWeight.normal,
                                            size: 15.sp,
                                          )
                                        ],
                                      ),
                                    ),
                                    550.w,
                                    30.h,
                                    0.h,
                                  ),
                                ),
                                Positioned(
                                  top: 100.h,
                                  child: Container(
                                      height: 1000.h,
                                      width: 550.w,
                                      child: ListView.builder(
                                          itemCount: controller.catList.length,
                                          padding: EdgeInsets.only(top: 13.h),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                for (int i = 0; i < controller.catList.length; i++) {
                                                  controller.categoryColor[i] = whiteColor;
                                                  controller.categoryTextColor[i] = secondColor;
                                                }
                                                controller.categoryColor[index] = basicColor;
                                                controller.categoryTextColor[index] = whiteColor;
                                                setState(() {
                                                  // if (educationTab) {
                                                  //   educationTab = false;
                                                  // } else {
                                                  educationTab = true;
                                                  // }
                                                  cid = controller.catList[index][2];
                                                });
                                                controller.update();
                                                controller.getSubCategories(cid);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(bottom: 20.h),
                                                child: MyCategory(
                                                    550.w,
                                                    120.h,
                                                    0,
                                                    controller.categoryColor[index],
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 40.w),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              MyContainer(
                                                                  90.h,
                                                                  90.h,
                                                                  5.h,
                                                                  Image.memory(
                                                                    base64.decode(controller.catList[index][1]),
                                                                    fit: BoxFit.cover,
                                                                  )),
                                                              Container(
                                                                margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 16.h),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    MyText(
                                                                      txt: controller.catList[index][0],
                                                                      color: contorller.categoryTextColor[index],
                                                                      fontweight: FontWeight.w700,
                                                                      size: 18.sp,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5.h,
                                                                    ),
                                                                    MyText(
                                                                      txt: 'Total sub-Categories :${controller.subCatLength[index]}',
                                                                      color: contorller.categoryTextColor[index],
                                                                      fontweight: FontWeight.normal,
                                                                      size: 14.sp,
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          TextButton(
                                                              onPressed: () async {
                                                                setState(() {
                                                                  categoryTextControllr.text = controller.catList[index][0];
                                                                  categoryLogo = controller.catList[index][1];
                                                                  if (addCat) {
                                                                    addCat = false;
                                                                  } else {
                                                                    addCat = true;
                                                                  }
                                                                  isEdit = true;
                                                                  cid = controller.catList[index][2];
                                                                });
                                                              },
                                                              child: MyText(
                                                                txt: 'Edit',
                                                                color: contorller.categoryTextColor[index] == secondColor ? basicColor : contorller.categoryTextColor[index],
                                                                fontweight: FontWeight.normal,
                                                                size: 14.sp,
                                                              ))
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            );
                                          })),
                                ),
                                Positioned(
                                  top: 70.h,
                                  left: 310.w,
                                  height: 220.h,
                                  child: Visibility(
                                    visible: addCat,
                                    child: addCategory(categoryTextControllr, categoryLogo),
                                  ),
                                ),
                              ],
                            )),
                        VerticalDivider(
                          color: basicColor,
                          width: 0.1,
                        ),
                        Container(
                            width: 1035.w,
                            child: Stack(
                              children: [
                                Container(
                                  width: 1035.w,
                                ),
                                Container(
                                  width: 950.w,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyText(
                                          txt: 'Sub-Categories',
                                          color: secondColor,
                                          fontweight: FontWeight.w600,
                                          size: 18.sp,
                                        ),
                                        Visibility(
                                          visible: educationTab,
                                          child: GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                if (addSubCat) {
                                                  addSubCat = false;
                                                } else {
                                                  addSubCat = true;
                                                }
                                              });

                                              if (isSubCatEdit == false && addSubCat == false && subCategoryTextController.text != '' && subCategoryLogo != null) {
                                                // Get.snackbar(subCategoryTextController.text, "");
                                                await controller.addSubCategories(subCategoryTextController.text, subCategoryLogo, cid);
                                                await countSubCatLength();
                                                await controller.getSubCategories(cid);
                                              } else if (isSubCatEdit == true && addSubCat == false && subCategoryTextController.text != '' && subCategoryLogo != null) {
                                                await controller.updateSubCategory(subCategoryTextController.text, subCategoryLogo, sid);

                                                await Future.delayed(Duration(seconds: 1));
                                                await controller.getSubCategories(cid);
                                              } else if (addSubCat == false) {
                                                Get.snackbar('Error', 'Invalid Data');
                                              }
                                              setState(() {
                                                subCategoryTextController.text = '';
                                                subCategoryLogo = null;
                                                isSubCatEdit = false;
                                              });
                                            },
                                            child: colorContainer(
                                              basicColor,
                                              Center(
                                                child: MyText(
                                                  txt: addSubCat == false ? 'Add' : 'Save',
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
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 70.h,
                                  child: colorContainer(
                                    basicColor,
                                    Text(""),
                                    1036.w,
                                    30.h,
                                    0.h,
                                  ),
                                ),
                                Visibility(
                                  visible: educationTab,
                                  child: Positioned(
                                    top: 100.h,
                                    child: Container(
                                        height: 900.h,
                                        width: 1035.w,
                                        child: ListView.builder(
                                            padding: EdgeInsets.only(top: 13.h),
                                            itemCount: contorller.subcatList.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: EdgeInsets.only(bottom: 20.h),
                                                child: MyContainer(
                                                  550.w,
                                                  120.h,
                                                  0,
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 40.w, top: 15.h, bottom: 15.h),
                                                        child: Row(
                                                          children: [
                                                            MyContainer(
                                                                90.h,
                                                                90.h,
                                                                5.h,
                                                                Image.memory(
                                                                  base64.decode(controller.subcatList[index][1]),
                                                                  fit: BoxFit.cover,
                                                                )),
                                                            Container(
                                                              margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 16.h),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  MyText(
                                                                    txt: controller.subcatList[index][0],
                                                                    color: secondColor,
                                                                    fontweight: FontWeight.w700,
                                                                    size: 18.sp,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5.h,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      MyText(
                                                                        txt: 'Total Questions ',
                                                                        color: secondColor,
                                                                        fontweight: FontWeight.normal,
                                                                        size: 14.sp,
                                                                      ),
                                                                      MyText(
                                                                        txt: '15000',
                                                                        color: secondColor,
                                                                        fontweight: FontWeight.normal,
                                                                        size: 14.sp,
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      TextButton(
                                                          onPressed: () async {
                                                            setState(() {
                                                              subCategoryTextController.text = controller.subcatList[index][0];
                                                              subCategoryLogo = controller.subcatList[index][1];
                                                              if (addSubCat) {
                                                                addSubCat = false;
                                                              } else {
                                                                addSubCat = true;
                                                              }
                                                              isSubCatEdit = true;
                                                              sid = controller.subcatList[index][3];
                                                            });
                                                          },
                                                          child: MyText(
                                                            txt: 'Edit',
                                                            color: basicColor,
                                                            fontweight: FontWeight.normal,
                                                            size: 14.sp,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })),
                                  ),
                                ),
                                Positioned(
                                  top: 70.h,
                                  left: 786.w,
                                  height: 220.h,
                                  child: Visibility(
                                    visible: addSubCat,
                                    child: addSubCategory(subCategoryTextController, subCategoryLogo),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    );
            },
          )),
    );
  }

  TakePhoto(ImageSource source, var type) async {
    try {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          if (type == 'Cate') {
            categoryLogo = base64.encode(bytes);
          } else if (type == 'SubCate') {
            subCategoryLogo = base64.encode(bytes);
          }
        });
      } else {
        print('Not picked');
      }
    } on PlatformException catch (e) {
      print('Faild to pick Image : $e');
    }
  }

  Widget addCategory(var controller, image) {
    return Container(
      width: 220.w,
      height: 220.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: basicColor,
          width: 1.h,
        ),
        borderRadius: BorderRadius.circular(10.h),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            width: 180.w,
            height: 40.h,
            margin: EdgeInsets.all(20.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.h),
                border: Border.all(
                  color: hideColor,
                  width: 2.h,
                )),
            child: Padding(
              padding: EdgeInsets.only(left: 10.w, bottom: 12.h),
              child: TextField(
                controller: controller,
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
          GestureDetector(
            onTap: () {
              TakePhoto(ImageSource.gallery, 'Cate');
            },
            child: MyContainer(
              90.h,
              90.h,
              5.h,
              Center(
                child: image == null
                    ? MyText(txt: 'Add Logo', color: secondColor, fontweight: FontWeight.w600, size: 12.sp)
                    : Image.memory(
                        base64.decode(image),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget addSubCategory(controller, var image) {
    return Container(
      width: 220.w,
      height: 220.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: basicColor,
          width: 1.h,
        ),
        borderRadius: BorderRadius.circular(10.h),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            width: 180.w,
            height: 40.h,
            margin: EdgeInsets.all(20.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.h),
                border: Border.all(
                  color: hideColor,
                  width: 2.h,
                )),
            child: Padding(
              padding: EdgeInsets.only(left: 10.w, bottom: 12.h),
              child: TextField(
                controller: controller,
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
          GestureDetector(
            onTap: () {
              TakePhoto(ImageSource.gallery, 'SubCate');
            },
            child: MyContainer(
              90.h,
              90.h,
              5.h,
              Center(
                child: image == null
                    ? MyText(txt: 'Add Logo', color: secondColor, fontweight: FontWeight.w600, size: 12.sp)
                    : Image.memory(
                        base64.decode(image),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
