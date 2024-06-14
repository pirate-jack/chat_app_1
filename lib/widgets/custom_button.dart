import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  @override
  String text;
  Color backgroundColor;
  Color textColor;
  VoidCallback ontap;

  CustomButton(
      {required this.text,
        required this.backgroundColor,
        required this.textColor,
        required this.ontap});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        child: Center(child: Text(text,style: TextStyle(color: textColor,fontSize: 18),)),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(color: backgroundColor,borderRadius: BorderRadius.circular(30),),
      ),
    );
  }
}