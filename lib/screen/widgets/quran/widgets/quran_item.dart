import 'package:flutter/material.dart';
import 'package:quran/quran.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/helper/functions.dart';
import 'package:salati/models/quran.dart';
import 'package:salati/screen/quran_image_screen.dart';

class QuranItem extends StatelessWidget {
  const QuranItem({super.key, required this.surah});

  final Surah surah;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22,15,22,5),
      child: GestureDetector(
        onTap: () {
          navigateTo(context, QuranImageScreen(page: getPageNumber(surah.surahNumber, 1)));
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
                              '${surah.surahNumber}',
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          ),
                        ),
                        const SizedBox(width: 15),
                        Row(
                          children: [
                            Text(
                              surah.name,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              surah.arabicName,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.primary
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      style: ButtonStyle(
                        shape: const MaterialStatePropertyAll(CircleBorder()),
                        backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)
                      ),
                      padding: const EdgeInsets.all(0),
                      iconSize: 30,
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(
                        minWidth: 50,
                        minHeight: 50
                      ),
                      onPressed: () {},
                      icon: Icon(
                        Icons.play_arrow,
                        color: Theme.of(context).colorScheme.background,
                      ),
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