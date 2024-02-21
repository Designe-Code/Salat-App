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