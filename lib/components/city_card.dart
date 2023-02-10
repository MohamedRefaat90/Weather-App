import 'package:flutter/material.dart';

class CityCard extends StatelessWidget {
  const CityCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.brightness_5_rounded,
          size: 40,
          color: Color(0xffFFA63D),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('31,9',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500)),
            Text('O', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const Text('ElNozha,Egypt',
            style: TextStyle(fontSize: 20, color: Color(0xffA1A3A5)))
      ],
    );
  }
}
