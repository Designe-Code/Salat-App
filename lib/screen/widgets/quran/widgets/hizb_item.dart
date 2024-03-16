import 'package:flutter/material.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/helper/functions.dart';
import 'package:salati/models/quran.dart';
import 'package:salati/screen/quran_image_screen.dart';

class HizbItem extends StatelessWidget {
  const HizbItem({super.key, required this.hizb});

  final Hizb hizb;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22,15,22,5),
      child: GestureDetector(
        onTap: () {
          navigateTo(context, QuranImageScreen(page: hizb.pageOfFirstVerse));
        },
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(60),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE0E0E0).withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: const Offset(-1, -1),
                  ),
                  BoxShadow(
                    color: const Color(0xFFE0E0E0).withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(-5, 5),
                  ),
                  BoxShadow(
                    color: const Color(0xFFE0E0E0).withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(5, -5),
                  ),
                ],
              ),
              
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(quranItemNumber),
                              fit: BoxFit.cover
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${hizb.hizbNumber}',
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              height: 19,
                              child: ClipRect(
                                child: Text(
                                  hizb.firstVerse,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                            Text(
                              'Surat ${hizb.firstSurahName}, Ayah ${hizb.firstVerseNumber}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 11
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).colorScheme.primary
                      ),
                      padding: const EdgeInsets.all(0),
                      alignment: Alignment.center,
                      child: Text(
                        '${hizb.pageOfFirstVerse}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.background
                        )
                      )
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}