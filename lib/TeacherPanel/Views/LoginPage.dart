import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/Categories.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/CustomWidgets/MyText.dart';
import 'package:triviaadminpanal/TeacherPanel/Views/components/style.dart';
import 'package:triviaadminpanal/main.dart';

import '../Controller/LogInController.dart';
import 'CustomWidgets/MyContainer.dart';
import 'components/string.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  CarouselController controller = CarouselController();
  var loginController = Get.find<LogInController>();
  bool isLoading = true;
  double dotIndex = 0.0;
  bool obxTxt = true;

  List<Widget> imageSliders = ['assets/slider1.png', 'assets/slider2.png', 'assets/slider3.png', 'assets/slider4.png']
      .map(
        (item) => SizedBox(
          width: 700.w,
          height: 600.h,
          child: Image.asset(
            item,
            fit: BoxFit.fill,
          ),
        ),
      )
      .toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        Stack(
          children: [
            Container(
              width: 960.w,
              height: 1080.h,
              color: const Color(0xff2CB4B3),
              child: SvgPicture.asset(
                'assets/login.svg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 35.h,
              left: 39.w,
              child: Container(
                width: 38.w,
                height: 38.w,
                child: Image.asset(
                  'assets/loginLeftLog.png',
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Positioned(
                top: 148.h,
                left: 115.w,
                child: Container(
                  width: 509.w,
                  height: 250.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyText(txt: 'Design for individuals', color: whiteColor, fontweight: FontWeight.w300, size: 50.sp),
                      Text(
                        '''See the analytics and grow your work remotely.from anywhere''',
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25.sp, color: Colors.white),
                      ),
                      DotsIndicator(
                        dotsCount: 4,
                        position: dotIndex,
                        onTap: (val) {
                          controller.jumpToPage(val.toInt());
                        },
                        decorator: DotsDecorator(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          size: const Size(20.0, 6.0),
                          activeSize: const Size(40.0, 6.0),
                          activeColor: whiteColor,
                          color: whiteColor,
                          spacing: EdgeInsets.only(right: 2.w),
                          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                        ),
                      )
                    ],
                  ),
                )),
            Positioned(
              bottom: 0.h,
              right: 0.h,
              child: Container(
                width: 730.w,
                height: 430.h,
                child: CarouselSlider(
                  carouselController: controller,
                  options: CarouselOptions(
                      scrollDirection: Axis.vertical,
                      viewportFraction: 1.0,
                      autoPlay: true,
                      onPageChanged: ((index, reason) {
                        setState(() {
                          dotIndex = index.toDouble();
                        });
                      })),
                  items: imageSliders,
                ),
              ),
            )
          ],
        ),
        SizedBox(
          width: 960.w,
          height: 1080.h,
          child: Column(
            children: [
              SizedBox(height: 110.h),
              SizedBox(
                width: 140.w,
                height: 120.h,
                child: Image.asset('assets/triviaLogo.png'),
              ),
              Container(
                width: 430.w,
                height: 112.h,
                margin: EdgeInsets.only(top: 66.h),
                child: Row(
                  children: [
                    MyText(
                      txt: 'Trivia',
                      color: Color(0xff2CB4B3),
                      fontweight: FontWeight.w800,
                      size: 90.sp,
                    ),
                    MyText(
                      txt: ' star',
                      color: Color(0xff2CB4B3),
                      fontweight: FontWeight.w300,
                      size: 90.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              MyText(
                txt: 'TEACHERS',
                color: Colors.black,
                fontweight: FontWeight.w600,
                size: 25.sp,
              ),
              Container(
                width: 572.w,
                height: 27.h,
                margin: EdgeInsets.only(top: 50.h, bottom: 66.h),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: greyColor, width: 1.h)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 5.w, bottom: 5.h),
                  child: TextField(
                    controller: loginController.email,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      hintStyle: TextStyle(color: greyColor, fontSize: 20.sp),
                    ),
                  ),
                ),
              ),
              Container(
                width: 572.w,
                height: 27.h,
                margin: EdgeInsets.only(bottom: 66.h),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: greyColor, width: 1.h)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 530.w,
                      margin: EdgeInsets.only(left: 5.w, bottom: 5.h),
                      child: TextField(
                        controller: loginController.password,
                        obscureText: obxTxt,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(color: greyColor, fontSize: 20.sp),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (obxTxt) {
                            obxTxt = false;
                          } else {
                            obxTxt = true;
                          }
                        });
                      },
                      child: Container(
                        width: 32.w,
                        height: 15.h,
                        child: !obxTxt ? SvgPicture.asset('assets/eyeHide.svg') : SvgPicture.asset('assets/eyeShow.svg'),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  isLoading = true;
                  if (isLoading) {
                    Get.dialog(Container(
                      child: Center(child: CircularProgressIndicator()),
                    ));
                  }

                  isLoading = await loginController.loginBtnClick();
                  setState(() {});
                  if (!isLoading) {
                    Navigator.pop(context);
                  } else {
                    await pref?.setBool('logedin', true);
                    Get.offAll(Categories());
                  }
                },
                child: MyContainer(
                    180.w,
                    60.h,
                    10.h,
                    Container(
                      margin: EdgeInsets.only(
                        top: 17.h,
                        bottom: 10.h,
                        left: 59.25.w,
                        right: 58.75.w,
                      ),
                      child: MyText(
                        txt: loginBtn,
                        color: basicColor,
                        fontweight: FontWeight.normal,
                        size: 20.sp,
                      ),
                    )),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
