import 'package:flutter/material.dart';

class MyController extends ChangeNotifier {
  var selectedBubble = 0;

  changeBubbleColor(var val) {
    selectedBubble = val;
    notifyListeners();
  }
}
