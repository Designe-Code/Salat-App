import 'package:flutter/material.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/screen/eveningdikr_screen.dart';
import 'package:salati/screen/morningdikr_screen.dart';
import 'package:salati/screen/sleepingdikr_screen.dart';
import 'package:salati/screen/widgets/adkar/dikr_container.dart';

class AdkarScreen extends StatelessWidget {
  AdkarScreen({super.key});

  final List<Map<String, dynamic>> dikrData = [
    {
      'image': morningdikr,
      'text1': 'Morning Remembrance',
      'text2': 'ادكار الصباح',
      'route': '/morning_dikr',
    },
    {
      'image': eveningdikr,
      'text1': 'Evening Remembrance',
      'text2': 'ادكار المساء',
      'route': '/evening_dikr',
    },
    {
      'image': nightdikr,
      'text1': 'Sleeping Remembrance',
      'text2': 'ادكار النوم',
      'route': '/night_dikr',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        toolbarHeight: 50,
        elevation: 0,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 16),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Center(
            child:
                Text('Adkhar', style: Theme.of(context).textTheme.bodyMedium),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 25),
        child: ListView.builder(
          itemCount: dikrData.length,
          itemBuilder: (context, index) {
            return DikrContainer(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      switch (dikrData[index]['route']) {
                        case '/morning_dikr':
                          return const MorningDikrScreen();
                        case '/evening_dikr':
                          return const  EveningScreenDikr();
                        case '/night_dikr':
                          return const SleepingDikrScreen();
                        default:
                          return Container();
                      }
                    },
                  ),
                );
              },
              imageAsset: dikrData[index]['image'],
              firstText: dikrData[index]['text1'],
              secondText: dikrData[index]['text2'],
            );
          },
        ),
      ),
    );
  }
}
