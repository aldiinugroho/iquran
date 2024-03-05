import 'package:iquran/services/main.dart';
import 'package:iquran/services/models/handlerapi.dart';

String mainPath = "/tafsir";

class RequestTafsir {
  static Future<HandlerApi> get({String? path = ""}) async {
    try {
      final result = await Services().get(path: "$mainPath$path");
      return result;
    } catch (e) {
      throw e;
    }
  }
}
