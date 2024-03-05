class ModelDetailAyatAudio {
  String satu;
  String dua;
  String tiga;
  String empat;
  String lima;
  ModelDetailAyatAudio(
      {required this.satu,
      required this.dua,
      required this.tiga,
      required this.empat,
      required this.lima});
}

class ModelDetailAyat {
  int nomorAyat;
  String teksArab;
  String teksLatin;
  String teksIndonesia;
  ModelDetailAyatAudio audio;
  ModelDetailAyat(
      {required this.nomorAyat,
      required this.teksArab,
      required this.teksLatin,
      required this.teksIndonesia,
      required this.audio});
}

class ModelDetailLv {
  String namaLatin;
  String nama;
  String artinama;
  int jumlahAyat;
  String tempatturun;
  String deskripsi;
  List<ModelDetailAyat> ayat;
  ModelDetailLv(
      {required this.namaLatin,
      required this.nama,
      required this.artinama,
      required this.jumlahAyat,
      required this.tempatturun,
      required this.deskripsi,
      required this.ayat});
}
