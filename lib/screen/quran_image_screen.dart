import 'package:flutter/material.dart';
import 'package:salati/screen/widgets/quran_image/quran_image_container.dart';
import 'package:salati/screen/widgets/quran_image/quran_image_tab_bar.dart';

class QuranImageScreen extends StatelessWidget {
  const QuranImageScreen({
    super.key,
    required this.page
  });

  final int page;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          QuranImageContainer(initialPage: page),
          const QuranImageNavBar() 
        ],
      ),
    );
  }
}