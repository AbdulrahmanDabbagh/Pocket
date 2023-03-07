import 'dart:io';

import 'package:dio/dio.dart';
class ApiProvider{
  final dio = Dio();
  ApiProvider(){
    dio.options=BaseOptions(
      responseType: ResponseType.plain,
      baseUrl: "https://api.exchangerate.host/convert?from=USD&to=SYR"
    );
    dio.interceptors.add(LogInterceptor(requestBody: true,responseBody: true));
  }
  get({required String url, required Function(String) onSuccess, required Function(String) onError}){
    return request(url: url, onSuccess: onSuccess, onError: onError, method: "GET");
  }

  post({required String url, required Function(String) onSuccess, required Function(String) onError, dynamic data}){
    return request(url: url, onSuccess: onSuccess, onError: onError, method: "POST",data: data);
  }

  request({required String url, required Function(String) onSuccess, required Function(String) onError, required String method, dynamic data}) async {
    try {
      final response = await dio.request(url, options: Options(method: method),data: data);
      if(response.statusCode == 200 || response.statusCode == 201){
        onSuccess(response.data);
      } else{
        onError("status code: ${response.statusCode}");
      }
    } on DioError catch(e){
      if(e.error is SocketException && (e.error as SocketException).osError?.errorCode == 7){
        onError("No internet connection");
      } else {
        onError(e.error.toString());
      }
    }
  }
}