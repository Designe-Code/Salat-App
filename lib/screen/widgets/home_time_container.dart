import 'package:flutter/material.dart';

class HomeTimeContainer extends StatelessWidget{
  const HomeTimeContainer({super.key, required this.time, required this.date, required this.icon});

  final String icon;
  final String time;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(time, style: Theme.of(context).textTheme.bodyLarge),
                Text(
                  date,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black.withOpacity(0.5)
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.51,
          height: 130,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.08,
                  child: Container(
                    width: 210,
                    height: 210,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.4),
                      shape: BoxShape.circle
                    ), 
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.14,
                  child: Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.6),
                      shape: BoxShape.circle
                    ), 
                  ),
                ),
                Container(
                    width: 120,
                    height: MediaQuery.of(context).size.height * 0.16,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.8),
                      shape: BoxShape.circle
                    ),
                    child: Image(image: AssetImage(icon)),
                  ),
              ]
            ),
          ),
        )
      ],
    );
  }
}