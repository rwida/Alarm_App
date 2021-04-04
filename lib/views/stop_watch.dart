import 'dart:async';

import 'package:clock_app/constants/theme_data.dart';
import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  bool startpress = true;
  bool stoppress = true;
  bool resetpress = true;
  String stoptimerDispaly = "00:00:00";
  var swatch = Stopwatch();
  final dur = const Duration(seconds: 1);

  void startTimer() {
    Timer(dur, keeprunning);
  }

  void keeprunning() {
    if (swatch.isRunning) {
      startTimer();
    }
    setState(() {
      stoptimerDispaly = swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void start() {
    setState(() {
      startpress = false;
      stoppress = false;
    });
    swatch.start();
    startTimer();
  }

  void stop() {
    setState(() {
      stoppress = true;
      resetpress = false;
      startpress = true;
    });
    swatch.stop();
  }

  void reset() {
    setState(() {
      startpress = true;
      resetpress = true;
    });
    swatch.reset();
    stoptimerDispaly = "00:00:00";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.pageBackgroundColor,
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  stoptimerDispaly,
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Text(
                            "Stop",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          color: Colors.red,
                          onPressed: stoppress ? null : stop,
                        ),
                        RaisedButton(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Text(
                            "Reset",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          color: Colors.teal,
                          onPressed: resetpress ? null : reset,
                        )
                      ],
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width -
                              MediaQuery.of(context).padding.horizontal) *
                          0.6,
                      child: RaisedButton(
                        child: Text(
                          stoptimerDispaly != "00:00:00" ? "Resume" : "Start",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        color: Colors.green,
                        onPressed: startpress ? start : null,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
