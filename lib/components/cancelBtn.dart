import 'package:flutter/material.dart';

class CancleBtn extends StatelessWidget {
  const CancleBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          'Cancel',
          style: TextStyle(fontWeight: FontWeight.bold),
        ));
  }
}
