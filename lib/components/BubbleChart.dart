// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' hide SelectionDetails;

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather/Models/Colors.dart';

import '../Controller/myController.dart';
import '../Models/weeklyTemp.dart';

class BubbleChart extends StatefulWidget {
  @override
  State<BubbleChart> createState() => _BubbleChartState();
}

class _BubbleChartState extends State<BubbleChart> {
  @override
  Widget build(BuildContext context) {
    List? tmps = Provider.of<MyController>(context).weatherData!.tmpMax;
    List? days = Provider.of<MyController>(context).weatherData!.week;
    // MyController controller = Provider.of<MyController>(context);
    TooltipBehavior tooltipBehavior =
        TooltipBehavior(enable: true, duration: 1500);

    List<DailyTmp> weeklyTmps = getDaysTmp(days, tmps);

    return SfCartesianChart(
      enableAxisAnimation: true,
      tooltipBehavior: tooltipBehavior,
      plotAreaBorderWidth: 0,
      series: <SplineSeries>[
        SplineSeries<DailyTmp, dynamic>(
          name: 'Temperature',
          dataSource: weeklyTmps,
          xValueMapper: (DailyTmp data, _) => data.day,
          yValueMapper: (DailyTmp data, _) => data.tmp,
          dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.middle,
              textStyle:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          enableTooltip: true,
          color: const Color(0xffC0C6C9),
          markerSettings: MarkerSettings(
            isVisible: true,
            borderColor: orange,
            width: 30,
            height: 30,
            borderWidth: 5,
          ),
        )
      ],
      primaryXAxis: CategoryAxis(
        isVisible: false,
      ),
      primaryYAxis: NumericAxis(
          isVisible: false,
          labelFormat: '{value}c',
          labelAlignment: LabelAlignment.center),
    );
  }
}
