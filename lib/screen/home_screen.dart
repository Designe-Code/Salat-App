import 'package:flutter/material.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/screen/widgets/custom_icon_button.dart';
import 'package:salati/screen/widgets/home_time_container.dart';
import 'package:salati/screen/widgets/location.dart';
import 'package:salati/screen/widgets/next_adan.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(headerBackground),
              alignment: Alignment.topLeft,
              fit: BoxFit.fitWidth
            )
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.065,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage(smallLogo),),
              ],
            ),
          )
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.17,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NextAdan(nextAdan: 'Duhr', time: '01:38 PM'),
                            Location(location: 'Ouarzazate')
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: const Divider(thickness: 0.8)
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomIconButton(
                              heroTag: 'mosque_button',
                              icon: 'assets/images/mosque.png',
                              iconlabel: 'Mosque',
                              onPressed: () {}
                            ),
                            CustomIconButton(
                              heroTag: 'quran_button',
                              icon: 'assets/images/quran.png',
                              iconlabel: 'Quran',
                              onPressed: () {}
                            ),
                            CustomIconButton(
                              heroTag: 'adkar_button',
                              icon: 'assets/images/adkar.png',
                              iconlabel: 'Adkar',
                              onPressed: () {}
                            ),
                            CustomIconButton(
                              heroTag: 'tasbih_button',
                              icon: 'assets/images/tasbih.png',
                              iconlabel: 'Tasbih',
                              onPressed: () {}
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ),
                const SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const HomeTimeContainer(
                    time: '12:27',
                    date: 'Tuesday 23 Jumada II 1445',
                    icon: 'assets/images/asr.png'
                  )
                ),
                const SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  height: MediaQuery.of(context).size.height * 0.31,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}