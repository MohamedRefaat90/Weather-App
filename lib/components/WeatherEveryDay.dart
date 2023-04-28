import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather/Models/Colors.dart';
import 'package:weather/Models/Weather_Model.dart';
import '../Controller/myController.dart';
import 'EveryDayCard.dart';

class WeatherEveryDay extends StatelessWidget {
  const WeatherEveryDay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WeatherModel? weatherData = Provider.of<MyController>(context).weatherData;
    int count = weatherData!.week.length;
    var time = weatherData.week;
    var DaliyIcon;

    return SizedBox(
        height: 225,
        child: ListView.separated(
          itemCount: count,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            DaliyIcon = Provider.of<MyController>(context).weatherStates(index);
            var day = DateTime.parse(time[index]).day;
            var month = DateTime.parse(time[index]).month;
            bool isToday =
                DateTime.parse(time[index]).day == DateTime.now().day;
            return EveryDayCard(
                height: 125,
                time: isToday ? 'Today' : '$day / $month',
                dailyIcon: FaIcon(
                  DaliyIcon[2],
                  size: 40,
                  color: Colors.white,
                ),
                maxTemp: weatherData.tmpMax[index].round(),
                minTemp: weatherData.tmpMin[index].round(),
                base: isToday ? orange : blueGray,
                second: isToday? pink : indigo,
                directionofRadius: Alignment.bottomCenter,
                radius: const BorderRadius.only(topLeft: Radius.circular(50)));
          },
          separatorBuilder: (context, index) => const SizedBox(width: 10),
        ));
  }
}
