import 'package:flutter/material.dart';
import 'package:iquran/constants/assets.dart';
import 'package:iquran/constants/customcolor.dart';
import 'package:iquran/constants/customfontsize.dart';

class MainHeader extends StatefulWidget {
  const MainHeader({super.key});

  @override
  State<MainHeader> createState() => _MainHeaderState();
}

class _MainHeaderState extends State<MainHeader> {
  @override
  Widget build(BuildContext context) {
    double screenwdth = MediaQuery.of(context).size.width;
    double safePadding = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(
          top: safePadding + 10, bottom: 10, left: 10, right: 10),
      color: CustomColor.baseGreen,
      width: screenwdth,
      height: screenwdth / 2,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('IQURAN INDONESIA',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: CustomFontSize.large2)),
        Expanded(
          child: Center(
            child: Image.asset(
              ImagesLocal.mosque,
              height: 70,
              width: 70,
            ),
          ),
        )
      ]),
    );
  }
}
