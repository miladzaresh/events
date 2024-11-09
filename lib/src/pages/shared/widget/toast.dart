import 'package:get/get.dart';
import 'package:flutter/material.dart';

void showToast(String message, bool isError) {
  Get.showSnackbar(GetSnackBar(
    message: message,
    backgroundColor: isError ? Colors.red : Colors.green,
    icon: Icon(
      isError
          ? Icons.error_outline_outlined
          : Icons.check_circle_outline_outlined,
      color: Colors.white,
      size: 24,
    ),
    duration: Duration(seconds: 2),
  ));
}
