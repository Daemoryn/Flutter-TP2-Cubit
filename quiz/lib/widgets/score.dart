import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  String text;
  int? number;
  Color? colorBackground;
  EdgeInsets? padding;
  double? textFontSize;
  Color? textColor;

  Score({required this.text,
    this.number = 0,
    this.colorBackground = Colors.black87,
    this.padding = const EdgeInsets.all(20.0),
    this.textFontSize = 20.0,
    this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
        child: Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: Text(text + number.toString(),
              style: TextStyle(fontSize: textFontSize, color: textColor)),
          color: colorBackground,
          padding: padding,
        ));
  }
}