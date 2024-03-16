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

class Hizb {
  Hizb({
    required this.hizbNumber,
    required this.firstVerse,
    required this.firstVerseNumber,
    required this.pageOfFirstVerse,
    required this.firstSurahName,
    required this.firstSurahNumber
  });

  int hizbNumber = 1;
  String firstVerse = '';
  int firstVerseNumber = 1;
  int pageOfFirstVerse = 1;
  String firstSurahName = '';
  int firstSurahNumber = 1;
}

class BookMark {
  BookMark({
    required this.surahName,
    required this.juzNumber,
    required this.pageNumber,
  });

  String surahName = '';
  int juzNumber = 1;
  int pageNumber = 1;

  @override
  bool operator ==(Object other) {
    return identical(this, other)
    || other is BookMark
      && runtimeType == other.runtimeType
      && surahName == other.surahName
      && juzNumber == other.juzNumber
      && pageNumber == other.pageNumber;
  }

  @override
  int get hashCode => surahName.hashCode ^ juzNumber.hashCode ^ pageNumber.hashCode;
}