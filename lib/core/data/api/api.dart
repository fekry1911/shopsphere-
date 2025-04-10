import 'package:dio/dio.dart';

import '../../const/const.dart';

class DioHelper
{
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          "Content-Type":"application/json"
        }
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    String? token,
    Map<String, dynamic>? query,
  }) async
  {
    dio!.options.headers={
      "Content-Type":"application/json",
      "lang":lang,
      "Authorization":token??""
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String path,
    String? token,
     Map<String, dynamic>? data,
  }) async
  {
    dio!.options.headers={
      "Content-Type":"application/json",
      "lang":lang,
      "Authorization":token??""
    };
    return await dio!.post(path,
    data: data
    );
  }
  static Future<Response> putData({
    required String path,
    String? token,
    required Map<String, dynamic> data,
  }) async
  {
    dio!.options.headers={
      "Content-Type":"application/json",
      "lang":lang,
      "Authorization":token??""
    };
    return await dio!.put(path,
        data: data
    );
  }
  static Future<Response> deleteData({
    required String path,
    String? token,
     Map<String, dynamic>? data,
  }) async
  {
    dio!.options.headers={
      "Content-Type":"application/json",
      "lang":lang,
      "Authorization":token??""
    };
    return await dio!.delete(path,
        data: data
    );
  }
}