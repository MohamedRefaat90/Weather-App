import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/Models/Weather_Model.dart';

import 'Location_Service.dart';

//
class WeatherService {
  Future<WeatherModel> get_Weather() async {
    LocationService location = LocationService();
    Map<String, dynamic> latLong = await location.geo();
    String baseUrl = 'https://api.open-meteo.com';
    // String APIkey = '6fd97af61c674089a29172820230302';
    // String currentCity = await LocationService().geo();

    // String selectedCity = cityName ?? currentCity;
    // Convert url to URI object
    Uri url = Uri.parse(
        '$baseUrl/v1/forecast?latitude=${latLong['Lat']}&longitude=${latLong['Long']}&hourly=temperature_2m,relativehumidity_2m,visibility,windspeed_10m,precipitation,rain,showers,snowfall,cloudcover&daily=sunrise,sunset,weathercode,temperature_2m_max,temperature_2m_min,uv_index_max,uv_index_clear_sky_max,windspeed_10m_max&current_weather=true&timezone=auto');

    // print(url);
    
    // fetch respose from url
    http.Response response = await http.get(url);

    // convert respone into Json to access data
    Map<String, dynamic> data = jsonDecode(response.body);

    WeatherModel weather =  WeatherModel.fromJson(data);

    // print(weather);
    return weather;
  }



    Future<WeatherModel> get_Weather2(double curLat,double curLong) async {
    // LocationService location = LocationService();
    // Map<String, dynamic> latLong = await location.geo();
    String baseUrl = 'https://api.open-meteo.com';
    // String APIkey = '6fd97af61c674089a29172820230302';
    // String currentCity = await LocationService().geo();

    // String selectedCity = cityName ?? currentCity;
    // Convert url to URI object
    Uri url = Uri.parse(
        '$baseUrl/v1/forecast?latitude=$curLat&longitude=$curLong&hourly=temperature_2m,relativehumidity_2m,visibility,windspeed_10m,precipitation,rain,showers,snowfall,cloudcover&daily=sunrise,sunset,weathercode,temperature_2m_max,temperature_2m_min,uv_index_max,uv_index_clear_sky_max,windspeed_10m_max&current_weather=true&timezone=auto');

    // print(url);
    
    // fetch respose from url
    http.Response response = await http.get(url);

    // convert respone into Json to access data
    Map<String, dynamic> data = jsonDecode(response.body);

    WeatherModel weather =  WeatherModel.fromJson(data);

    print(weather);
    return weather;
  }
}
