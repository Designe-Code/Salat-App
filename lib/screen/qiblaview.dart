import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salati/controllers/qibla_controller.dart';
import 'package:salati/models/qibla_location.dart';

class QbilaView extends StatefulWidget {
  final QiblaController controller;

  const QbilaView({super.key, required this.controller});

  @override
  State<QbilaView> createState() => _QbilaViewState();
}

class _QbilaViewState extends State<QbilaView> {
  Position? currentPosition;
  Location? qiblaSide;
  @override
  void initState() {
    super.initState();
    widget.controller.getCurrentLocation().then((currentPositionValue) {
      currentPosition = currentPositionValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qibla Direction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Latitude: ${currentPosition?.latitude}'),
            Text('Longitude: ${currentPosition?.longitude}'),
            SizedBox(height: 20),
             ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.controller
                              .getQiblaDirection()
                              .then((qiblaDirectionValue) {
                            qiblaSide = qiblaDirectionValue;
                          });
                        });
                      },
                      child: Text('Fetch Qibla Direction'),
                    ),
            
            const SizedBox(height: 20),
            Text(
              'Qibla Direction: ${qiblaSide?.direction ?? "Not available"}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
