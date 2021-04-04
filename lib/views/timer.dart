import 'dart:async';

import 'package:clock_app/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int hour = 0;
  int min = 0;
  int sec = 0;
  bool started = true;
  bool stoped = true;
  int timeForTimer = 0;
  String timeToDisplay = "";
  bool checkTimer = true;

  void start() {
    setState(() {
      started = false;
      stoped = false;
    });
    timeForTimer = ((hour * 60 * 60) + (min * 60) + sec);
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timeForTimer < 1 || checkTimer == false) {
          timer.cancel();
          /* timeToDisplay = "";
          started = true; */
        } else if (timeForTimer < 60) {
          timeToDisplay = timeForTimer.toString();
          timeForTimer = timeForTimer - 1;
        } else if (timeForTimer < 3600) {
          int m = timeForTimer ~/ 60;
          int s = timeForTimer - (m * 60);
          timeToDisplay = m.toString() + ":" + s.toString();
          timeForTimer = timeForTimer - 1;
        } else {
          int h = timeForTimer ~/ 3600;
          int t = timeForTimer - (h * 3600);
          int m = t ~/ 60;
          int s = t - (m * 60);
          timeToDisplay = h.toString() + ":" + m.toString() + s.toString();
          timeForTimer = timeForTimer - 1;
        }
        timeToDisplay = timeForTimer.toString();
      });
    });
  }

  void stop() {
    setState(() {
      started = true;
      stoped = true;
      checkTimer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageBackgroundColor,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Text(
                          "HH",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      NumberPicker.integer(
                        initialValue: hour,
                        selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        minValue: 0,
                        maxValue: 1000,
                        listViewWidth: 60,
                        onChanged: (val) {
                          setState(() {
                            hour = val;
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Text(
                          "MM",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      NumberPicker.integer(
                        initialValue: min,
                        selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        minValue: 0,
                        maxValue: 1000,
                        listViewWidth: 60,
                        onChanged: (val) {
                          setState(() {
                            min = val;
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Text(
                          "SS",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      NumberPicker.integer(
                        initialValue: sec,
                        selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        minValue: 0,
                        maxValue: 1000,
                        listViewWidth: 60,
                        onChanged: (val) {
                          setState(() {
                            sec = val;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                timeToDisplay,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.green,
                      onPressed: started ? start : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        child: Text(
                          "Start",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.red,
                      onPressed: stoped ? null : stop,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        child: Text(
                          "Stop",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
