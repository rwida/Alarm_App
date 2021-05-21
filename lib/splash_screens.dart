import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superk_new/main.dart';





class Splash extends StatefulWidget {
  LocaleChangeCallback callback;
  Splash(this.callback);

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with SingleTickerProviderStateMixin {


  @override
  initState() {
    super.initState();
    splash();
  }


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Image.asset(
            'images/2.png',
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          // Align(
          //   alignment: Alignment.center,
          //   child: Column(mainAxisAlignment:MainAxisAlignment.center,children: [
          //     Text("whatsmarket", style: TextStyle(
          //         color: Colors.white,
          //         fontFamily: 'jana',
          //         fontSize: 28,
          //         fontWeight: FontWeight.bold
          //     ),
          //     ),
          //     SizedBox(height: 10,),
          //   CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),),
          //
          //
          //   ],),
          // )
        ],
      ),
    );
  }

  void splash() async {
    await new Future.delayed(const Duration(seconds: 5));
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

    Navigator.pushReplacementNamed(context, "IntroductionScreen");
    this.setState(
        widget.callback(new Locale(sharedPrefs.getString('lang'))));
  }


}
