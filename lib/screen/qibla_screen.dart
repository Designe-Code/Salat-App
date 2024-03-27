import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/screen/widgets/qibla/compass_container.dart';

import '../controllers/qibla_controller.dart';

class QiblaScreen extends StatefulWidget {
  final QiblaController controller;
  const QiblaScreen({super.key, required this.controller});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  Position? currentPosition;
  bool activeCompass = false;
  @override
  void initState() {
    super.initState();
    if (currentPosition != null) {
      activeCompass = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: const CircleBorder(),
          onPressed: () {
            widget.controller.getCurrentLocation().then((currentPositionValue) {
              setState(() {
                currentPosition = currentPositionValue;
                activeCompass = true;
              });
            });
          },
          child: const Image(image: AssetImage(qiblaAccuracy)),
        ),
      ),
      body: Builder(
        builder: (context) {
          return Column(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Qibla", style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
              activeCompass
                ? StreamBuilder<CompassEvent>(
                  stream: FlutterCompass.events,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                          'Error reading heading: ${snapshot.error}');
                    }

                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    double? direction = snapshot.data!.heading;

                    if (direction == null) {
                      return const Center(
                        child: Text("Device does not have sensors !"),
                      );
                    }
                    return Transform.rotate(
                        angle: (direction * (math.pi / 180) * -1),
                        child: const CompassContainer());
                  })
                : const Center(child: CompassContainer()),
            ],
          );
        },
      ),
    );
  }
}
