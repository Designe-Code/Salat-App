import 'package:salati/models/tasbih_data.dart';

class TasbihController {
  List<TasbihData> tasbihs = [
    TasbihData(
      tasbihArab: "سبحان الله",
      tasbihArabEng: "subhan allah",
      tasbihEnglish: "Glory be to Allah",
    ),
    TasbihData(
      tasbihArab: "الحمد لله",
      tasbihArabEng: "alhamdulillah",
      tasbihEnglish: "Praise be to Allah",
    ),
    TasbihData(
      tasbihArab: "الله اكبر",
      tasbihArabEng: "allahu akbar",
      tasbihEnglish: "Allah is the Greatest",
    ),
  ];

  int currentTasbihIndex = 0;

  TasbihData getCurrentTasbih() {
    return tasbihs[currentTasbihIndex];
  }

  void moveToNextTasbih() {
    currentTasbihIndex = (currentTasbihIndex + 1) % tasbihs.length;
  }
}
