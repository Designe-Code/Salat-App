import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/models/adhkar.dart';
import 'package:salati/screen/widgets/adkar/dikr_screen.dart';

import 'widgets/adkar/dikr_contollers.dart';

class SleepingDikrScreen extends StatefulWidget {
  const SleepingDikrScreen({super.key});

  @override
  State<SleepingDikrScreen> createState() => _SleepingDikrScreenState();
}

class _SleepingDikrScreenState extends State<SleepingDikrScreen> {
  List<Array> adhkarList = [];
  int countValue = 0;
  int currentIndex = 0;

  final Future<List<Adhkar>> _adhkarFuture = loadAdhkars();

  void nextDikr() {
    setState(() {
      currentIndex = (currentIndex + 1) % adhkarList.length;
      countValue = 0;
    });
  }

  void previousDikr() {
    setState(() {
      currentIndex = (currentIndex - 1 + adhkarList.length) % adhkarList.length;
      countValue = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const DikrScreen(imageAsset: eveninghigh),
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 160, 32, 50),
          child: FutureBuilder<List<Adhkar>>(
            future: _adhkarFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final selectedCategory = snapshot.data!.firstWhere(
                  (adhkar) => adhkar.category == 'أذكار الصباح والمساء',
                  orElse: () => snapshot.data!.first,
                );
                adhkarList = selectedCategory.array;
                return adhkarList.isNotEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Text(selectedCategory.array[currentIndex].text,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.amiri(
                                  color: Colors.white,
                                  fontSize: 20,
                                )),
                            DikrControls(
                              countText: adhkarList[currentIndex].count,
                              countValue: countValue,
                              currentIndex: currentIndex,
                              totalAdhkar: adhkarList.length,
                              previousDikr: () {
                                previousDikr();
                              },
                              nextDikr: () {
                                nextDikr();
                              },
                              onTap: () {
                                setState(() {
                                  if (countValue <
                                      adhkarList[currentIndex].count) {
                                    countValue++;
                                  } else {
                                    countValue = 0;
                                    nextDikr();
                                  }
                                });
                              },
                            )
                          ])
                    : const Text('No adhkar found'); // la kant list khawya
              } else if (snapshot.hasError) {
                return const Text('Error loading data'); // hada d l errors
              }
              return const Center(
                  child: CircularProgressIndicator()); // Loading
            },
          ),
        )
      ]),
    );
  }
}
