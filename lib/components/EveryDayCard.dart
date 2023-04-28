import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../Controller/myController.dart';

class EveryDayCard extends StatelessWidget {
  const EveryDayCard({
    super.key,
    required this.time,
    required this.dailyIcon,
    required this.base,
    required this.second,
    required this.directionofRadius,
    required this.radius,
    required this.height,
    required this.maxTemp,
    required this.minTemp,
  });
  final String time;
  final FaIcon dailyIcon;
  final Color base;
  final Color second;
  final Alignment directionofRadius;
  final BorderRadiusGeometry radius;
  final double height;
  final int? maxTemp;
  final int? minTemp;
  @override
  Widget build(BuildContext context) {
    Map size = Provider.of<MyController>(context).responsive(context);
    return Container(
      width: size['orientation'] == Orientation.landscape
          ? size['width'] * 0.17
          : size['width'] * 0.28,
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
                color: Colors.white, fontWeight: FontWeight.bold),
            child: DefaultTextStyle(
              style: TextStyle(
                  fontSize: size['orientation'] == Orientation.portrait
                      ? size['width'] * 0.03
                      : size['width'] * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(time, style: const TextStyle(fontSize: 18)),
                  dailyIcon,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.arrow_upward,
                          color: Colors.white, size: 15),
                      Text(
                        '$maxTemp ',
                        // style: const TextStyle(fontSize: 15),
                      ),
                      const Text('O', style: TextStyle(fontSize: 7)),
                      const Text('/', style: TextStyle(fontSize: 15)),
                      const Icon(Icons.arrow_downward_sharp,
                          color: Colors.white, size: 15),
                      Text(
                        '$minTemp ',
                        // style: const TextStyle(fontSize: 15),
                      ),
                      const Text('O', style: TextStyle(fontSize: 7)),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
