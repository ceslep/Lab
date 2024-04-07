import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lab/widgets/toastmsg.dart';

Future<void> showToastB(
  FToast fToast,
  String message, {
  ToastGravity gravity = ToastGravity.TOP,
  int milliseconds = 1000,
  Color bacgroundColor = Colors.white,
}) async {
  final toast = Toastmsg(
    message: message,
    toast: fToast,
    backgroundColor: bacgroundColor,
    frontColor: Colors.black,
  );

  // Await a Timer to simulate async behavior (optional)
  await Future.delayed(Duration(milliseconds: milliseconds));

  // Show the toast directly inside the future
  fToast.showToast(
    child: toast,
    gravity: gravity,
    toastDuration: const Duration(seconds: 2),
  );
}
