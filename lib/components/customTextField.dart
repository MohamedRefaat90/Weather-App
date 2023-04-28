import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/Controller/myController.dart';
import 'package:weather/Services/Weathe_Service.dart';
import 'package:weather/components/toast.dart';

import '../Models/Weather_Model.dart';

String? cityName;
GlobalKey<FormState> formKey = GlobalKey<FormState>();
WeatherModel? weather;
Form customTextField(BuildContext context) {
  return Form(
    key: formKey,
    child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter a City Name';
          }
          return null;
        },
        onFieldSubmitted: (value) async {
          bool validFrom = formKey.currentState!.validate();
          cityName = value;
          if (validFrom) {
            try {
              // weather = await WeatherService().get_Weather();
              // Provider.of<MyController>(context, listen: false).weatherData =
              //     weather;
await Provider.of<MyController>(context, listen: false).getCurrentWeather(context);
              // Provider.of<MyController>(context, listen: false);
                  // .currentWeather();

              Navigator.pop(context);
              print(weather);
            } catch (e) {
              if (weather == null) showToast();
            }
          }
        },
        autofocus: true,
        decoration: const InputDecoration(
            hintText: 'Enter a City',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))))),
  );
}
