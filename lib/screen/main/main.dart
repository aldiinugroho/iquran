import 'package:flutter/material.dart';
import 'package:iquran/constants/customcolor.dart';
import 'package:iquran/screen/main/components/mainheader/main.dart';
import 'package:iquran/screen/main/components/mainlistview/main.dart';
import 'package:iquran/screen/main/store/storemainlist.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CustomColor.baseGrayScreen,
      body: ComponentMain(),
    );
  }
}

class ComponentMain extends StatefulWidget {
  const ComponentMain({super.key});

  @override
  State<ComponentMain> createState() => _ComponentMainState();
}

class _ComponentMainState extends State<ComponentMain> {
  late StoreMainList _storeMainList = context.read<StoreMainList>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _storeMainList.resetData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColor.baseGreen,
      child: const Column(
        children: [MainHeader(), MainListView()],
      ),
    );
  }
}
