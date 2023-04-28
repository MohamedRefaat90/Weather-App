import 'package:flutter/material.dart';

import 'package:weather/components/customTextField.dart';

import '../components/cancelBtn.dart';
import '../components/toast.dart';

class SerachPage extends StatefulWidget {
  @override
  State<SerachPage> createState() => _SerachPageState();
}

class _SerachPageState extends State<SerachPage> {
  @override
  void initState() {
    super.initState();
    // if you want to use context from globally instead of content we need to pass navigatorKey.currentContext!
    fToast!.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Row(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: customTextField(context)),
                CancleBtn()
              ],
            ),
          )),
    );
  }
}
