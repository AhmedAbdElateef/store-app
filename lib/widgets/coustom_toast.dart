import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void coustomToast({
  required String message,
  required Color bgColor,
  required Color textColor,
  required Toast lengthMessage,
  required ToastGravity whereMessage,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: lengthMessage,
      gravity: whereMessage,
      timeInSecForIosWeb: 5,
      backgroundColor: bgColor,
      textColor: textColor,
      fontSize: 16.0);
}
