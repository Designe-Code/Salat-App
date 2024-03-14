import 'package:salati/controllers/qibla_controller.dart';
import 'package:salati/controllers/prayer_controller.dart';
import 'package:salati/controllers/quran_controller.dart';

const String appName = 'Salati';

//api
const String prayerByCityApiUrl = 'http://api.aladhan.com/v1/timingsByCity';
const String qiblaApiUrl = 'http://api.aladhan.com/v1/qibla';

//images
const String logo = 'assets/images/logo.png';
const String splashScreenBackground =
    'assets/images/splash_screen_background.png';
const String mosque = 'assets/images/mosque.png';
const String quran = 'assets/images/quran.png';
const String adkar = 'assets/images/adkar.png';
const String tasbih = 'assets/images/tasbih.png';
const String homeIconNavBar = 'assets/images/home_navbar.png';
const String homeIconActiveNavBar = 'assets/images/home_active_navbar.png';
const String qiblaNavBar = 'assets/images/qibla.png';
const String qiblaActiveNavBar = 'assets/images/qibla_active.png';
const String tasbihNavBar = 'assets/images/tasbih_navbar.png';
const String tasbihActiveNavBar = 'assets/images/tasbih_active_navbar.png';
const String headerBackground = 'assets/images/header_background.png';
const String smallLogo = 'assets/images/small_logo.png';
const String sunrise = 'assets/images/sunrise.png';
const String morning = 'assets/images/morning.png';
const String noon = 'assets/images/noon.png';
const String afternoon = 'assets/images/asr.png';
const String sunset = 'assets/images/maghrib.png';
const String evening = 'assets/images/evening.png';
const String smallFajr = 'assets/images/small_fajr.png';
const String smallSunrise = 'assets/images/small_sunrise.png';
const String smallDuhr = 'assets/images/small_duhr.png';
const String smallAsr = 'assets/images/small_asr.png';
const String smallMaghrib = 'assets/images/small_maghrib.png';
const String smallIshaa = 'assets/images/small_ishaa.png';
const String activeBell = 'assets/images/active_bell.png';
const String inactiveBell = 'assets/images/inactive_bell.png';
const String compass = 'assets/images/qiblacompass.png';
const String quranHeaderBackground =
    'assets/images/quran_header_background.png';
const String quranTable = 'assets/images/quran_table.png';
const String quranItemNumber = 'assets/images/quran_item_number.png';
const String morningdikr = 'assets/images/morningdikr.jpg';
const String morninghigh = 'assets/images/morninghigh.png';
const String eveningdikr = 'assets/images/eveningdikr.jpg';
const String eveninghigh = 'assets/images/eveningdikrhigh.jpg';
const String nightdikr = 'assets/images/nightdikr.jpg';
const String fantasy = 'assets/images/fantasy.jpg';

// controllers
PrayerController prayerController = PrayerController();
QiblaController qiblaController = QiblaController();
QuranController quranController = QuranController();

