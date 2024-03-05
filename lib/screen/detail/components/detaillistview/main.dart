import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iquran/constants/assets.dart';
import 'package:iquran/constants/customcolor.dart';
import 'package:iquran/constants/customfontsize.dart';
import 'package:iquran/screen/detail/components/detaillistview/store/storedetaillist.dart';
import 'package:provider/provider.dart';

class DetailListView extends StatefulWidget {
  final String suratId;
  const DetailListView({super.key, required this.suratId});

  @override
  State<DetailListView> createState() => _DetailListViewState();
}

class _DetailListViewState extends State<DetailListView> {
  bool isPlaying = false;
  int? isPlayingIndex;
  final player = AudioPlayer();

  TextStyle style1 = const TextStyle(
      color: Colors.white,
      fontSize: CustomFontSize.large,
      fontWeight: FontWeight.w700);
  TextStyle style1arab = const TextStyle(
      color: Colors.white,
      fontSize: CustomFontSize.large,
      fontWeight: FontWeight.w700);
  TextStyle style2 = const TextStyle(
      color: Colors.white,
      fontSize: CustomFontSize.medium3,
      fontWeight: FontWeight.w500);
  TextStyle style3 =
      const TextStyle(color: Colors.white, fontSize: CustomFontSize.medium3);

  void playAudio({required String url, required int index}) async {
    try {
      setState(() {
        isPlaying = true;
        isPlayingIndex = index;
      });
      await player.play(UrlSource(url));
    } catch (e) {
      setState(() {
        isPlaying = false;
        isPlayingIndex = null;
      });
      await player.dispose();
    }
  }

  void stopAudio() async {
    try {
      setState(() {
        isPlaying = false;
        isPlayingIndex = null;
      });
      await player.stop();
    } catch (e) {
      setState(() {
        isPlaying = false;
        isPlayingIndex = null;
      });
      await player.dispose();
    }
  }

  void disposeAudio() async {
    try {
      await player.dispose();
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
        isPlayingIndex = null;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    disposeAudio();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    StoreDetailList store = context.watch<StoreDetailList>();
    if (store.loading) {
      return Container(
        width: screenwidth,
        height: screenwidth / 3,
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: CustomColor.baseGrayLoading,
        ),
      );
    } else if (store.data == null) {
      return Container();
    } else {
      return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          itemBuilder: (context, index) {
            double lvwidth = MediaQuery.of(context).size.width;
            return Container(
              width: lvwidth,
              decoration: const BoxDecoration(
                color: CustomColor.baseGreen,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${widget.suratId}:${store.data!.ayat[index].nomorAyat}',
                          style: style1),
                      Container(width: 10),
                      Flexible(
                          child: Text(store.data!.ayat[index].teksArab,
                              style: style1arab, textAlign: TextAlign.right))
                    ],
                  ),
                  Container(height: 30),
                  Text(store.data!.ayat[index].teksLatin, style: style2),
                  Container(height: 2),
                  Text(store.data!.ayat[index].teksIndonesia, style: style3),
                  Container(height: 30),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (!isPlaying) {
                            playAudio(
                                url: store.data!.ayat[index].audio.satu,
                                index: index);
                          } else {
                            stopAudio();
                          }
                        },
                        child: isPlayingIndex == null && isPlaying == false
                            ? Container(
                                margin: const EdgeInsets.only(right: 15),
                                child: Image.asset(ImagesLocal.play,
                                    width: 15, height: 15),
                              )
                            : isPlayingIndex == index && isPlaying
                                ? Container(
                                    margin: const EdgeInsets.only(right: 15),
                                    child: Image.asset(ImagesLocal.stop,
                                        width: 15, height: 15),
                                  )
                                : Container(),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                                color: Colors.white,
                                width: 1,
                                style: BorderStyle.solid)),
                        child: InkWell(
                          onTap: () {
                            context.push('/tafsir', extra: {
                              'tafsirId': widget.suratId.toString(),
                              'ayatId':
                                  store.data!.ayat[index].nomorAyat.toString()
                            });
                          },
                          child: Row(
                            children: [
                              Image.asset(ImagesLocal.quote,
                                  width: 15, height: 15),
                              Container(width: 5),
                              const Text('Tafsir',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: CustomFontSize.medium3))
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Container(height: 10);
          },
          itemCount: store.data!.ayat.length);
    }
  }
}
