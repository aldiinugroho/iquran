import 'package:flutter/material.dart';
import 'package:iquran/components/customheader/main.dart';
import 'package:iquran/constants/customcolor.dart';
import 'package:iquran/screen/detail/components/detaillistview/main.dart';
import 'package:iquran/screen/detail/components/detaillistview/store/storedetaillist.dart';
import 'package:iquran/screen/detail/components/detailsurat/detailsurat.dart';
import 'package:iquran/usecases/surat/main.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final String detailId;
  const DetailScreen({super.key, required this.detailId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.baseGrayScreen,
      body: ComponentBody(
        detailId: detailId,
      ),
    );
  }
}

class ComponentBody extends StatefulWidget {
  final String detailId;
  const ComponentBody({super.key, required this.detailId});

  @override
  State<ComponentBody> createState() => _ComponentBodyState();
}

class _ComponentBodyState extends State<ComponentBody> {
  late StoreDetailList _storeDetailList = context.read<StoreDetailList>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UseCaseSurat.getSuratDetail(context: context, suratId: widget.detailId);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _storeDetailList.resetData();
  }

  @override
  Widget build(BuildContext context) {
    StoreDetailList store = context.watch<StoreDetailList>();
    return Column(
      children: [
        const CustomHeader(),
        Expanded(
            child: RefreshIndicator(
                color: CustomColor.baseGreen,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: store.errMsg == null
                          ? Container()
                          : Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(store.errMsg ?? 'Error.'),
                            ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const DetailSurat(),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: DetailListView(
                        suratId: widget.detailId,
                      ),
                    )
                  ],
                ),
                onRefresh: () async {
                  UseCaseSurat.getSuratDetail(
                      context: context, suratId: widget.detailId);
                }))
      ],
    );
  }
}
