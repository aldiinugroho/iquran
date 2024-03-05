import 'package:flutter/material.dart';
import 'package:iquran/request/tafsir/main.dart';
import 'package:iquran/screen/tafsir/models/modeltafsirdetail.dart';
import 'package:iquran/screen/tafsir/store/storetafsirdetail.dart';
import 'package:provider/provider.dart';

class Usecasetafsir {
  static Future<void> getTafsirDetail(
      {required BuildContext context,
      required String ayatId,
      required String tafsirId}) async {
    StoreTafsirDetail store = context.read<StoreTafsirDetail>();
    try {
      store.setLoading();
      var result = await RequestTafsir.get(path: '/$tafsirId');
      if (result.status != "OK") throw result;
      final dynamic raw = result.data['data'];
      final List<dynamic> tafsir = result.data['data']['tafsir'];
      final List<dynamic> selected =
          tafsir.where((e) => e['ayat'] == int.parse(ayatId)).toList();
      final ModelTafsirDetail mapped = ModelTafsirDetail(
          namaLatin: raw['namaLatin'],
          nama: raw['nama'],
          artinama: raw['arti'],
          jumlahAyat: raw['jumlahAyat'],
          tempatturun: raw['tempatTurun'],
          tafsirAyat: ayatId,
          tafsirTeks: selected.isEmpty ? '' : selected[0]['teks']);
      store.setData(data: mapped);
    } catch (e) {
      store.setError(err: e.toString());
    }
  }
}
