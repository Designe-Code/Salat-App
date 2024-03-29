import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/providers/quran_provider.dart';

class QuranImageContainer extends StatefulWidget {
  const QuranImageContainer({
    super.key,
    required this.initialPage,
  });

  final int initialPage;

  @override
  State<QuranImageContainer> createState() => _QuranImageContainerState();
}

class _QuranImageContainerState extends State<QuranImageContainer> {
  String surahName = '';
  int juzaa = 1;

  @override
  void initState() {
    super.initState();
    int surahNumber = getPageData(widget.initialPage)[0]['surah'];
    int verseNumber = getPageData(widget.initialPage)[0]['end'];
    surahName = getSurahName(surahNumber);
    juzaa = getJuzNumber(surahNumber, verseNumber);
    quranController.setLastReadPage(widget.initialPage);
    final quranProvider = context.read<QuranProvider>();
    quranController
        .isPageInPagesBookMarksList(widget.initialPage)
        .then((value) {
      quranProvider.setCurrentPage(widget.initialPage);
      quranProvider.setIsBookMarkActive(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Surah $surahName',
                    style: Theme.of(context).textTheme.bodySmall),
                Text('Juz\'$juzaa',
                    style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          ),
          const SizedBox(height: 10),
          Consumer<QuranProvider>(builder: (context, quranProvider, child) {
            return CarouselSlider.builder(
                options: CarouselOptions(
                    height: MediaQuery.sizeOf(context).height - 200,
                    viewportFraction: 1,
                    initialPage: widget.initialPage - 1,
                    enableInfiniteScroll: false,
                    reverse: true,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (pageViewIndex, carouselPageChangedReason) {
                      int surahNumber =
                          getPageData(pageViewIndex + 1)[0]['surah'];
                      int verseNumber =
                          getPageData(pageViewIndex + 1)[0]['end'];
                      setState(() {
                        surahName = getSurahName(surahNumber);
                        juzaa = getJuzNumber(surahNumber, verseNumber);
                      });
                      quranProvider.setCurrentPage(pageViewIndex + 1);
                      quranController.setLastReadPage(pageViewIndex + 1);
                      quranController
                          .isPageInPagesBookMarksList(pageViewIndex + 1)
                          .then((value) =>
                              quranProvider.setIsBookMarkActive(value));
                    }),
                itemCount: 603,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 0,
                              offset: const Offset(-2, 0),
                              color: Colors.grey.withOpacity(0.5)),
                        ],
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage(quranImagePage(itemIndex + 1)),
                            fit: BoxFit.contain)),
                  );
                });
          }),
        ],
      ),
    );
  }
}
