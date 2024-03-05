import 'package:flutter/material.dart';
import 'package:iquran/request/surat/main.dart';
import 'package:iquran/screen/detail/components/detaillistview/models/modeldetaillv.dart';
import 'package:iquran/screen/detail/components/detaillistview/store/storedetaillist.dart';
import 'package:iquran/screen/main/components/mainlistview/models/modelmainlv.dart';
import 'package:iquran/screen/main/store/storemainlist.dart';
import 'package:iquran/utils/main.dart';
import 'package:provider/provider.dart';

class UseCaseSurat {
  static Future<void> getSuratList({required BuildContext context}) async {
    StoreMainList store = context.read<StoreMainList>();
    try {
      store.setLoading();
      var result = await RequestSurat.get();
      if (result.status != "OK") throw result;
      final List<dynamic> raw = result.data['data'];
      final List<ModelMainLV> mapped = raw
          .map((e) => ModelMainLV(
              nama: e['nama'] ?? '',
              namaLatin: e['namaLatin'] ?? '',
              artinama: e['arti'] ?? '',
              jumlahAyat: e['jumlahAyat'] ?? 0,
              tempatturun: e['tempatTurun'] ?? ''))
          .toList();
      store.setData(data: mapped);
    } catch (e) {
      store.setError(err: e.toString());
    }
  }

  static Future<void> getSuratDetail(
      {required BuildContext context, required String suratId}) async {
    StoreDetailList store = context.read<StoreDetailList>();
    try {
      store.setLoading();
      var result = await RequestSurat.get(path: '/$suratId');
      if (result.status != "OK") throw result;
      final dynamic raw = result.data['data'];
      final List<dynamic> rawayat = result.data['data']['ayat'];
      final List<ModelDetailAyat> mappedayat = rawayat
          .map((e) => ModelDetailAyat(
              nomorAyat: e['nomorAyat'],
              teksArab: e['teksArab'],
              teksLatin: e['teksLatin'],
              teksIndonesia: e['teksIndonesia'],
              audio: ModelDetailAyatAudio(
                  satu: e['audio']['01'],
                  dua: e['audio']['02'],
                  tiga: e['audio']['03'],
                  empat: e['audio']['04'],
                  lima: e['audio']['05'])))
          .toList();
      final ModelDetailLv mapped = ModelDetailLv(
          namaLatin: raw['namaLatin'],
          nama: raw['nama'],
          artinama: raw['arti'],
          jumlahAyat: raw['jumlahAyat'],
          tempatturun: raw['tempatTurun'],
          deskripsi: removeITags(raw['deskripsi']),
          ayat: mappedayat);
      store.setData(data: mapped);
    } catch (e) {
      store.setError(err: e.toString());
    }
  }
}
