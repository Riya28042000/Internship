import 'package:flutter/material.dart';

class TexFormField extends StatelessWidget {
  TexFormField({this.text,this.hinttext,this.inputType,this.onchanged,this.onSubmit,this.obscure});
  final TextEditingController text;
  final String hinttext;
  final TextInputType inputType;
  final void Function(String) onchanged;
  final void Function(String) onSubmit;
  final bool obscure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: text,
                 obscureText: obscure,
                    cursorColor: Colors.black,
                    keyboardType: inputType,
                    decoration: InputDecoration(
                     fillColor: Color(0xfff1f1f1),
                     filled: true,
                      hintText: hinttext,
                      alignLabelWithHint: true,
                            //     labelText: "Email",
                      hintStyle: TextStyle(
                       color: Colors.grey,
                       fontWeight: FontWeight.bold),
                           
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                        color: Color(0xfff1f1f1),
                         style: BorderStyle.solid,
                         width: 2),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                         color: Color(0xfff1f1f1),
                         style: BorderStyle.solid,
                         width: 2),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onSaved: (value) {
                     // email = value;
                    },
                         );
  }
}