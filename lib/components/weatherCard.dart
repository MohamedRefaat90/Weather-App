import 'package:flutter/material.dart';

class weatherCard extends StatelessWidget {
  const weatherCard(
      {super.key,
      required this.time,
      required this.icon,
      required this.temp,
      required this.base,
      required this.second,
      required this.directionofRadius,
      required this.radius,
      required this.height});
  final String time;
  final IconData icon;
  final String temp;
  final Color base;
  final Color second;
  final Alignment directionofRadius;
  final BorderRadiusGeometry radius;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.28,
      height: 230,
      clipBehavior: Clip.hardEdge,
      decoration:
          BoxDecoration(color: base, borderRadius: BorderRadius.circular(20)),
      child: Stack(
        alignment: directionofRadius,
        children: [
          Container(
              width: double.infinity,
              height: height,
              decoration: BoxDecoration(color: second, borderRadius: radius)),
          DefaultTextStyle(
            style: const TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  time,
                  style: const TextStyle(fontSize: 18),
                ),
                Icon(icon, size: 50, color: Colors.white),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$temp '),
                    const Text(
                      'O',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
