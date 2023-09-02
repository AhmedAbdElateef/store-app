import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CoustomTextForm extends StatelessWidget {
  CoustomTextForm(
      {super.key,
      this.prefIcon,
      this.prefIconColor,
      this.suffixIcone,
      this.onChange,
      this.validator,
      this.onSubmitt,
      this.controller,
      this.textStyle,
      this.suffixIconeColor,
      required this.passwordText,
      required this.label,
      required this.text,
      required this.museTextColor,
      required this.borderColor,
      required this.borderReduse,
      required this.labelColor,
      required this.userTextColor});
  Color userTextColor;
  Color museTextColor;
  bool passwordText;
  double? textStyle;
  Color? prefIconColor;
  Color? suffixIconeColor;
  Color labelColor;
  Color borderColor;
  double borderReduse;
  TextEditingController? controller;
  Function(String)? onChange;
  FormFieldValidator<String>? validator;
  Function(String)? onSubmitt;
  IconData? prefIcon;
  IconButton? suffixIcone;
  TextInputType text;
  String label;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onFieldSubmitted: onSubmitt,
      onChanged: onChange,
      obscureText: passwordText,
      style: TextStyle(color: userTextColor, fontSize: textStyle),
      cursorColor: museTextColor,
      keyboardType: text,
      decoration: InputDecoration(
          suffixIcon: suffixIcone,
          suffixIconColor: suffixIconeColor,
          prefixIconColor: prefIconColor,
          prefixIcon: Icon(prefIcon),
          labelText: label,
          labelStyle: TextStyle(color: labelColor),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderReduse),
              borderSide: BorderSide(color: borderColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderReduse),
              borderSide: BorderSide(color: borderColor)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(borderReduse))),
    );
  }
}
