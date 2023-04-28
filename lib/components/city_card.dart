import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather/Controller/myController.dart';
import 'package:weather/Models/Weather_Model.dart';
import 'package:intl/intl.dart';

import '../Services/Location_Service.dart';

class CityCard extends StatelessWidget {
  const CityCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WeatherModel? weatherData = Provider.of<MyController>(context).weatherData;
    List<dynamic>? weatherState =
        Provider.of<MyController>(context).weatherStates(0);
    Map size = Provider.of<MyController>(context).responsive(context);
    var lastUpdate = DateFormat('jm').format(DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Weather Icon
        Lottie.asset(weatherState[0],
            height: size['orientation'] == Orientation.portrait
                ? size['height'] * 0.15
                : size['height'] * 0.30),

        // Weather State
        Text(
          weatherState[1],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${weatherData!.tmp.toInt()}',
                style:
                    const TextStyle(fontSize: 50, fontWeight: FontWeight.w500)),
            const Text('O', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        Text('Last Update at : $lastUpdate'),
        Text(city,
            style: const TextStyle(
                fontSize: 23,
                color: Color(0xffA1A3A5),
                fontWeight: FontWeight.bold))
      ],
    );
  }
}
