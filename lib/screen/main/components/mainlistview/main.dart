import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iquran/constants/customcolor.dart';
import 'package:iquran/constants/customfontsize.dart';
import 'package:iquran/screen/main/components/mainlistview/components/refresher.dart';
import 'package:iquran/screen/main/store/storemainlist.dart';
import 'package:iquran/usecases/surat/main.dart';
import 'package:provider/provider.dart';

class MainListView extends StatefulWidget {
  const MainListView({super.key});

  @override
  State<MainListView> createState() => _MainListViewState();
}

class _MainListViewState extends State<MainListView> {
  double circularradius = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UseCaseSurat.getSuratList(context: context);
    });
  }

  Widget componentResult({required StoreMainList store}) {
    if (store.loading == true) {
      return Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width / 6,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: CustomColor.baseGrayLoading,
        ),
      );
    } else if (store.errMsg != null && store.loading == false) {
      return Refresher(wording: store.errMsg ?? '');
    } else if (store.data!.isEmpty && store.loading == false) {
      return const Refresher(wording: 'Data empty.');
    } else {
      return ListView.separated(
          padding:
              const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
          itemBuilder: (context, index) {
            int currentIndex = index + 1;
            return InkWell(
              onTap: () {
                context.push('/detail',
                    extra: {'detailId': currentIndex.toString()});
              },
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: CustomColor.baseGreen,
                ),
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        '$currentIndex. ${store.data![index].namaLatin} - ${store.data![index].nama}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: CustomFontSize.medium3)),
                    Text(
                        '${store.data![index].artinama} - ${store.data![index].jumlahAyat} ayat - ${store.data![index].tempatturun}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: CustomFontSize.medium3))
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Container(height: 5);
          },
          itemCount: store.data!.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    StoreMainList store = context.watch<StoreMainList>();
    return Expanded(
        child: Container(
            padding: const EdgeInsets.only(top: 10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: CustomColor.baseGrayScreen,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(circularradius),
                    topRight: Radius.circular(circularradius))),
            child: RefreshIndicator(
                color: CustomColor.baseGreen,
                child: componentResult(store: store),
                onRefresh: () async {
                  UseCaseSurat.getSuratList(context: context);
                })));
  }
}
