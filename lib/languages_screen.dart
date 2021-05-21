import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:superk_new/Genral.dart';
import 'package:superk_new/locale/localization.dart';
import 'package:superk_new/main.dart';


class LanguagesScreen extends StatefulWidget {
  LocaleChangeCallback callback;
  LanguagesScreen(this.callback);
  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  int languageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLang();
  }
  @override
  Widget build(BuildContext context) {

    return
     Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF13446f),title: Text(AppLocalizations.of(context).language)),
      body: SettingsList(
        sections: [
          SettingsSection(tiles: [
            SettingsTile(
              title: "English",
              trailing: trailingWidget(0),
              onPressed: (BuildContext context) async {
                SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
                setState(() {
                  languageIndex = 0;
                  Langs = "en";
                });
                sharedPrefs.setString("language", "en");
                this.setState(
                    widget.callback(new Locale("en")));

                //changeLanguage(0);
              },
            ),
            SettingsTile(
              title: "عربي",
              trailing: trailingWidget(1),
              onPressed: (BuildContext context) async {
                SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
                setState(() {
                  languageIndex = 1;
                  Langs = "ar";
                });
                sharedPrefs.setString("language", "ar");
                this.setState(
                    widget.callback(new Locale("ar")));

                //changeLanguage(1);
              },
            ),
            // SettingsTile(
            //   title: "Chinese",
            //   trailing: trailingWidget(2),
            //   onPressed: (BuildContext context) {
            //     changeLanguage(2);
            //   },
            // ),
            // SettingsTile(
            //   title: "German",
            //   trailing: trailingWidget(3),
            //   onPressed: (BuildContext context) {
            //     changeLanguage(3);
            //   },
            // ),
          ]),
        ],
      ),
    );
  }
   getLang() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    if(sharedPrefs.getString("language") == "en"){
      setState(() {
        languageIndex = 0;
      });
    }else if(sharedPrefs.getString("language") == "ar"){
      setState(() {
        languageIndex = 1;
      });
    }else {
      setState(() {
        languageIndex = 0;
      });
    }
  }

  Widget trailingWidget(int index) {
    return (languageIndex == index)
        ? Icon(Icons.check, color: Color(0xFFff8500))
        : Icon(null);
  }

  void changeLanguage(int index) {
    setState(() {
      languageIndex = index;
    });
  }
}