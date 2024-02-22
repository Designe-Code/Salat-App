import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salati/screen/widgets/qibla/compass_container.dart';

import '../controllers/qibla_controller.dart';

class QiblaTest extends StatefulWidget {
  final QiblaController controller;
  const QiblaTest({super.key, required this.controller});

  @override
  State<QiblaTest> createState() => _QiblaTestState();
}

class _QiblaTestState extends State<QiblaTest> {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.controller.getCurrentLocation().then((currentPositionValue) {
            setState(() {
              currentPosition = currentPositionValue;
              activeCompass = true;
            });
          });
        },
        child: const Icon(Icons.center_focus_strong),
      ),
      body: Builder(
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  : const CompassContainer(),
            ],
          );
        },
      ),
    );
  }
}
