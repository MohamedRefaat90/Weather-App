import 'package:flutter/material.dart';

import 'BubbleChart.dart';

class ChartSection extends StatelessWidget {
  const ChartSection({
    super.key,
    required this.size,
  });

  final Map size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Forecast Chart',
          style: TextStyle(
              fontSize:  size['orientation'] ==
                    Orientation.portrait? size['width'] * 0.07 : size['width'] * 0.04,
              fontWeight: FontWeight.bold),
        ),
      const SizedBox(height: 20),
        SizedBox(
            height: size['orientation'] ==
                    Orientation.landscape
                ? size['height'] * 0.35
                : size['height'] * 0.20,
            child: BubbleChart()),
      ],
    );
  }
}
