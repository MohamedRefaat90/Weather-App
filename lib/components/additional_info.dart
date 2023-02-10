import 'package:flutter/material.dart';

class Additional_info extends StatelessWidget {
  const Additional_info({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additioal Info',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          children: const [
            Text(
              'Wind',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff45494C)),
            ),
            SizedBox(width: 65),
            Text(
              '12 m/h',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff949494)),
            ),
            SizedBox(width: 65),
            Text(
              'Humidity',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff45494C)),
            ),
            SizedBox(width: 50),
            Text(
              '55 %',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff949494)),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: const [
            Text(
              'Visibility',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff45494C)),
            ),
            SizedBox(width: 40),
            Text(
              '25 km',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff949494)),
            ),
            SizedBox(width: 70),
            Text(
              'UV',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff45494C)),
            ),
            SizedBox(width: 100),
            Text(
              '1',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff949494)),
            ),
          ],
        ),
      ],
    );
  }
}
