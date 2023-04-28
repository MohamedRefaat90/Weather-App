import 'package:flutter/material.dart';

class TabBarHeaders extends StatelessWidget {
  const TabBarHeaders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TabBar(
        labelColor: Color(0xff030B0F),
        indicatorColor: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 30),
        unselectedLabelColor:
            Color.fromARGB(255, 174, 174, 174),
        tabs: [
          Tab(child: Text('Today')),
          Tab(child: Text('Forecast')),
        ]);
  }
}
