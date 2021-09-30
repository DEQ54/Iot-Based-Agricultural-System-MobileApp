import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sirrig/components/reusable_card.dart';

import '../constants.dart';

class PostConfig extends StatefulWidget {
  @override
  _PostConfigState createState() => _PostConfigState();
}

class _PostConfigState extends State<PostConfig> {
  var sensor = '''
  [
    {"name": "Tomato","temperature": 20, "moisture": 20, "n": 255, "p": 255, "k": 255},
    {"name": "Okra","temperature": 20, "moisture": 20, "n": 255, "p": 255, "k": 255},
    {"name": "Cabbage","temperature": 20, "moisture": 20, "n": 255, "p": 255, "k": 255}
  ]
  ''';

  var url = 'https://cheerier-replacemen.000webhostapp.com/get.php';
  var postUrl = 'http://192.168.4.1/api/postConfig';
  var _postsJson = [];

  void fetchValues() async {
    try {
      print("making request");
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode(response.body) as List;
      // print(response.statusCode);
      // print(jsonData);
      setState(() {
        _postsJson = jsonData;
      });
    } catch (err) {
      print(err);
    }
  }

  void postSensorValues(var sensorValues) async {
    try {
      print("making request");
      final feedbackResponse = await post(Uri.parse(postUrl), body: {
        "soilTemperature": sensorValues["temperature"],
        "soilMoisture": sensorValues["moisture"],
        "n": sensorValues["nitrogen"],
        "p": sensorValues["phosphorus"],
        "k": sensorValues["potassium"]
      });
      print(feedbackResponse.body);
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: Center(child: Text('Post Configuration')),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.logout),
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh Screen',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                  builder: (BuildContext context) => super.widget));
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Page Reloaded')));
              }),
          IconButton(
            icon: const Icon(Icons.show_chart),
            tooltip: 'Check System Status',
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('\home');
            },
          )
        ],
      ),
      body: ListView.builder(
          itemCount: _postsJson.length,
          itemBuilder: (context, i) {
            final sensorValue = _postsJson[i];
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      postSensorValues(sensorValue);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            width: 10,
                            color: Color.fromRGBO(26, 177, 136, 1),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      width: 160,
                      height: 160,
                      margin: EdgeInsets.all(5),
                      child: Text(sensorValue["plant"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                          )),
                    ))
              ],
            );
          }),
    );
  }
}
