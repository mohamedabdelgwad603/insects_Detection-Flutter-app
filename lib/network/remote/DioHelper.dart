import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://mysterious-castle-43049.herokuapp.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postData(
      {required String url,
      required Map<String, dynamic> data,
      String lang = 'en',
      String? token,
      Map<String, dynamic>? query}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? ''
    };

    return await dio!.post(url, data: data, queryParameters: query);
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? ''
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> getDataV2({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? ''
    };
    return await dio!.get(url, queryParameters: query, options: Options());
  }

  static Future<Response> postDataLogin(
      {required String url,
      required Map<String, dynamic> data,
      String lang = 'en',
      Map<String, dynamic>? query}) async {
    return await Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
          'lang': lang,
        })).post(url, data: data, queryParameters: query);
  }
}
