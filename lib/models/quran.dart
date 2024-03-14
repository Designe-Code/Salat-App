class Surah {
  Surah({
    required this.surahNumber,
    required this.name,
    required this.arabicName,
    required this.listOfpageNumbers
  });

  int surahNumber = 0;
  String name = '';
  String arabicName = '';
  List<int> listOfpageNumbers = [];
}

class Juz {
  Juz({
    required this.juzNumber,
    required this.firstVerse,
    required this.firstVerseNumber,
    required this.pageOfFirstVerse,
    required this.firstSurahName,
    required this.firstSurahNumber
  });

  int juzNumber = 1;
  String firstVerse = '';
  int firstVerseNumber = 1;
  int pageOfFirstVerse = 1;
  String firstSurahName = '';
  int firstSurahNumber = 1;
}