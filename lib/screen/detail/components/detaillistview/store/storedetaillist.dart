import 'package:flutter/foundation.dart';
import 'package:iquran/screen/detail/components/detaillistview/models/modeldetaillv.dart';

class StoreDetailList with ChangeNotifier {
  ModelDetailLv? _data;
  bool _loading = false;
  String? _errMsg;
  ModelDetailLv? get data => _data;
  bool get loading => _loading;
  String? get errMsg => _errMsg;

  void setLoading() {
    _loading = true;
    _data = null;
    _errMsg = null;
    notifyListeners();
  }

  void setData({ModelDetailLv? data}) {
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
