import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/Models/Weather_Model.dart';

import '../Controller/myController.dart';

class Additional_info extends StatelessWidget {
  const Additional_info({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WeatherModel? weatherData = Provider.of<MyController>(context).weatherData;
    Map size = Provider.of<MyController>(context).responsive(context);
    return DefaultTextStyle(
      style: TextStyle(
                  fontSize: size['orientation'] == Orientation.portrait
                      ? size['width'] * 0.03
                      : size['width'] * 0.017),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additioal Info',
            style: TextStyle(
                fontSize: size['orientation'] == Orientation.portrait
                    ? size['width'] * 0.07
                    : size['width'] * 0.04,
                fontWeight: FontWeight.bold,color: Colors.black),
          ),
          const SizedBox(height: 20),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Wind',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff45494C)),
              ),
              SizedBox(
                  width: size['orientation'] == Orientation.portrait
                      ? size['width'] * 0.13
                      : size['width'] * 0.24),
                      // Spacer(flex: 1),
              Text(
                '${weatherData!.wind} m/h',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xff949494)),
              ),
              SizedBox(
                  width: size['orientation'] == Orientation.portrait
                      ? size['width'] * 0.17
                      : size['width'] * 0.14),
                      // Spacer(flex: 1),
              const Text(
                'Humidity',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff45494C)),
              ),
              SizedBox(
                  width: size['orientation'] == Orientation.portrait
                      ? size['width'] * 0.12
                      : size['width'] * 0.15),
              // Spacer(flex: 1),
              Text(
                '${weatherData.humidity[0]} %',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xff949494)),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Text(
                'Visibility',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff45494C)),
              ),
              // Spacer(flex: 1),
              SizedBox(
                  width: size['orientation'] == Orientation.portrait
                      ? size['width'] * 0.09
                      : size['width'] * 0.21),
              Text(
                '${(weatherData.visibility[0] / 1000).toInt()} km',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xff949494)),
              ),
              // Spacer(flex: 1),
              SizedBox(
                  width: size['orientation'] == Orientation.portrait
                      ? size['width'] * 0.19
                      : size['width'] * 0.165),
              const Text(
                'UV',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff45494C)),
              ),
              // Spacer(flex: 2),
              SizedBox(
                  width: size['orientation'] == Orientation.portrait
                      ? size['width'] * 0.22
                      : size['width'] * 0.20),
              Text(
                '${weatherData.uv}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xff949494)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
