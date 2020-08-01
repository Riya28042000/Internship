import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final TextEditingController controller;
  Box({this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(

    //  color: Colors.grey,
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 3),
    alignment: Alignment.center,
    height: 50,
    width: 50,

    child: TextField(
      controller: controller,
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      maxLength: 1,
      decoration: InputDecoration(border: InputBorder.none, counterText: ''),
    ),
    decoration: BoxDecoration(
        border: Border.all(color: Color(0xfff1f1f1)),
        color: Color(0xfff1f1f1),
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
  }
}