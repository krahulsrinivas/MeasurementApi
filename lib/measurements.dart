import 'package:assesment/homePage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Measurements extends StatelessWidget {
  final dynamic info;
  Measurements(this.info);
  @override
  Widget build(BuildContext context) {
    final dimentions = jsonDecode(info["info"]);
    return Scaffold(
        body: ListView(children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (Route<dynamic> route) => false);
              },
              child: Text("Take Measurement Again")),
        ),
      ),
      SizedBox(height: 50),
      (dimentions["status"] == 1)
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: dimentions['d'].length,
              itemBuilder: (BuildContext context, int index) {
                String key = dimentions['d'].keys.elementAt(index);
                if (key != "measurementId") {
                  return Container(
                      child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Card(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "$key",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(dimentions['d'][key]),
                        )
                      ],
                    )),
                  ));
                } else {
                  return Container();
                }
              })
          : Center(
              child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: (Text(
                "Failed to get Measurements",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              )),
            ))
    ]));
  }
}
