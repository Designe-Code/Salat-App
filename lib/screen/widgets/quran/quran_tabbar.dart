import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:salati/screen/widgets/quran/quran_juz.dart';
// import 'package:provider/provider.dart';
// import 'package:salati/providers/quran_provider.dart';
import 'package:salati/screen/widgets/quran/quran_surah.dart';

class QuranTabBar extends StatelessWidget {
  const QuranTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    // const List<String> tabsName = ['Surah', 'Juz\'', 'Hizb', 'Page'];
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: TabBar(
              labelColor: Theme.of(context).colorScheme.primary,
              dividerHeight: 0,
              unselectedLabelColor: Colors.black,
              overlayColor: const MaterialStatePropertyAll(Colors.transparent),
              indicatorColor: Theme.of(context).colorScheme.primary,
              indicatorPadding: const EdgeInsets.only(bottom: 10),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0, color: Theme.of(context).colorScheme.primary),
                insets: const EdgeInsets.symmetric(horizontal: 25),
              ),
              // onTap: (activeTabIndex) {
              //   Provider.of<QuranProvider>(context, listen:false).setCurrentTab(tabsName[activeTabIndex]);
              // },
              tabs: const [
                Tab(text: 'Surah'),
                Tab(text: 'Juz\''),
                Tab(text: 'Hizb'),
                Tab(text: 'Page'),
              ]
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height *0.532,
            child: const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                QuranSurah(),
                QuranJuz(),
                Center(child: Text('3')),
                Center(child: Text('4')),
              ]
            ),
          )
        ],
      ),
    );
  }
}