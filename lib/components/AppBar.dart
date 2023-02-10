import 'package:flutter/material.dart';

AppBar myAppbar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
        icon: const Icon(Icons.sort_outlined, size: 30, color: Colors.black),
        onPressed: () {}),
    actions: [
      IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => SerachPage(),
              ),
            );
          },
          icon: const Icon(
            Icons.search,
            color: Colors.black,
            size: 30,
          ))
    ],
    title:
        const Text('Weather Forecast', style: TextStyle(color: Colors.black)),
    centerTitle: true,
  );
}

class SerachPage extends StatelessWidget {
  const SerachPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController txtcontroller = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: txtcontroller,
                  autofocus: true,
                  decoration: const InputDecoration(
                      hintText: 'Enter a City',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
