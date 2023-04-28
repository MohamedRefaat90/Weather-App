import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/Controller/myController.dart';

import '../pages/searchPage.dart';

AppBar myAppbar(BuildContext context) {

  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
        icon: const Icon(Icons.my_location, size: 30, color: Colors.black),
        onPressed: () {
          Provider.of<MyController>(context, listen: false).getLiveLocationWeather();

        }),
    actions: [
      IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => SerachPage(),
              ),
            );
          },
          icon: const Icon(
            Icons.search,
            color: Colors.black,
            size: 30,
          ))
    ],
    title:
        const Text('Weather Forecast', style: TextStyle(color: Colors.black)),
    centerTitle: true,
  );
}
