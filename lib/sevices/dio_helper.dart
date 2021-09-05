import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.43.25:8080/api/v1/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> query,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json;charset=UTF-8',
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    @required String url,
    @required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    return dio.post(
      url,
      data: data,
    );
  }

  static Future<Response> putData({
    @required String url,
    @required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
    };

    return dio.put(
      url,
      data: data,
    );
  }
}
