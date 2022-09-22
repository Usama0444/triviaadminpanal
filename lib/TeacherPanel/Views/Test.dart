import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'CustomWidgets/text_input_field_widget.dart';
import 'components/max_word_textinput_formater.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  int _count = 0;
  void chageCount(int count) {
    setState(() {
      _count = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: TextInputFieldWidget(
        //   textInputFormatters: [
        //     FilteringTextInputFormatter.allow(RegExp(r"[a-z\s_-]+")),
        //     MaxWordTextInputFormater(maxWords: 6, currentLength: chageCount),
        //   ],
        //   hintText: "please fill words ",
        //   maxLines: 4,
        //   lineHeight: 1.5,
        // ),
        );
  }
}
