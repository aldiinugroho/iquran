import 'package:flutter/foundation.dart';
import 'package:iquran/screen/main/components/mainlistview/models/modelmainlv.dart';

class StoreMainList with ChangeNotifier {
  List<ModelMainLV>? _data = [];
  bool _loading = false;
  String? _errMsg;
  List<ModelMainLV>? get data => _data;
  bool get loading => _loading;
  String? get errMsg => _errMsg;

  void setLoading() {
    _loading = true;
    _data = [];
    _errMsg = null;
    notifyListeners();
  }

  void setData({List<ModelMainLV>? data}) {
    _data = data;
    _loading = false;
    notifyListeners();
  }

  void setError({required String err}) {
    _data = [];
    _errMsg = err;
    _loading = false;
    notifyListeners();
  }

  void resetData() {
    _data = [];
    _loading = false;
    _errMsg = null;
    notifyListeners();
  }
}
