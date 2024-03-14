import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DikrControls extends StatefulWidget {
  const DikrControls({
    super.key,
    required this.currentIndex,
    required this.countValue,
    required this.totalAdhkar,
    required this.previousDikr,
    required this.nextDikr,
    required this.onTap,
    required this.countText,
  });

  final int countText;
  final int countValue;
  final int currentIndex;
  final Function() nextDikr;
  final Function() onTap;
  final Function() previousDikr;
  final int totalAdhkar;

  @override
  State<DikrControls> createState() => _DikrControlsState();
}

class _DikrControlsState extends State<DikrControls> {
  int clickIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${widget.currentIndex + 1} / ${widget.totalAdhkar}',
          style: const TextStyle(color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: widget.previousDikr,
              child: const Icon(
                Icons.chevron_left_outlined,
                color: Colors.amber,
                size: 45,
              ),
            ),
            CircularPercentIndicator(
              animateFromLastPercent: widget.countValue == 0 ? false : true,
              restartAnimation: false,
              animationDuration: 500,
              animation: true,
              percent: widget.countValue / widget.countText,
              radius: 55,
              backgroundColor: Colors.white,
              progressColor: Colors.amber,
              center: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  widget.onTap();
                  setState(() {
                    clickIndex + 1;
                  });
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: const ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.71, -0.71),
                      end: Alignment(-0.71, 0.71),
                      colors: [Colors.white, Color(0xFFE9E9E9)],
                    ),
                    shape: OvalBorder(),
                    shadows: [
                      BoxShadow(
                        color: Color(0xE5626262),
                        blurRadius: 3,
                        offset: Offset(1, 1),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0xE5FFFFFF),
                        blurRadius: 2,
                        offset: Offset(-1, -1),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x33626262),
                        blurRadius: 2,
                        offset: Offset(1, -1),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Color(0x33626262),
                        blurRadius: 2,
                        offset: Offset(-1, 1),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Center(child: Text('${widget.countValue}')),
                ),
              ),
            ),
            GestureDetector(
              onTap: widget.nextDikr,
              child: const Icon(
                Icons.chevron_right_outlined,
                color: Colors.amber,
                size: 45,
              ),
            )
          ],
        ),
        const SizedBox(height: 25),
        Text(
          '${widget.countText}',
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
