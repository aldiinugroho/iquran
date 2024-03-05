import 'package:flutter/material.dart';
import 'package:iquran/constants/customcolor.dart';
import 'package:iquran/usecases/surat/main.dart';

class Refresher extends StatefulWidget {
  final String wording;
  const Refresher({super.key, required this.wording});

  @override
  State<Refresher> createState() => _RefresherState();
}

class _RefresherState extends State<Refresher> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.wording),
          Container(height: 5),
          InkWell(
            onTap: () {
              UseCaseSurat.getSuratList(context: context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: CustomColor.baseGreen,
              ),
              child: const Text('Refresh.'),
            ),
          )
        ],
      ),
    );
  }
}
