// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salati/controllers/tasbih_controller.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/models/prayer_data.dart';
import 'package:salati/providers/prayer_provider.dart';
import 'package:salati/screen/widgets/home/home_navbar_container.dart';
import 'package:salati/screen/widgets/home/home_prayer_container.dart';
import 'package:salati/screen/widgets/home/home_time_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.tasbihController});

  final TasbihController tasbihController;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Timings>? futurePrayerTiming;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PrayerProvider>(context, listen: false).setTimings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(headerBackground),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth)),
        ),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.065,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(smallLogo),
                    width: 100,
                  ),
                ],
              ),
            )),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.17,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Consumer<PrayerProvider>(
                builder: (context, prayerProvider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HomeNavBarContainer(
                      tasbihController: widget.tasbihController,
                      city: prayerProvider.city),
                  const SizedBox(height: 10),
                  HomeTimeContainer(),
                  const SizedBox(height: 10),
                  HomePrayerContainer()
                ],
              );
            }),
          ),
        )
      ],
    );
  }
}
