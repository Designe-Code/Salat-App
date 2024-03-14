import 'package:flutter/material.dart';

class DikrContainer extends StatelessWidget {
  const DikrContainer({
    super.key,
    required this.onTap,
    required this.imageAsset,
    required this.firstText,
    required this.secondText,
  });

  final String firstText;
  final String imageAsset;
  final VoidCallback onTap;
  final String secondText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x3A000000),
                    blurRadius: 1,
                    offset: Offset(0, 2),
                    spreadRadius: 1,
                  )
                ],
              ),
              width: double.infinity,
              height: 100,
              child: Image.asset(
                imageAsset,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 160,
                    child: Text(
                      firstText,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  Text(secondText,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
