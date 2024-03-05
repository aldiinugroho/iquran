import 'package:dio/dio.dart';
import 'package:iquran/secret/main.dart';
import 'package:iquran/services/models/handlerapi.dart';

String? _mainUrl = Secret.keyUrl;

class Services {
  Future<HandlerApi> _handlerApi(
      {dynamic data, int? statusCode = 0, dynamic err}) async {
    try {
      if (err != null || statusCode == null) throw Exception(err);
      if (statusCode >= 200 && statusCode <= 299) {
        final result = HandlerApi(data: data, message: "SUCCESS", status: "OK");
        return result;
      } else if (statusCode >= 300 && statusCode <= 399) {
        throw 'FAILED STATUS 3XX';
      } else if (statusCode >= 400 && statusCode <= 499) {
        throw 'FAILED STATUS 4XX';
      } else if (statusCode >= 500 && statusCode <= 599) {
        throw 'FAILED STATUS 5XX';
      } else {
        throw 'Error unknown status code!';
      }
    } catch (e) {
      if (e.runtimeType == String) {
        throw e;
      } else {
        throw e.toString();
      }
    }
  }

  Future<HandlerApi> get({String? path = ""}) async {
    try {
      final dio = Dio();
      final response = await dio.get('$_mainUrl$path');
      final result = await _handlerApi(
          data: response.data, statusCode: response.statusCode);
      return result;
    } catch (err) {
      final result = await _handlerApi(err: err);
      throw result;
    }
  }
}
