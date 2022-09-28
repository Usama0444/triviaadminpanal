import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyText extends StatelessWidget {
  var size, fontweight, color, txt, maxline;
  TextAlign align;
  MyText({
    Key? key,
    required this.txt,
    required this.color,
    this.maxline = 1,
    this.align = TextAlign.center,
    required this.fontweight,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      textAlign: align,
      maxLines: maxline,
      style: TextStyle(
        fontSize: size,
        fontWeight: fontweight,
        color: color,
      ),
    );
  }
}
