// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:salati/controllers/tasbih_controller.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/models/prayer_data.dart';
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
                Image(
                  image: AssetImage(smallLogo),
                ),
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
                HomeNavBarContainer(
                  tasbihController: widget.tasbihController,
                  city: 'Ouarzazate'
                ),
                const SizedBox(height: 10),
                HomeTimeContainer(),
                const SizedBox(height: 10),
                HomePrayerContainer()
              ],
            ),
          ),
        )
      ],
    );
  }
}
