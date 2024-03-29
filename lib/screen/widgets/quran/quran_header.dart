import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/helper/functions.dart';
import 'package:salati/providers/quran_provider.dart';
import 'package:salati/screen/quran_image_screen.dart';

class QuranHeader extends StatelessWidget {
  const QuranHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: 200,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(quranHeaderBackground),
            fit: BoxFit.fill
          )
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Consumer<QuranProvider>(
            builder: (context, quranProvider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(image: AssetImage(quranTable)),
                      const SizedBox(width: 10),
                      Text('Last read', style: Theme.of(context).textTheme.bodySmall)
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text('Surah', style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.background
                  )),
                  const SizedBox(height: 5),
                  FutureBuilder(
                    future: quranController.getLastReadPage(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          getSurahName(getPageData(snapshot.data ?? 1)[0]['surah']),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.background
                          )
                        );
                      }
                      return const SizedBox();
                    }
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: 170,
                    child: FutureBuilder(
                      future: quranController.getLastReadPage(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.background,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              )
                            ),
                            onPressed: () {
                              navigateTo(context, QuranImageScreen(page: snapshot.data ?? 1));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Back to reading', style: Theme.of(context).textTheme.bodySmall),
                                const Icon(Icons.arrow_forward_ios_outlined, size: 15, color: Colors.black)
                              ],
                            )
                          );
                        }
                        return const SizedBox();
                      }
                    )
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}