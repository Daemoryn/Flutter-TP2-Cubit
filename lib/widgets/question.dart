import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  String url;
  double width;
  String text;
  Color? colorBackground;
  EdgeInsets? padding;
  double? textFontSize;
  Color? textColor;
  bool isCorrect;

  Question({required this.url,
    this.width = 500.0,
    required this.text,
    this.colorBackground = Colors.black38,
    this.padding = const EdgeInsets.all(20.0),
    this.textFontSize = 20.0,
    this.textColor = Colors.white,
    required this.isCorrect});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: FadeInDown(
            child: Image.asset(
              url,
              width: width,
            ),
          ),
        ),
        FadeInUp(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              text,
              style: TextStyle(fontSize: textFontSize, color: textColor),
            ),
            color: colorBackground,
            padding: padding,
          ),
        ),
      ],
    );
  }
}