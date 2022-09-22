import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputFieldWidget extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? textChanged;
  final bool obscureText;
  final Color hasFocusColor;
  final Color hitColor;
  final double fontSize;
  final FontWeight fontWeight;
  final int maxLines;
  final double lineHeight;
  final List<TextInputFormatter>? textInputFormatters;
  final ValueChanged<String>? onChanged;
  TextEditingController controller;
  final int maxLength;

  TextInputFieldWidget(
      {Key? key,
      this.hintText = "",
      required this.maxLength,
      required this.controller,
      this.textChanged,
      this.obscureText = false,
      this.hasFocusColor = const Color(0xFF303133),
      this.hitColor = const Color(0xFFC0C4CC),
      required this.fontSize,
      this.lineHeight = 1,
      required this.maxLines,
      this.onChanged,
      required this.fontWeight,
      this.textInputFormatters})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TextInputFieldWidgetState();
  }
}

class _TextInputFieldWidgetState extends State<TextInputFieldWidget> {
  final _textEditingController = TextEditingController();
  String inputText = "";
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _textEditingController.addListener(_handleTextInput);
    super.initState();
  }

  void _handleTextInput() {
    widget.textChanged?.call(_textEditingController.text);
    setState(() {
      inputText = _textEditingController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      maxLines: widget.maxLines,
      controller: widget.controller,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      maxLength: widget.maxLength,
      inputFormatters: [...?widget.textInputFormatters],
      style: TextStyle(
        fontSize: widget.fontSize,
        height: widget.lineHeight,
        color: Colors.black,
        fontWeight: widget.fontWeight,
      ),
      decoration: const InputDecoration(
        counterText: '',
        border: InputBorder.none,
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
