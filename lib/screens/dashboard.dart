import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sirrig/components/reusable_card.dart';
import 'package:sirrig/components/icon_content.dart';
import 'package:sirrig/screens/post_config.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart';
import 'dart:convert';

import '../constants.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final url = 'https://api.thingspeak.com/channels/1409805/feeds.json';
  var _postsJson = [];

  void fetchPosts() async {
    try {
      print("making request");
      final response = await get(Uri.parse(url));
      final jsonData = jsonDecode("[${response.body}]") as List;
      print(jsonData[0]["feeds"]);
      setState(() {
        _postsJson = jsonData;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.logout),
        ),
        title: Center(child: Text('MyFarm')),
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
            icon: const Icon(Icons.local_post_office),
            tooltip: 'Post Configuration',
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('\postConfig');
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: ReusableCard(
              cardColor: Colors.transparent,
              onPressed: () {},
              cardChild: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      alignment: Alignment.center,
                      // decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     border: Border.all(
                      //       width: 20,
                      //       color: Colors.red[500],
                      //     ),
                      //     borderRadius: BorderRadius.all(Radius.circular(360))),
                      width: 160,
                      height: 160,
                      // padding: EdgeInsets.only(top: 20),
                      child: ListView.builder(
                        itemCount: _postsJson.length,
                        itemBuilder: (context, i) {
                          final post = _postsJson[i];
                          var temperature =
                              double.parse(post["feeds"].last["field1"])
                                  .toStringAsFixed(1);
                          return CircularPercentIndicator(
                            progressColor: Colors.redAccent,
                            percent: (double.parse(temperature) / 43),
                            radius: 160,
                            animation: true,
                            circularStrokeCap: CircularStrokeCap.round,
                            lineWidth: 20,
                            center: Text(temperature + '\n\u00B0C',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40.0,
                                )),
                          );
                        },
                      )),
                  Container(
                      alignment: Alignment.center,
                      // decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     border: Border.all(
                      //       width: 20,
                      //       color: Colors.red[500],
                      //     ),
                      //     borderRadius: BorderRadius.all(Radius.circular(360))),
                      width: 160,
                      height: 160,
                      // padding: EdgeInsets.only(top: 20),
                      child: ListView.builder(
                        itemCount: _postsJson.length,
                        itemBuilder: (context, i) {
                          final post = _postsJson[i];
                          var moisture =
                              double.parse(post["feeds"].last["field2"])
                                  .toStringAsFixed(1);
                          return CircularPercentIndicator(
                            progressColor: Colors.blue,
                            percent: (double.parse(moisture) / 100),
                            radius: 160,
                            animation: true,
                            circularStrokeCap: CircularStrokeCap.round,
                            lineWidth: 20,
                            center: Text(moisture + '\n%',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40.0,
                                )),
                          );
                        },
                      ))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ReusableCard(
              cardColor: Color.fromRGBO(26, 177, 136, 1),
              onPressed: () {},
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              // decoration: BoxDecoration(
                              //     color: Colors.white,
                              //     border: Border.all(
                              //       width: 20,
                              //       color: Colors.red[500],
                              //     ),
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(360))),
                              width: 160,
                              height: 160,
                              // padding: EdgeInsets.only(top: 20),
                              child: ListView.builder(
                                itemCount: _postsJson.length,
                                itemBuilder: (context, i) {
                                  final post = _postsJson[i];
                                  var nitrogen =
                                      double.parse(post["feeds"].last["field3"])
                                          .toStringAsFixed(0);
                                  Text(nitrogen + '\nN',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 40.0,
                                      ));
                                  return CircularPercentIndicator(
                                    progressColor: Colors.blueAccent[700],
                                    percent: (double.parse(nitrogen) / 255),
                                    radius: 160,
                                    animation: true,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    lineWidth: 20,
                                    center: Text(nitrogen + '\nN',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40.0,
                                        )),
                                  );
                                },
                              )),
                          Container(
                              alignment: Alignment.center,
                              // decoration: BoxDecoration(
                              //     color: Colors.white,
                              //     border: Border.all(
                              //       width: 20,
                              //       color: Colors.red[500],
                              //     ),
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(360))),
                              width: 160,
                              height: 160,
                              // padding: EdgeInsets.only(top: 20),
                              child: ListView.builder(
                                itemCount: _postsJson.length,
                                itemBuilder: (context, i) {
                                  final post = _postsJson[i];
                                  var phosphorus =
                                      double.parse(post["feeds"].last["field4"])
                                          .toStringAsFixed(0);
                                  Text(phosphorus + '\nP',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 40.0,
                                      ));
                                  return CircularPercentIndicator(
                                    progressColor: Colors.orange,
                                    percent: (double.parse(phosphorus) / 255),
                                    radius: 160,
                                    animation: true,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    lineWidth: 20,
                                    center: Text(phosphorus + '\nP',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40.0,
                                        )),
                                  );
                                },
                              ))
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                // decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     border: Border.all(
                                //       width: 20,
                                //       color: Colors.red[500],
                                //     ),
                                //     borderRadius:
                                //         BorderRadius.all(Radius.circular(360))),
                                width: 160,
                                height: 160,
                                // padding: EdgeInsets.only(top: 20),
                                child: ListView.builder(
                                  itemCount: _postsJson.length,
                                  itemBuilder: (context, i) {
                                    final post = _postsJson[i];
                                    var potassium =
                                        double.parse(post["feeds"].last["field5"])
                                            .toStringAsFixed(0);
                                    return CircularPercentIndicator(
                                      progressColor: Colors.white70,
                                      percent: (double.parse(potassium) / 255),
                                      radius: 160,
                                      animation: true,
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      lineWidth: 20,
                                      center: Text(potassium + '\nK',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40.0,
                                          )),
                                    );
                                  },
                                ))
                          ]))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class IrrigationData {
  IrrigationData({@required this.month, @required this.frequency});

  final String month;
  final int frequency;
}
