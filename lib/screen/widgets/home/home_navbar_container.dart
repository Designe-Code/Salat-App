import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salati/controllers/tasbih_controller.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/helper/functions.dart';
import 'package:salati/providers/prayer_provider.dart';
import 'package:salati/screen/quran_screen.dart';
import 'package:salati/screen/tasbih_screen.dart';
import 'package:salati/screen/widgets/home/widgets/custom_icon_button.dart';
import 'package:salati/screen/widgets/home/widgets/custom_location.dart';
import 'package:salati/screen/widgets/home/widgets/next_adan.dart';

class HomeNavBarContainer extends StatelessWidget {
  const HomeNavBarContainer({
    super.key,
    required this.tasbihController,
    required this.city,
  });

  final TasbihController tasbihController;
  final String city;

  @override
  Widget build(BuildContext context) {
    return  Container(
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
            child: Consumer<PrayerProvider>(
              builder: (context, homeProvider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NextAdan(nextAdan: homeProvider.getNextAdhan()['name'], time: homeProvider.getNextAdhan()['time']),
                    CustomLocation(location: city)
                  ],
                );
              },
            )
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
                  icon: mosque,
                  iconlabel: 'Mosque',
                  onPressed: () {}
                ),
                CustomIconButton(
                  heroTag: 'quran_button',
                  icon: quran,
                  iconlabel: 'Quran',
                  onPressed: () {
                    navigateTo(context, const QuranScreen());
                  }
                ),
                CustomIconButton(
                  heroTag: 'adkar_button',
                  icon: adkar,
                  iconlabel: 'Adkar',
                  onPressed: () {}
                ),
                CustomIconButton(
                  heroTag: 'tasbih_button',
                  icon: tasbih,
                  iconlabel: 'Tasbih',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TasbihScreen(controller: tasbihController)),
                    );
                  }
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}