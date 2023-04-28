import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:weather/Models/Weather_Model.dart';
import 'package:weather/Services/Weathe_Service.dart';

import '../Services/Location_Service.dart';

class MyController extends ChangeNotifier {
  String? cityName;
  WeatherModel? weatherData;
  int? weatherState;
  String sunState = '';
  int? sunRiseHour;
  int? sunSetHour;

  Map responsive(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Orientation orientation = MediaQuery.of(context).orientation;

    return {"width": width, 'height': height, "orientation" : orientation};
  }

  getCurrentWeather(BuildContext context) async {
    WeatherModel weather = await WeatherService().get_Weather();
    weatherData = weather;
    notifyListeners();
  }

  update() {
    notifyListeners();
  }

  getLiveLocationWeather() async {
    var liveLoc = await LocationService().liveLocation();
    weatherData = await WeatherService()
        .get_Weather2(liveLoc.latitude, liveLoc.longitude);
    notifyListeners();
  }

  List<dynamic> weatherStates(int index) {
    weatherState = weatherData!.wCode[index];
    var Chour = DateTime.now();
    sunRiseHour = weatherData!.sunRise;
    sunSetHour = weatherData!.sunSet;
    sunState =
        Chour.hour >= weatherData!.sunRise && Chour.hour <= weatherData!.sunSet
            ? 'sunRise'
            : 'sunSet';
    if (weatherState == 0) {
      if (sunState == 'sunRise') {
        // ============== Clear Sky ==============
        return ['assets/icons/Sunny.json', 'Clear', FontAwesomeIcons.sun];
      } else {
        return ['assets/icons/night.json', 'Clear', FontAwesomeIcons.moon];
      }
    } else if (weatherState == 1 || weatherState == 2 || weatherState == 3) {
      // ============== Partly Cloud ==============
      if (sunState == 'sunRise') {
        return [
          'assets/icons/partly-cloudy.json',
          'Cloudy',
          FontAwesomeIcons.cloudSun
        ];
      } else {
        return [
          'assets/icons/cloudynight.json',
          'Cloudy',
          FontAwesomeIcons.cloudMoon
        ];
      }
    } else if (weatherState == 45 || weatherState == 48) {
      // ============== Foggy ==============
      return ['assets/icons/Foggy.json', 'Foggy', FontAwesomeIcons.smog];
    } else if (weatherState == 61 ||
        weatherState == 63 ||
        weatherState == 65 ||
        weatherState == 80 ||
        weatherState == 81 ||
        weatherState == 82) {
      // ============== Rain ==============
      return [
        'assets/icons/Rain.json',
        'Rain',
        FontAwesomeIcons.cloudShowersHeavy
      ];
    } else if (weatherState == 51 || weatherState == 53 || weatherState == 55) {
      // ============== Drizzel ==============
      return [
        'assets/icons/Drizzel.json',
        'Drizzel',
        FontAwesomeIcons.cloudRain
      ];
    } else if (weatherState == 71 ||
        weatherState == 73 ||
        weatherState == 75 ||
        weatherState == 77 ||
        weatherState == 85 ||
        weatherState == 86) {
      // ============== rainSnow ==============
      return [
        'assets/icons/Snow.json',
        'Snow Fall',
        FontAwesomeIcons.snowflake
      ];
    } else if (weatherState == 56 ||
        weatherState == 57 ||
        weatherState == 66 ||
        weatherState == 67) {
      return [
        'assets/icon/rainSnow.json',
        'Snow Showers',
        FontAwesomeIcons.snowflake
      ];
    } else if (weatherState == 95 || weatherState == 96 || weatherState == 99) {
      // ============== Thunder ==============
      return ['assets/icons/storm.json', 'Thunder', FontAwesomeIcons.cloudBolt];
    } else {
      return ['assets/icons/clear.json', 'Clear', FontAwesomeIcons.sun];
    }
  }
}
