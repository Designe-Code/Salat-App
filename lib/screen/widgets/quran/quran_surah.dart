import 'package:flutter/material.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/screen/widgets/quran/widgets/quran_item.dart';

class QuranSurah extends StatelessWidget {
  const QuranSurah({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: quranController.listSurah.length,
      itemBuilder: (context, index) {
        return QuranItem(surah: quranController.listSurah[index]);
      }
    );
  }
}