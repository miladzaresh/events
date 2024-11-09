import 'dart:convert';
import 'package:events/src/infrastructure/common/repository_url.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' as getX;
import 'dio_error.dart';
class AppApi with DioMixin implements Dio {


  AppApi() {
    options = BaseOptions(
      baseUrl: 'http://localhost:3000',
      contentType: 'application/json',
      connectTimeout: Duration(milliseconds: 300000),
      sendTimeout: Duration(milliseconds: 300000),
      receiveTimeout: Duration(milliseconds: 300000),
    );
    interceptors.add(
      InterceptorsWrapper(
        onResponse: (response,handler){
          handler.next(response);
          // print(response.data);
        },
        onRequest: (options, handler) async {
          print(options.uri);
          options.headers.addAll(await _getHeader());
          handler.next(options);
        },
        onError: (e, handler) async {
          return handler.next(
            CustomizeDioError.fromResponse(e),
          );
        },

      ),
    );
    httpClientAdapter = HttpClientAdapter();
  }



  Future<Map<String, String>> _getHeader() async {
    return {
      "Content-Type": "application/json",
    };
  }

  Future<Response> getAsync(String url, {Map<String, String>? headers}) async {
    var response = await get(
        url,
        options: Options(headers: headers?? await _getHeader())
    );
    return response;
  }

  Future<Response> putAsync(String url,
      {Map<String, dynamic>? data,Map<String, dynamic>? header,}) async {
    var response = await put(
      url,
      data: jsonEncode(data),
      options: Options(headers: header ?? await _getHeader())
    );

    return response;
  }
  Future<Response> deleteAsync(String url,
      {Map<String, dynamic>? data,Map<String, dynamic>? header,}) async {
    var response = await delete(
      url,
      data: jsonEncode(data),
      options: Options(headers: header ?? await _getHeader())
    );

    return response;
  }


  Future<Response> postAsync(String url,Map<String, dynamic>? data,{Map<String ,String>? headers}) async {
    var response = await post(
        url,
        data: data,
        options: Options(headers: headers ?? await _getHeader())
    );
    return response;
  }
  Future<Response> patchAsync(String url,Map<String, dynamic>? data,{Map<String ,String>? headers}) async {
    var response = await patch(
        url,
        data: data,
        options: Options(headers: headers ?? await _getHeader())
    );
    return response;
  }
  Future<Response> postAsyncFile(String url,FormData data,{Map<String ,String >? headers}) async {
    var response = await post(
        url,
        data: data,
        options: Options(headers: headers ?? await _getHeader())
    );
    return response;
  }

}
