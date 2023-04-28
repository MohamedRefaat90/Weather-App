import 'package:flutter/material.dart';

import 'WeatherEveryDay.dart';
import 'WeatherEveryHour.dart';

class TabBarContent extends StatelessWidget {
  const TabBarContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 220,
      child: TabBarView(children: [
        WeatherEveryHour(),
        WeatherEveryDay()
      ]),
    );
  }
}