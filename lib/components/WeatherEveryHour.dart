import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/Models/Colors.dart';
import 'package:weather/Models/Weather_Model.dart';
import '../Controller/myController.dart';
import 'EveryHourCard.dart';

class WeatherEveryHour extends StatelessWidget {
  const WeatherEveryHour({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WeatherModel? weatherData = Provider.of<MyController>(context).weatherData;
    int count = weatherData!.hourlyTemp.length ~/ 7;
    var time = weatherData.hourlyTime;
    String sunState = Provider.of<MyController>(context).sunState;
    int sunRiseHour = Provider.of<MyController>(context).sunRiseHour!;
    int sunSetHour = Provider.of<MyController>(context).sunSetHour!;
    return SizedBox(
        height: 225,
        child: ListView.builder(
          itemCount: count,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          reverse : false,
          itemBuilder: (context, index) {
            //  DateTime.parse(time[index]).hour == DateTime.now().hour;

            // var hour = DateTime.parse(time[index]).hour >= DateTime.now().hour
            //     ? DateTime.now().hour
            //     : DateTime.parse(time[index]).hour;
            var hour = DateTime.parse(time[index]).hour ;
            var minuts = DateTime.parse(weatherData.hourlyTime[index]).minute;
            return /* DateTime.parse(time[index]).hour >= DateTime.now().hour
                ? */ EveryHourCard(
                    height: 125,
                    margin: 10,
                    time: DateTime.now().hour == index
                        ? 'Now'
                        : '${hour < 10 ? '0$hour' : hour}:${minuts < 10 ? '0$minuts' : minuts}',
                    icon: (sunRiseHour  <= hour && sunSetHour >= hour) ? Icons.brightness_5 : Icons.nightlight_round,
                    temp: '${weatherData.hourlyTemp[index].round()}',
                    base: DateTime.now().hour == index? purple: (sunRiseHour  <= hour && sunSetHour >= hour) ? orange : blueGray,
                    second: DateTime.now().hour == index? deepPurple : (sunRiseHour  <= hour && sunSetHour >= hour)  ? pink : indigo,
                    directionofRadius: Alignment.bottomCenter,
                    radius:
                        BorderRadius.only(topLeft: Radius.circular(DateTime.now().hour == index ? 0 : 50)),
                  );
                // : Center();
          },
        
        ));
  }
}


// DateTime.parse(time[index]).hour == DateTime.now().hour
//                 ? EveryHourCard(
//                     height: 125,
//                     margin: 10,
//                     time: 'Now',
//                     icon: Icons.thunderstorm_rounded,
//                     temp: '${weatherData.hourlyTemp[index].round()}',
//                     base: (sunRiseHour <= hour && sunSetHour >= hour)
//                         ? orange
//                         : blueGray,
//                     second: (sunRiseHour <= hour && sunSetHour >= hour)
//                         ? pink
//                         : indigo,
//                     directionofRadius: Alignment.bottomCenter,
//                     radius:
//                         const BorderRadius.only(topLeft: Radius.circular(50)),
//                   )
//                 : EveryHourCard(
//                     height: 125,
//                     margin: 10,
//                     time:
//                         '${hour < 10 ? '0$hour' : hour}:${minuts < 10 ? '0$minuts' : minuts}',
//                     icon: Icons.thunderstorm_rounded,
//                     temp: '${weatherData.hourlyTemp[index].round()}',
//                     base: (sunRiseHour <= hour && sunSetHour >= hour)
//                         ? orange
//                         : blueGray,
//                     second: (sunRiseHour <= hour && sunSetHour >= hour)
//                         ? pink
//                         : indigo,
//                     directionofRadius: Alignment.bottomCenter,
//                     radius:
//                         const BorderRadius.only(topLeft: Radius.circular(50)),
//                   );