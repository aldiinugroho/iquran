import 'package:flutter/material.dart';
import 'package:iquran/constants/customcolor.dart';
import 'package:iquran/constants/customfontsize.dart';
import 'package:iquran/screen/detail/components/detaillistview/store/storedetaillist.dart';
import 'package:provider/provider.dart';

class DetailSurat extends StatefulWidget {
  const DetailSurat({
    super.key,
  });

  @override
  State<DetailSurat> createState() => _DetailSuratState();
}

class _DetailSuratState extends State<DetailSurat> {
  @override
  Widget build(BuildContext context) {
    double screenwdth = MediaQuery.of(context).size.width;
    StoreDetailList store = context.watch<StoreDetailList>();
    return store.loading == true
        ? Container(
            width: screenwdth,
            height: screenwdth / 6,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: CustomColor.baseGrayLoading,
            ),
          )
        : store.data == null
            ? Container()
            : Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: CustomColor.baseGreen,
                ),
                width: screenwdth,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('${store.data?.namaLatin} - ${store.data?.nama}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: CustomFontSize.large)),
                    Container(height: 5),
                    Text(
                        '${store.data?.artinama} - ${store.data?.jumlahAyat} ayat - ${store.data?.tempatturun}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: CustomFontSize.medium3)),
                    Container(height: 5),
                    Text(store.data?.deskripsi ?? '',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: CustomFontSize.medium1))
                  ],
                ));
  }
}
