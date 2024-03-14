import 'package:flutter/material.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/screen/widgets/quran/widgets/juz_item.dart';

class QuranJuz extends StatelessWidget {
  const QuranJuz({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: quranController.listJuz.length,
      itemBuilder: (context, index) {
        return JuzItem(juz: quranController.listJuz[index]);
      }
    );
  }
}