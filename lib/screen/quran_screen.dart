import 'package:flutter/material.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/helper/functions.dart';
import 'package:salati/screen/widgets/quran/quran_header.dart';
import 'package:salati/screen/widgets/quran/quran_tabbar.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  @override
  void initState() {
    super.initState();
    quranController.setListSurah();
    quranController.setListJuz();
    quranController.setListHizb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        toolbarHeight:50,
        elevation: 0,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 16),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => goBack(context),
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Center(child: Text('Quran', style: Theme.of(context).textTheme.bodyMedium))
        ),
      ),
      body: const Column(
        children: [
          SizedBox(height: 20),
          QuranHeader(),
          QuranTabBar()
        ],
      ),
    );
  }
}