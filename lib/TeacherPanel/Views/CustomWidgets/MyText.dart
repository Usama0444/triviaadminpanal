import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyText extends StatelessWidget {
  var size, fontweight, color, txt;
  MyText({
    Key? key,
    required this.txt,
    required this.color,
    required this.fontweight,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      textAlign: TextAlign.center,
      overflow: TextOverflow.visible,
      style: TextStyle(
        fontSize: size,
        fontWeight: fontweight,
        color: color,
      ),
    );
  }
}
