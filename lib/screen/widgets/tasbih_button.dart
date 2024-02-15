import 'package:flutter/material.dart';

class TasbihButton extends StatefulWidget {
  const TasbihButton({Key? key}) : super(key: key);

  @override
  State<TasbihButton> createState() => _TasbihButtonState();
}

class _TasbihButtonState extends State<TasbihButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;

  bool isBouncing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _positionAnimation = Tween(begin: 0.0, end: 180.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack, // Adjust the curve as needed
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 277,
      height: 92,
      padding: const EdgeInsets.only(top: 9, left: 8, right: 8, bottom: 9),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(58),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x7FE6E6E6),
            blurRadius: 5,
            offset: Offset(-1, -1),
            spreadRadius: 3,
          ),
          BoxShadow(
            color: Color(0x4CFFFFFF),
            blurRadius: 2,
            offset: Offset(1, 1),
            spreadRadius: 2,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isBouncing = !isBouncing;
            if (isBouncing) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          });
        },
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _positionAnimation,
              builder: (context, child) {
                return Positioned(
                  right: _positionAnimation.value,
                  child: child!,
                );
              },
              child: Container(
                width: 74,
                height: 74,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.71, -0.71),
                    end: Alignment(-0.71, 0.71),
                    colors: [Color(0xFF38E9BB), Color(0xFF30FDC8)],
                  ),
                  shape: CircleBorder(),
                  shadows: [
                    BoxShadow(
                      color: Color(0xE5C3C3C3),
                      blurRadius: 5,
                      offset: Offset(2, 2),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Color(0xE5EFEFEF),
                      blurRadius: 4,
                      offset: Offset(-2, -2),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Color(0x33C3C3C3),
                      blurRadius: 4,
                      offset: Offset(2, -2),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Color(0x33C3C3C3),
                      blurRadius: 4,
                      offset: Offset(-2, 2),
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
