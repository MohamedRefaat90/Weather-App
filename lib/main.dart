import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/Controller/myController.dart';
import 'package:weather/pages/Home.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyController(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        // home: Testing(),
      ),
    );
  }
}
