import 'package:flutter/foundation.dart';
import 'package:iquran/screen/tafsir/models/modeltafsirdetail.dart';

class StoreTafsirDetail with ChangeNotifier {
  ModelTafsirDetail? _data;
  bool _loading = false;
  String? _errMsg;
  ModelTafsirDetail? get data => _data;
  bool get loading => _loading;
  String? get errMsg => _errMsg;

  void setLoading() {
    _loading = true;
    _data = null;
    _errMsg = null;
    notifyListeners();
  }

  void setData({ModelTafsirDetail? data}) {
    _data = data;
    _loading = false;
    notifyListeners();
  }

  void setError({required String err}) {
    _data = null;
    _errMsg = err;
    _loading = false;
    notifyListeners();
  }

  void resetData() {
    _data = null;
    _loading = false;
    _errMsg = null;
    notifyListeners();
  }
}
