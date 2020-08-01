import 'dart:ffi';

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({this.ontap,this.abc,this.sidecol,this.radius,this.textcol,this.buttoncol});
final VoidCallback ontap;
final Widget abc;
final double radius;
final Color sidecol;
final Color textcol;
final Color buttoncol;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
                    onPressed: () {
                     ontap();
                      print('Button Clicked.');
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(radius)),
                        side: BorderSide(color: sidecol)
                        ),
               child: abc,
                    textColor: textcol,
                    //splashColor: Colors.red,
                    color: buttoncol,
                  );
  }
}