import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/AdminPanel/Controllers/UserController.dart';

import 'CustomWidgets/MyText.dart';
import 'components/string.dart';
import 'components/style.dart';

class Users extends StatefulWidget {
  Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  var switchButton = true;
  var pushNoti = false;
  var title = TextEditingController();
  var description = TextEditingController();
  var txtController = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.getUser();
  }

  UserController controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: GetBuilder<UserController>(
          builder: (userController) {
            return userController.userModelList.length == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: CircularProgressIndicator()),
                    ],
                  )
                : Stack(children: [
                    Container(
                      width: 1586.w,
                    ),
                    SizedBox(
                      width: 1586.w,
                      height: 70.h,
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 260.w,
                                height: 45.h,
                                child: TextField(
                                  controller: txtController,
                                  onChanged: (val) async {
                                    userController.searchTap(val);
                                    if (val.isEmpty) {
                                      userController.searchUser.clear();
                                      userController.update();
                                      await userController.getUser();
                                    }
                                  },
                                  maxLength: 25,
                                  decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: basicColor),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: basicColor),
                                      ),
                                      counterText: '',
                                      border: InputBorder.none,
                                      hintText: 'Search User',
                                      contentPadding: EdgeInsets.only(left: 5.w),
                                      hintStyle: TextStyle(color: hideColor, fontSize: txtController.text.length > 20 ? 10.sp : 14.sp),
                                      suffixIcon: Container(
                                        width: 20.w,
                                        height: 20.h,
                                        child: Icon(
                                          Icons.search,
                                          color: basicColor,
                                        ),
                                      )),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (pushNoti) {
                                      pushNoti = false;
                                    } else {
                                      pushNoti = true;
                                    }
                                  });
                                },
                                child: Container(
                                  width: 200.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.h),
                                    color: btnColor,
                                  ),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 18.w,
                                        height: 21.h,
                                        child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: Icon(
                                            Icons.notifications_rounded,
                                            color: whiteColor,
                                          ),
                                        ),
                                      ),
                                      MyText(
                                        txt: pushNotification,
                                        color: whiteColor,
                                        fontweight: FontWeight.w600,
                                        size: 12.sp,
                                      ),
                                      Icon(
                                        pushNoti == false ? Icons.keyboard_arrow_down_outlined : Icons.keyboard_arrow_up_outlined,
                                        color: whiteColor,
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 70.h,
                      child: SizedBox(
                        height: 1010.h,
                        width: 1586.w,
                        child: ListView.builder(
                            itemCount: userController.searchUser.length == 0 ? userController.userModelList.length : userController.searchUser.length + 1,
                            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 1090.w,
                                    height: 30.h,
                                    child: ListView.builder(
                                        itemCount: 6,
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, i) {
                                          return Row(
                                            children: [
                                              Container(
                                                width: 160.w,
                                                height: 25.h,
                                                margin: EdgeInsets.only(right: 30.w),
                                                child: index == 0
                                                    ? MyText(
                                                        txt: userController.headings[i],
                                                        color: secondColor,
                                                        fontweight: FontWeight.w800,
                                                        size: 16.sp,
                                                      )
                                                    : i < 5
                                                        ? MyText(
                                                            // txt: '${userController.userList[index][i]}',
                                                            txt: userController.searchUser.length == 0 ? '${userController.userList[index][i]}' : '${userController.searchUser[index - 1][i]}',
                                                            color: secondColor,
                                                            fontweight: FontWeight.w400,
                                                            size: 16.sp,
                                                          )
                                                        : Container(
                                                            width: 45.w,
                                                            height: 20.h,
                                                            child: Switch(
                                                              value: userController.active[index],
                                                              onChanged: (val) {
                                                                userController.active[index] = val;
                                                                userController.update();
                                                              },
                                                              activeColor: basicColor,
                                                              activeTrackColor: hideColor,
                                                              inactiveTrackColor: hideColor,
                                                              inactiveThumbColor: Color(0xff3B3B3B),
                                                            ),
                                                          ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                    Visibility(
                      visible: pushNoti,
                      child: Positioned(
                        left: 1264.w,
                        top: 80.h,
                        child: pushNotificationDialog(title, description),
                      ),
                    )
                  ]);
          },
        ));
  }

  Widget pushNotificationDialog(titleController, descriptionController) {
    return Container(
      width: 282.w,
      height: 284.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: hideColor,
          width: 1.h,
        ),
        borderRadius: BorderRadius.circular(10.h),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            width: 241.w,
            height: 40.h,
            margin: EdgeInsets.only(top: 22.h, bottom: 12.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.h),
                border: Border.all(
                  color: hideColor,
                  width: 2.h,
                )),
            child: Padding(
              padding: EdgeInsets.only(left: 10.w, bottom: 12.h),
              child: TextField(
                controller: titleController,
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
          Container(
            width: 241.w,
            height: 153.h,
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.h),
                border: Border.all(
                  color: hideColor,
                  width: 2.h,
                )),
            child: Padding(
              padding: EdgeInsets.only(left: 10.w, bottom: 12.h),
              child: TextField(
                controller: descriptionController,
                maxLines: 10,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Description',
                    hintStyle: TextStyle(
                      fontSize: 12.sp,
                      color: hideColor,
                    )),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                if (pushNoti) {
                  pushNoti = false;
                } else {
                  pushNoti = true;
                }
              });
            },
            child: Container(
              width: 70.w,
              height: 26.h,
              margin: EdgeInsets.only(top: 19.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.h),
                color: btnColor,
              ),
              child: Center(
                  child: MyText(
                txt: 'Send',
                color: whiteColor,
                fontweight: FontWeight.w600,
                size: 10.sp,
              )),
            ),
          )
        ],
      ),
    );
  }
}
