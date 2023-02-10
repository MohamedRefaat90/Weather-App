import 'package:charts_painter/chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Controller/myController.dart';

class BubbleChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyController controller = Provider.of<MyController>(context, listen: true);
    return Chart(
        height: 100,
        state: ChartState(
            behaviour: ChartBehaviour(
              onItemClicked: (value) {
                controller.changeBubbleColor(value.itemIndex);
              },
            ),
            backgroundDecorations: [
              SparkLineDecoration(lineColor: const Color(0xffC0C6C9))
            ],
            data: ChartData([
              [6, 8, 4, 8, 7]
                  .map((e) => ChartItem<void>(e.toDouble()))
                  .toList(),
            ]),
            itemOptions: BubbleItemOptions(
              maxBarWidth: 17,
              bubbleItemBuilder: (p0) {
                return BubbleItem(
                    color: Colors.white,
                    border: BorderSide(
                        width: 7,
                        color: p0.itemIndex == controller.selectedBubble
                            ? const Color(0xff725986)
                            : const Color(0xffC0C6C9)));
              },
            )));
  }
}
