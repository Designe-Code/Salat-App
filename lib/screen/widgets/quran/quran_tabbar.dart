import 'package:flutter/material.dart';
import 'package:salati/screen/widgets/quran/quran_book_mark.dart';
import 'package:salati/screen/widgets/quran/quran_hizb.dart';
import 'package:salati/screen/widgets/quran/quran_juz.dart';

import 'quran_surah.dart';

class QuranTabBar extends StatelessWidget {
  const QuranTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          SizedBox(
            child: TabBar(
                labelPadding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.06),
                tabAlignment: TabAlignment.center,
                labelColor: Theme.of(context).colorScheme.primary,
                dividerHeight: 0,
                unselectedLabelColor: Colors.black,
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                indicatorColor: Theme.of(context).colorScheme.primary,
                indicatorPadding: const EdgeInsets.only(bottom: 10),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                      width: 2.0, color: Theme.of(context).colorScheme.primary),
                  insets: const EdgeInsets.symmetric(horizontal: 25),
                ),
                tabs: const [
                  Tab(text: 'Surah'),
                  Tab(text: 'Juz\''),
                  Tab(text: 'Hizb'),
                  Tab(text: 'bookMark'),
                ]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.532,
            child: const TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  QuranSurah(),
                  QuranJuz(),
                  QuranHizb(),
                  QuranBookMark(),
                ]),
          )
        ],
      ),
    );
  }
}
