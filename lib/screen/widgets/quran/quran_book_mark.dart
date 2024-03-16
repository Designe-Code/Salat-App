import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salati/helper/constant.dart';
import 'package:salati/providers/quran_provider.dart';
import 'package:salati/screen/widgets/quran/widgets/book_mark_item.dart';

class QuranBookMark extends StatelessWidget {
  const QuranBookMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuranProvider>(
      builder: (context, quranProvider, child) {
        return FutureBuilder(
          future: quranController.getBookMarksList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return BookMarkItem(bookMark: snapshot.data?[index]);
                }
              );
            }
            return const SizedBox();
          },
        );
      },
    );
  }
}