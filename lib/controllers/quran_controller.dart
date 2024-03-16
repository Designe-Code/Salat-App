import 'package:quran/quran.dart';
import 'package:salati/models/quran.dart';
import 'package:salati/services/shared_preferences_service.dart';

class QuranController {
  List<Surah> listSurah = [];
  List<Juz> listJuz = [];
  List<Hizb> listHizb = [];

  List<List<int>> hizbData = [
	// [sura, aya]
	[1, 1], [2, 75], [2, 142], [2, 203], [2, 253], [3, 15], [3, 93], [3, 171], [4, 24], [4, 88],
	[4, 148], [5, 27], [5, 82], [6, 36], [6, 111], [7, 1], [7, 88], [7, 171], [8, 41], [9, 34],
	[9, 93], [10, 26], [11, 6], [11, 84], [12, 53], [13, 19], [15, 1], [16, 51], [17, 1], [17, 99], 
	[18, 75], [20, 1], [21, 1], [22, 1], [23, 1], [24, 21], [25, 21], [26, 111], [27, 56], [28, 51],
	[29, 46], [31, 22], [33, 31], [34, 24], [36, 28], [37, 145], [39, 32], [40, 41], [41, 47], [43, 24], 
	[46, 1], [48, 18], [51, 31], [55, 1], [58, 1], [62, 1], [67, 1], [72, 1], [78, 1], [87, 1]
];

  // -------------------- fill list ---------------------------
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

  void setListHizb() {
    for (int i = 0; i < hizbData.length; i++) {
      listHizb.add(
        Hizb(
          hizbNumber: i + 1,
          firstVerse: getVerse(hizbData[i][0], hizbData[i][1]),
          firstVerseNumber: hizbData[i][1],
          pageOfFirstVerse: getPageNumber(hizbData[i][0], hizbData[i][1]),
          firstSurahNumber: hizbData[i][0],
          firstSurahName: getSurahName(hizbData[i][0])
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

  // -------------------- book mark ---------------------------
  Future<List<String>> getPagesBookMarksList() async {
    List<String> pagesBookMarksList = await SharedPreferencesService.getListOfString('pagesBookMarksList');
    return pagesBookMarksList;
  }

  void addPageToPagesBookMarksList(int page) async {
    List<String> pagesBookMarksList = await getPagesBookMarksList();
    pagesBookMarksList.add(page.toString());
    SharedPreferencesService.saveListOfString('pagesBookMarksList', pagesBookMarksList);
  }

  void removePageFromPagesBookMarksList(int page) async {
    List<String> pagesBookMarksList = await getPagesBookMarksList();
    pagesBookMarksList.remove(page.toString());
    SharedPreferencesService.saveListOfString('pagesBookMarksList', pagesBookMarksList);
  }

  Future<List<BookMark>> getBookMarksList() async {
    List<String> pagesBookMarksList = await getPagesBookMarksList();
    
    List<BookMark> bookMarkList = pagesBookMarksList.map((page) {
      return BookMark(
          surahName: getSurahName(getPageData(int.parse(page))[0]['surah']),
          juzNumber: getJuzNumber(getPageData(int.parse(page))[0]['surah'], getPageData(int.parse(page))[0]['end']),
          pageNumber: int.parse(page)
      );
    }).toList();
    return bookMarkList;
  }

  Future<bool> isPageInPagesBookMarksList(int page) async {
    List<String> pagesBookMarksList = await getPagesBookMarksList();
    return pagesBookMarksList.contains(page.toString());
  }

  // -------------------- last read ---------------------------
  Future<int> getLastReadPage() async {
    int lastReadPage = await SharedPreferencesService.getInt('lastReadPage');
    return lastReadPage;
  }

  void setLastReadPage(int page) async {
    SharedPreferencesService.saveInt('lastReadPage', page);
  }
}