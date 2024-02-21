import 'package:flutter/material.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/models/quran.dart';

class QuranItem extends StatelessWidget {
  const QuranItem({super.key, required this.surah});

  final Surah surah;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22,15,22,5),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(60),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 13,
                  offset: const Offset(5, 5),
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
                  FloatingActionButton(
                    heroTag: surah.surahNumber,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    onPressed: () {},
                    child: Icon(
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
    );
  }
}