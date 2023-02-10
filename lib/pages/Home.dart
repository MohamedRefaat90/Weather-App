import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/Controller/myController.dart';

import '../components/AppBar.dart';
import '../components/BubbleChart.dart';
import '../components/WeatherEveryHour.dart';
import '../components/additional_info.dart';
import '../components/city_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(context),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CityCard(),
              const SizedBox(height: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TabBar(
                      controller: TabController(length: 3, vsync: this),
                      labelColor: const Color(0xff030B0F),
                      indicatorColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      unselectedLabelColor:
                          const Color.fromARGB(255, 174, 174, 174),
                      tabs: const [
                        Tab(child: Text('Today')),
                        Tab(child: Text('Tomorrow')),
                        Tab(child: Text('After')),
                      ]),
                  const SizedBox(height: 10),
                  const WeatherEveryHour(),
                  const SizedBox(height: 30),
                  const Additional_info(),
                  const SizedBox(height: 50),
                  ChangeNotifierProvider<MyController>(
                      create: (context) => MyController(), child: BubbleChart())
                ],
              )
            ],
          ),
        ),
      )),
    );
  }


}
