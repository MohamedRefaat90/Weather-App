import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather/Controller/myController.dart';

import '../components/AppBar.dart';
import '../components/ChartSection.dart';
import '../components/TabBarContent.dart';
import '../components/TabBarHeaders.dart';
import '../components/additional_info.dart';
import '../components/city_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    Provider.of<MyController>(context, listen: false)
        .getCurrentWeather(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map size = Provider.of<MyController>(context).responsive(context);

    return Scaffold(
      appBar: myAppbar(context),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Provider.of<MyController>(context).weatherData == null
            ? Center(
                child: Lottie.asset("assets/loader.json"),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  Provider.of<MyController>(context, listen: false)
                      .getCurrentWeather(context);
                },
                child: DefaultTabController(
                  length: 2,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const CityCard(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TabBarHeaders(),
                            const SizedBox(height: 10),
                            const TabBarContent(),
                            const SizedBox(height: 30),
                            const Additional_info(),
                            const SizedBox(height: 20),
                            ChartSection(size: size)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
      )),
    );
  }
}




