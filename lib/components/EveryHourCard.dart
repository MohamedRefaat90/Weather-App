import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/Controller/myController.dart';

class EveryHourCard extends StatelessWidget {
  const EveryHourCard({
    super.key,
    required this.time,
    required this.icon,
    required this.temp,
    required this.base,
    required this.second,
    required this.directionofRadius,
    required this.radius,
    required this.height,
    required this.margin,
  });
  final String time;
  final IconData icon;
  final String temp;
  final Color base;
  final Color second;
  final Alignment directionofRadius;
  final BorderRadiusGeometry radius;
  final double height;
  final double margin;
  @override
  Widget build(BuildContext context) {
  Map  size = Provider.of<MyController>(context).responsive(context);
    return Container(
      width: size['orientation'] == Orientation.landscape? size['width'] * 0.17 : size['width'] * 0.28,
      margin: EdgeInsets.only(right: margin),
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
                Text(time, style: const TextStyle(fontSize: 18)),
                Icon(icon, size: 50, color: Colors.white),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$temp ',
                      style: const TextStyle(fontSize: 15),
                    ),
                    const Text('O', style: TextStyle(fontSize: 7)),
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
