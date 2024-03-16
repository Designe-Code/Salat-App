import 'package:flutter/material.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/screen/widgets/quran/widgets/hizb_item.dart';

class QuranHizb extends StatelessWidget {
  const QuranHizb({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: quranController.listHizb.length,
      itemBuilder: (context, index) {
        return HizbItem(hizb: quranController.listHizb[index]);
      }
    );
  }
}