import 'package:events/events.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
class ApiError {
  static getMessage(DioError error,BuildContext context){
    if(error.response?.statusCode==302){
      return LocaleKeys.error_api_error_404.tr;
    }else if(error.response?.statusCode==401 ||error.response?.statusCode==403 ){
      Get.offAndToNamed(RouteNames.login);
      return LocaleKeys.error_api_error_403.tr;
    }else if(error.response?.statusCode==500){
      return LocaleKeys.error_api_error_404.tr;
    }else if(error.response?.statusCode==405){
      return LocaleKeys.error_api_error_404.tr;
    }else if(error.response?.statusCode==422){
      return LocaleKeys.error_api_error_404.tr;
    }else if(error.type == DioExceptionType.sendTimeout){
      return LocaleKeys.error_api_error_404.tr;
    }else if(error.type == DioExceptionType.badResponse){
      return LocaleKeys.error_api_error_404.tr;
    }else{
      return LocaleKeys.error_api_error_404.tr;
    }
  }
}