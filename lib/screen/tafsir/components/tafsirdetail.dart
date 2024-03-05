import 'package:flutter/material.dart';
import 'package:iquran/constants/customcolor.dart';
import 'package:iquran/constants/customfontsize.dart';
import 'package:iquran/screen/tafsir/store/storetafsirdetail.dart';
import 'package:provider/provider.dart';

class TafsirDetail extends StatefulWidget {
  const TafsirDetail({super.key});

  @override
  State<TafsirDetail> createState() => _TafsirDetailState();
}

class _TafsirDetailState extends State<TafsirDetail> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    StoreTafsirDetail store = context.watch<StoreTafsirDetail>();
    if (store.loading) {
      return Container(
        width: screenwidth,
        height: screenwidth / 3,
        decoration: const BoxDecoration(
            color: CustomColor.baseGrayLoading,
            borderRadius: BorderRadius.all(Radius.circular(10))),
      );
    } else if (store.errMsg != null) {
      return Container(
        padding: const EdgeInsets.all(10),
        child: Text(store.errMsg ?? 'Error.'),
      );
    } else if (store.data == null) {
      return Container();
    } else {
      return Container(
        padding: const EdgeInsets.all(10),
        width: screenwidth,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: CustomColor.baseGreen),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${store.data!.namaLatin} - ${store.data!.nama}',
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: CustomFontSize.medium3)),
            Container(height: 5),
            Text('Tafsir ayat ${store.data!.tafsirAyat}',
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: CustomFontSize.medium3)),
            Container(height: 5),
            Text(store.data!.tafsirTeks,
                style: const TextStyle(
                    color: Colors.white, fontSize: CustomFontSize.medium1))
          ],
        ),
      );
    }
  }
}
