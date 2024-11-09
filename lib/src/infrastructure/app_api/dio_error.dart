import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'error/custom_exception.dart';
import 'error/error_model.dart';

class CustomizeDioError extends DioError {
  final RequestOptions options;
  CustomizeDioError({error, required this.options})
      : super(requestOptions: options, error: error);
  factory CustomizeDioError.fromImage() {
    return CustomizeDioError(options: RequestOptions(path: ''), error: '');
  }
  factory CustomizeDioError.fromResponse(DioError e) {
    late dynamic finalError;
    // debugPrint(e.error.toString());
    // debugPrint(e.message);
    // debugPrint(e.stackTrace.toString());

    if (e.response == null) {
      final errorModel = ErrorModel(message: ['Timeout Exception']);
      return CustomizeDioError(
        error: errorModel,
        options: e.requestOptions,
      );
    }
    switch (e.response!.statusCode) {
      case 400:
      case 404:
        final errorModel = ErrorModel.fromMap(e.response!.data);
        finalError = BadRequestException(errorModel.toString());
        break;
      case 500:

      default:
        finalError = const FetchDataException(
            'Error was occurred while Communication with Server with StatusCode');
        break;
    }
    return CustomizeDioError(
      error: finalError!,
      options: e.requestOptions,
    );
  }
}
