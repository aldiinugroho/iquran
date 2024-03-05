import 'package:iquran/screen/detail/components/detaillistview/store/storedetaillist.dart';
import 'package:iquran/screen/main/store/storemainlist.dart';
import 'package:iquran/screen/tafsir/store/storetafsirdetail.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => StoreMainList()),
  ChangeNotifierProvider(create: (_) => StoreDetailList()),
  ChangeNotifierProvider(create: (_) => StoreTafsirDetail()),
];
