import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

FToast? fToast  = FToast();
showToast() {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: const Color.fromARGB(255, 246, 91, 91),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(
          Icons.cancel,
          color: Colors.white,
        ),
        SizedBox(
          width: 12.0,
        ),
        Text(
          "incorrect City Name",
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  );

  fToast!.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 3),
  );
}
