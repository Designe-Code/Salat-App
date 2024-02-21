import 'package:quran/quran.dart';
import 'package:salati/models/quran.dart';

class QuranController {
  List<Surah> listSurah = [];

  void setListSurah() {
    for (int i = 1; i <= totalSurahCount; i++) {
      listSurah.add(
        Surah(
          surahNumber: i,
          name: getSurahName(i),
          arabicName: getSurahNameArabic(i),
          listOfpageNumbers: getSurahPages(i))
      );
    }
  }
}