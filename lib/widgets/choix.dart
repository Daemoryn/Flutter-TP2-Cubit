import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Choix extends StatelessWidget {
  String text;
  double fontSize;
  Color primary;
  Color onPrimary;
  Function() function;

  Choix(
      {required this.text,
      this.fontSize = 50,
      required this.primary,
      this.onPrimary = Colors.black,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: primary, onPrimary: onPrimary),
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.width * 0.10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
