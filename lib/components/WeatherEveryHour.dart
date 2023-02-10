import 'package:flutter/material.dart';
import 'weatherCard.dart';

class WeatherEveryHour extends StatelessWidget {
  const WeatherEveryHour({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 235,
      child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          
          children: const [
            weatherCard(
                height: 125,
                time: '18:00',
                icon: Icons.thunderstorm_rounded,
                temp: '12',
                base: Color(0xffF48A5C),
                second: Color(0xffE1707A),
                directionofRadius: Alignment.bottomCenter,
                radius: BorderRadius.only(topLeft: Radius.circular(50))),
                SizedBox(width: 10,),
            weatherCard(
                height: 125,
                time: '19:00',
                icon: Icons.brightness_5_rounded,
                temp: '19',
                base: Color(0xffB46491),
                second: Color(0xff7C5F90),
                directionofRadius: Alignment.bottomCenter,
                radius: BorderRadius.zero),
                SizedBox(width: 10,),
            weatherCard(
                height: 110,
                time: '22:00',
                icon: Icons.nightlight_round,
                temp: '5',
                base: Color(0xff49587A),
                second: Color(0xff2F4859),
                directionofRadius: Alignment.topLeft,
                radius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                )),
                SizedBox(width: 10,),
            weatherCard(
                height: 110,
                time: '22:00',
                icon: Icons.nightlight_round,
                temp: '5',
                base: Color(0xff49587A),
                second: Color(0xff2F4859),
                directionofRadius: Alignment.topLeft,
                radius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                )),
                SizedBox(width: 10,),
            weatherCard(
                height: 110,
                time: '22:00',
                icon: Icons.nightlight_round,
                temp: '5',
                base: Color(0xff49587A),
                second: Color(0xff2F4859),
                directionofRadius: Alignment.topLeft,
                radius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                )),
                SizedBox(width: 10,),
            weatherCard(
                height: 110,
                time: '22:00',
                icon: Icons.nightlight_round,
                temp: '5',
                base: Color(0xff49587A),
                second: Color(0xff2F4859),
                directionofRadius: Alignment.topLeft,
                radius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                )),
                SizedBox(width: 10,),
            weatherCard(
                height: 110,
                time: '22:00',
                icon: Icons.nightlight_round,
                temp: '5',
                base: Color(0xff49587A),
                second: Color(0xff2F4859),
                directionofRadius: Alignment.topLeft,
                radius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                )),
          ]),
    );
  }
}
