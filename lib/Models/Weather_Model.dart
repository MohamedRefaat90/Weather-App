// ignore_for_file: public_member_api_docs, sort_constructors_first
class WeatherModel {
  double tmp;
  List tmpMax;
  List tmpMin;
  String time;
  double wind;
  List visibility;
  List humidity;
  double uv;
  List hourlyTime;
  List hourlyTemp;
  List wCode;
  List week;
  int sunRise;
  int sunSet;

  WeatherModel({
    required this.hourlyTemp,
    required this.hourlyTime,
    required this.tmp,
    required this.tmpMax,
    required this.tmpMin,
    required this.time,
    required this.wind,
    required this.visibility,
    required this.humidity,
    required this.uv,
    required this.wCode,
    required this.week,
    required this.sunRise,
    required this.sunSet,
  });

  // factory Constructor
  factory WeatherModel.fromJson(data) {
    Map current = data['current_weather'];
    return WeatherModel(
        hourlyTime: data['hourly']['time'],
        hourlyTemp: data['hourly']['temperature_2m'],
        tmp: current['temperature'],
        tmpMax: data['daily']['temperature_2m_max'],
        tmpMin: data['daily']['temperature_2m_min'],
        time: current['time'],
        wind: current['windspeed'],
        visibility: data['hourly']['visibility'],
        humidity: data['hourly']['relativehumidity_2m'],
        uv: data['daily']['uv_index_max'][0],
        wCode: data['daily']['weathercode'],
        week: data['daily']['time'],
        sunRise: DateTime.parse(data['daily']['sunrise'][0]).hour,
        sunSet: DateTime.parse(data['daily']['sunset'][0]).hour,
        );
  }

  @override
  String toString() {
    return 'sunRise: $sunRise , sunRise: $sunSet';
  }

}
