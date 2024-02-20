// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/providers/prayer_provider.dart';
import 'package:salati/providers/splash_provider.dart';
import 'package:salati/screen/navbar_screen.dart';
import 'package:salati/services/prayer_service.dart';
import 'package:salati/services/shared_preferences_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final prayerProvider = context.read<PrayerProvider>();
      prayerProvider.setTimings();
    });
    Future.delayed(const Duration(seconds: 1), () {
      PrayerService.getPrayerTimings(city: 'Ouarzazate', country: 'Maroc')
      .then((timings) {
        SharedPreferencesService.setStringData('timings', jsonEncode(timings));
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final prayerProvider = context.read<PrayerProvider>();
        prayerProvider.setTimings();
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    final splashProvider = context.watch<SplashProvider>();
    return splashProvider.isFirstLaunch
      ? Scaffold(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(splashScreenBackground),
                fit: BoxFit.cover
              )
            ),
            child: Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.4,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(image: AssetImage(logo)),
                      ],
                    ),
                  )
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.8,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            await splashProvider.setFirstLaunchSeen();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const NavBarScreen()),
                            );
                          },
                          child: Container(
                            width: 68,
                            height: 68,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onBackground,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      : const NavBarScreen();
  }
}
