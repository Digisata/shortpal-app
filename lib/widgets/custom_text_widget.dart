import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    required this.text,
    required this.color,
    Key? key,
    this.fontFamily = 'SF Pro Display',
    this.fontSize = 20.0,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.normal,
    this.isUderline = false,
    this.isStrikethrough = false,
  }) : super(key: key);

  final String text, fontFamily;
  final Color color;
  final double fontSize;
  final int maxLines;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final bool isUderline;
  final bool isStrikethrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      textDirection: TextDirection.ltr,
      style: TextStyle(
        color: color,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: FontStyle.normal,
        decoration: isUderline
            ? TextDecoration.underline
            : isStrikethrough
                ? TextDecoration.lineThrough
                : TextDecoration.none,
      ),
    );
  }
}
