import 'package:quran/quran.dart';
import 'package:salati/models/quran.dart';

class QuranController {
  List<Surah> listSurah = [];
  List<Juz> listJuz = [];

  void setListSurah() {
    for (int i = 1; i <= totalSurahCount; i++) {
      listSurah.add(
        Surah(
          surahNumber: i,
          name: getSurahName(i),
          arabicName: getSurahNameArabic(i),
          listOfpageNumbers: getSurahPages(i)
        )
      );
    }
  }

  void setListJuz() {
    for (int i = 1; i <= totalJuzCount; i++) {
      listJuz.add(
        Juz(
          juzNumber: i,
          firstVerse: getVerse(_getFirstKey(getSurahAndVersesFromJuz(i)), getSurahAndVersesFromJuz(i)[_getFirstKey(getSurahAndVersesFromJuz(i))]?[0] ?? 1, verseEndSymbol: false),
          firstVerseNumber: getSurahAndVersesFromJuz(i)[_getFirstKey(getSurahAndVersesFromJuz(i))]?[0] ?? 1,
          pageOfFirstVerse: getPageNumber(_getFirstKey(getSurahAndVersesFromJuz(i)), getSurahAndVersesFromJuz(i)[_getFirstKey(getSurahAndVersesFromJuz(i))]?[0] ?? 1),
          firstSurahNumber: _getFirstKey(getSurahAndVersesFromJuz(i)),
          firstSurahName: getSurahName(_getFirstKey(getSurahAndVersesFromJuz(i)))
        )
      );
    }
  }

  int _getFirstKey(Map<int, dynamic> map) {
    for (var entry in map.entries) {
      return entry.key;
    }
    return 1;
  }
}