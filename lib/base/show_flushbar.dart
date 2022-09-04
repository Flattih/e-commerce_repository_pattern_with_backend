import 'package:another_flushbar/flushbar.dart';
import 'package:e_commerce/utils/colors.dart';

import 'package:flutter/material.dart';

showCustomSnackBar(
    {String title = "Error",
    required BuildContext context,
    required String message,
    Color bgColor = AppColors.mainColor,
    Duration duration = const Duration(seconds: 2)}) {
  Flushbar(
          title: title,
          backgroundColor: bgColor,
          margin: const EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(8),
          flushbarPosition: FlushbarPosition.TOP,
          message: message,
          duration: duration)
      .show(context);
}
