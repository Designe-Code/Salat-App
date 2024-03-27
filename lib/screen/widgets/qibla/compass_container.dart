import 'package:flutter/material.dart';
import 'package:salati/helper/constant.dart';

class CompassContainer extends StatelessWidget {
  const CompassContainer({super.key});

  @override
  Widget build(BuildContext context) {
    Offset distance =  const Offset(-5, 5);
    double blur = 5.0;
    return Center(
      child: Container(
        width: 300,
        height: 300,
        decoration: ShapeDecoration(
           shape: const OvalBorder(),
          color: Colors.white,
          shadows: [
              BoxShadow(
              color: Colors.white,
              offset: -distance,
              blurRadius: blur,
              
              
            ),
            BoxShadow(
              color: Colors.grey.shade400,
              offset: distance,
              blurRadius: blur,
            ),
            
          ],
        ),
        child: Center(
          child: Image.asset(
            compass,
            width: 250,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
