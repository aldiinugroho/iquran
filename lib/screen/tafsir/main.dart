import 'package:flutter/material.dart';
import 'package:iquran/components/customheader/main.dart';
import 'package:iquran/constants/customcolor.dart';
import 'package:iquran/screen/tafsir/components/tafsirdetail.dart';
import 'package:iquran/screen/tafsir/store/storetafsirdetail.dart';
import 'package:iquran/usecases/tafsir/main.dart';
import 'package:provider/provider.dart';

class TafsirScreen extends StatelessWidget {
  final String tafsirId;
  final String ayatId;
  const TafsirScreen({super.key, required this.tafsirId, required this.ayatId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.baseGrayScreen,
      body: ComponentBody(
        ayatId: ayatId,
        tafsirId: tafsirId,
      ),
    );
  }
}

class ComponentBody extends StatefulWidget {
  final String tafsirId;
  final String ayatId;
  const ComponentBody(
      {super.key, required this.ayatId, required this.tafsirId});

  @override
  State<ComponentBody> createState() => _ComponentBodyState();
}

class _ComponentBodyState extends State<ComponentBody> {
  late StoreTafsirDetail _storeTafsirDetail = context.read<StoreTafsirDetail>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Usecasetafsir.getTafsirDetail(
          context: context, ayatId: widget.ayatId, tafsirId: widget.tafsirId);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _storeTafsirDetail.resetData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomHeader(),
        Expanded(
            child: RefreshIndicator(
          color: CustomColor.baseGreen,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const TafsirDetail(),
                ),
              )
            ],
          ),
          onRefresh: () async {
            Usecasetafsir.getTafsirDetail(
                context: context,
                ayatId: widget.ayatId,
                tafsirId: widget.tafsirId);
          },
        ))
      ],
    );
  }
}
