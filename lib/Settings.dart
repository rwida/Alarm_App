/* import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:share/share.dart';
import 'package:superk_new/Cart.dart';
import 'package:superk_new/Deals.dart';
import 'package:superk_new/Offers.dart';
import 'package:superk_new/Order.dart';
import 'package:superk_new/favorite_tow.dart';
import 'package:superk_new/locale/localization.dart';
import 'package:superk_new/login.dart';
import 'package:superk_new/profile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:superk_new/provider/auth.dart';

import 'Genral.dart';
import 'NewItems.dart';
import 'languages_screen.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SettingsState();
  }
}

class SettingsState extends State<Settings> {
  int tabIndex = 4;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("areYouSure"),
                  content: Text("doYouWantToExitApp"),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text("no"),
                    ),
                    FlatButton(
                      onPressed: () => exit(0),
                      child: Text("yes"),
                    ),
                  ],
                ));
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              AppLocalizations.of(context).settings,
              // style: Theme.of(context).textTheme.subtitle1.copyWith(
              //   //color: Color(0xFF1533e8),
              //   color: Colors.black
              //   //fontSize: 18,
              //   //letterSpacing: 2,
              // ),
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabIndex,
            type: BottomNavigationBarType.fixed,
            //selectedItemColor: Color(0xFFf97e9c),
            selectedItemColor: Color(0xFFff8500),
            onTap: _onTap, // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text(AppLocalizations.of(context).home),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.favorite),
                title: new Text(AppLocalizations.of(context).favorite),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_offer),
                  title: Text(AppLocalizations.of(context).deals)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  title: Text(AppLocalizations.of(context).cart)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  title: Text(AppLocalizations.of(context).settings)),
            ],
          ),
          //backgroundColor: Theme.of(context).backgroundColor,
          body: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  !Login
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: (MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).padding.horizontal) *
                                0.03,
                          ),
                          child: Text(
                            AppLocalizations.of(context).Profile,
                            style: TextStyle(
                              color: Color(0xFFff8500),
                            ),
                          ),
                        ),
                  !Login
                      ? Container()
                      : SizedBox(
                          height: (MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).padding.top) *
                              0.03,
                        ),
                  !Login
                      ? Container()
                      : ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => profile(),
                                ));
                            //_launchURL("");
                            //Navigator.pushNamed(context, "/orders");
                          },
                          title: Text(
                            AppLocalizations.of(context).Account,
                          ),
                          leading: Icon(
                            Icons.person,
                            size: 24,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                  !Login
                      ? Container()
                      : SizedBox(
                          height: 20,
                        ),
                  !Login
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: (MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).padding.horizontal) *
                                0.03,
                          ),
                          child: Text(
                            AppLocalizations.of(context).order_info,
                            style: TextStyle(
                              color: Color(0xFFff8500),
                            ),
                          ),
                        ),
                  !Login
                      ? Container()
                      : SizedBox(
                          height: (MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).padding.top) *
                              0.03,
                        ),
                  !Login
                      ? Container()
                      : ListTile(
                          onTap: () {
                            // _launchURL("");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Order(),
                                ));
                            //Navigator.pushNamed(context, "/orders");
                          },
                          title: Text(
                            AppLocalizations.of(context).order_history,
                          ),
                          leading: Icon(
                            Icons.shopping_bag_outlined,
                            size: 24,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                  // Divider(
                  //   color: Theme.of(context).dividerColor,
                  // ),
                  !Login
                      ? Container()
                      : SizedBox(
                          height: (MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).padding.top) *
                              0.03,
                        ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: (MediaQuery.of(context).size.width -
                              MediaQuery.of(context).padding.horizontal) *
                          0.03,
                    ),
                    child: Text(
                      AppLocalizations.of(context).app_settings,
                      style: TextStyle(
                        color: Color(0xFFff8500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        0.03,
                  ),

                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "LanguagesScreen");
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => LanguagesScreen(onLocaleChange)),
                      // );
                    },
                    title: Text(AppLocalizations.of(context).language),
                    subtitle: Container(
                      child: Text(AppLocalizations.of(context).lang),
                      padding: EdgeInsets.only(top: 10),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    leading: Icon(
                      Icons.language,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).dividerColor,
                  ),
                  // ListTile(
                  //     trailing: Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         const SizedBox(width: 5),
                  //         Icon(
                  //           Icons.arrow_forward_ios,
                  //           size: 18,
                  //           color: Theme.of(context).iconTheme.color,
                  //         )
                  //       ],
                  //     ),
                  //     title: Text("myWishList"),
                  //     leading: Icon(
                  //       Icons.favorite_border,
                  //       color: Theme.of(context).iconTheme.color,
                  //     ),
                  //     onTap: () => {
                  //
                  //     }),
                  // Divider(
                  //   color: Theme.of(context).dividerColor,
                  // ),
                  ListTile(
                    onTap: () {
                      _launchURL("https://inspireui.com/about");
                    },
                    title: Text(
                      AppLocalizations.of(context).about_us,
                    ),
                    leading: Icon(
                      Icons.info_outline,
                      size: 24,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).dividerColor,
                  ),
                  ListTile(
                    onTap: () {
                      _launchURL(
                          "https://cdejewelry-egypt.com/policies/privacy-policy");
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => WebView(
                      //         url:
                      //         "https://cdejewelry-egypt.com/policies/privacy-policy",
                      //       ),
                      //     ));
                    },
                    title: Text(
                      AppLocalizations.of(context).privacy,
                    ),
                    leading: Icon(
                      Icons.supervised_user_circle_outlined,
                      size: 24,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: (MediaQuery.of(context).size.width -
                              MediaQuery.of(context).padding.horizontal) *
                          0.03,
                    ),
                    child: Text(
                      AppLocalizations.of(context).Communicate,
                      style: TextStyle(
                        color: Color(0xFFff8500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        0.03,
                  ),
                  ListTile(
                    onTap: () {
                      sharess(context);
                      // const String url =
                      //     "https://play.google.com/store/apps/details?id=com.inspireui.superK";
                      // final RenderBox box = context.findRenderObject();
                      // Share.share(url,
                      //     sharePositionOrigin:
                      //     box.localToGlobal(Offset.zero) & box.size);
                    },
                    title: Text(
                      AppLocalizations.of(context).share_app,
                    ),
                    leading: Icon(
                      Icons.share,
                      size: 24,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).dividerColor,
                  ),
                  ListTile(
                    onTap: () {
                      launchMailto('Info@Cdejewelry');
                      // customLaunch(
                      //     'mailto:Info@Cdejewelry-Egypt.Com?subject=%20subject&body=%20body');
                    },
                    title: Text(
                      AppLocalizations.of(context).send_mail,
                    ),
                    leading: Icon(
                      Icons.mail_outline,
                      size: 24,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).dividerColor,
                  ),
                  ListTile(
                    onTap: () {
                      customLaunch('tel:+2 01203230030');
                    },
                    title: Text(
                      AppLocalizations.of(context).call_us,
                    ),
                    leading: Icon(
                      Icons.call,
                      size: 24,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  // Divider(
                  //   color: Theme.of(context).dividerColor,
                  // ),
                  // SizedBox(
                  //   height: (MediaQuery.of(context).size.height -
                  //       MediaQuery.of(context).padding.top) *
                  //       0.05,
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: (MediaQuery.of(context).size.width -
                  //         MediaQuery.of(context).padding.horizontal) *
                  //         0.03,
                  //   ),
                  //   child: const Text(
                  //     'Exit',
                  //     style: TextStyle(
                  //       color: Color(0xFF1533e8),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: (MediaQuery.of(context).size.height -
                  //       MediaQuery.of(context).padding.top) *
                  //       0.02,
                  // ),
                  // ListTile(
                  //   onTap: () {
                  //     return showDialog(
                  //         context: context,
                  //         builder: (context) => AlertDialog(
                  //           title: Text("areYouSure"),
                  //           content: Text("doYouWantToExitApp"),
                  //           actions: <Widget>[
                  //             FlatButton(
                  //               onPressed: () =>
                  //                   Navigator.of(context).pop(false),
                  //               child: Text("no"),
                  //             ),
                  //             FlatButton(
                  //               onPressed: () => exit(0),
                  //               child: Text("yes"),
                  //             ),
                  //           ],
                  //         ));
                  //   },
                  //   title: const Text(
                  //     'Exit From App',
                  //   ),
                  //   leading: Icon(
                  //     Icons.exit_to_app_outlined,
                  //     size: 24,
                  //     color: Theme.of(context).iconTheme.color,
                  //   ),
                  //   trailing: Icon(
                  //     Icons.arrow_forward_ios,
                  //     size: 18,
                  //     color: Theme.of(context).iconTheme.color,
                  //   ),
                  // ),
                  // Divider(
                  //   color: Theme.of(context).dividerColor,
                  // ),
                  Login
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).padding.vertical) *
                                0.05,
                            horizontal: (MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).padding.horizontal) *
                                0.07,
                          ),
                          child: Container(
                            height: (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).padding.vertical) *
                                0.07,
                            child: OutlineButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.login,
                                    color: Theme.of(context).iconTheme.color,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: (MediaQuery.of(context).size.width -
                                            MediaQuery.of(context)
                                                .padding
                                                .horizontal) *
                                        0.03,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)
                                        .logout
                                        .toUpperCase(),
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ],
                              ),
                              borderSide: const BorderSide(
                                color: Color(0xFFff8500),
                                width: 2,
                              ),
                              onPressed: () async {
                                SharedPreferences sharedPrefs =
                                    await SharedPreferences.getInstance();
                                sharedPrefs.setBool("login", false);
                                setState(() {
                                  Login = false;
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .logout();
                                });
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => LoginPage()));
                              },
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).padding.vertical) *
                                0.05,
                            horizontal: (MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).padding.horizontal) *
                                0.07,
                          ),
                          child: Container(
                            height: (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).padding.vertical) *
                                0.07,
                            child: OutlineButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.login,
                                    color: Theme.of(context).iconTheme.color,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: (MediaQuery.of(context).size.width -
                                            MediaQuery.of(context)
                                                .padding
                                                .horizontal) *
                                        0.03,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)
                                        .login
                                        .toUpperCase(),
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ],
                              ),
                              borderSide: const BorderSide(
                                color: Color(0xFFff8500),
                                width: 2,
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                            ),
                          ),
                        ),
                ]),
              )
            ],
          )),
    );
  }

  _onTap(int tabIndex) {
    switch (tabIndex) {
      case 0:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Deals(),
            ));
        break;
      //_navigatorKey.currentState.pushReplacementNamed("Home");
      //break;
      case 1:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => favorite(),
            ));
        break;
      case 2:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Offers(
                SellerId: 3,
                MainCategroy: 1,
                CatId: 35,
              ),
            ));
        break;
      case 3:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Cart(),
            ));
        break;
      case 4:
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => Cart(),
        //     ));
        break;
      // _navigatorKey.currentState.pushReplacementNamed("Settings");
      // break;
    }
  }

  _launchURL(url) async {
    //const url = 'http://2steps4u.com/contact-us';
    if (await canLaunch(url)) {
      await launch(url);
      //Navigator.pop(context);
    }
  }

  sharess(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    Share.share(
        "https://play.google.com/store/apps/details?id=com.inspireui.superK",
        //subject: "https://play.google.com/store/apps/details?id=com.thanwya_app&fbclid=IwAR0bbk2aTHtvRvkWsiRKrLnnHNZOeBCoPs8Lipjz0MeJc-1RCmHQLm0H76A",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  launchMailto(emailC) async {
    final mailtoLink = Mailto(
      to: ['$emailC'],
      //cc: ['cc1@example.com', 'cc2@example.com'],
      subject: 'Urate Contact us',
      body: 'write in body',
    );
    // Convert the Mailto instance into a string.
    // Use either Dart's string interpolation
    // or the toString() method.
    await launch('$mailtoLink');
  }

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {}
  }
}
 */

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:share/share.dart';
import 'package:superk_new/Cart.dart';
import 'package:superk_new/Deals.dart';
import 'package:superk_new/Offers.dart';
import 'package:superk_new/Order.dart';
import 'package:superk_new/favorite_tow.dart';
import 'package:superk_new/locale/localization.dart';
import 'package:superk_new/login.dart';
import 'package:superk_new/profile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:superk_new/provider/auth.dart';

import 'Genral.dart';
import 'NewItems.dart';
import 'languages_screen.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SettingsState();
  }
}

class SettingsState extends State<Settings> {
  int tabIndex = 4;

  bool loggedIn;
  getsaveLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var login = pref.getBool('login') ?? false;
    if (login != null) {
      setState(() {
        loggedIn = login;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getsaveLogin();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("areYouSure"),
                  content: Text("doYouWantToExitApp"),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text("no"),
                    ),
                    FlatButton(
                      onPressed: () => exit(0),
                      child: Text("yes"),
                    ),
                  ],
                ));
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              AppLocalizations.of(context).settings,
              // style: Theme.of(context).textTheme.subtitle1.copyWith(
              //   //color: Color(0xFF1533e8),
              //   color: Colors.black
              //   //fontSize: 18,
              //   //letterSpacing: 2,
              // ),
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabIndex,
            type: BottomNavigationBarType.fixed,
            //selectedItemColor: Color(0xFFf97e9c),
            selectedItemColor: Color(0xFFff8500),
            onTap: _onTap, // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text(AppLocalizations.of(context).home),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.favorite),
                title: new Text(AppLocalizations.of(context).favorite),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.local_offer),
                  title: Text(AppLocalizations.of(context).deals)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  title: Text(AppLocalizations.of(context).cart)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  title: Text(AppLocalizations.of(context).settings)),
            ],
          ),
          //backgroundColor: Theme.of(context).backgroundColor,
          body: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  loggedIn == false
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: (MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).padding.horizontal) *
                                0.03,
                          ),
                          child: Text(
                            AppLocalizations.of(context).Profile,
                            style: TextStyle(
                              color: Color(0xFFff8500),
                            ),
                          ),
                        ),
                  loggedIn == false
                      ? Container()
                      : SizedBox(
                          height: (MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).padding.top) *
                              0.03,
                        ),
                  loggedIn == false
                      ? Container()
                      : ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => profile(),
                                ));
                            //_launchURL("");
                            //Navigator.pushNamed(context, "/orders");
                          },
                          title: Text(
                            AppLocalizations.of(context).Account,
                          ),
                          leading: Icon(
                            Icons.person,
                            size: 24,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                  loggedIn == false
                      ? Container()
                      : SizedBox(
                          height: 20,
                        ),
                  loggedIn == false
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: (MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).padding.horizontal) *
                                0.03,
                          ),
                          child: Text(
                            AppLocalizations.of(context).order_info,
                            style: TextStyle(
                              color: Color(0xFFff8500),
                            ),
                          ),
                        ),
                  loggedIn == false
                      ? Container()
                      : SizedBox(
                          height: (MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).padding.top) *
                              0.03,
                        ),
                  loggedIn == false
                      ? Container()
                      : ListTile(
                          onTap: () {
                            // _launchURL("");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Order(),
                                ));
                            //Navigator.pushNamed(context, "/orders");
                          },
                          title: Text(
                            AppLocalizations.of(context).order_history,
                          ),
                          leading: Icon(
                            Icons.shopping_bag_outlined,
                            size: 24,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                  // Divider(
                  //   color: Theme.of(context).dividerColor,
                  // ),
                  loggedIn == false
                      ? Container()
                      : SizedBox(
                          height: (MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).padding.top) *
                              0.03,
                        ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: (MediaQuery.of(context).size.width -
                              MediaQuery.of(context).padding.horizontal) *
                          0.03,
                    ),
                    child: Text(
                      AppLocalizations.of(context).app_settings,
                      style: TextStyle(
                        color: Color(0xFFff8500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        0.03,
                  ),

                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "LanguagesScreen");
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => LanguagesScreen(onLocaleChange)),
                      // );
                    },
                    title: Text(AppLocalizations.of(context).language),
                    subtitle: Container(
                      child: Text(AppLocalizations.of(context).lang),
                      padding: EdgeInsets.only(top: 10),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    leading: Icon(
                      Icons.language,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).dividerColor,
                  ),
                  // ListTile(
                  //     trailing: Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         const SizedBox(width: 5),
                  //         Icon(
                  //           Icons.arrow_forward_ios,
                  //           size: 18,
                  //           color: Theme.of(context).iconTheme.color,
                  //         )
                  //       ],
                  //     ),
                  //     title: Text("myWishList"),
                  //     leading: Icon(
                  //       Icons.favorite_border,
                  //       color: Theme.of(context).iconTheme.color,
                  //     ),
                  //     onTap: () => {
                  //
                  //     }),
                  // Divider(
                  //   color: Theme.of(context).dividerColor,
                  // ),
                  ListTile(
                    onTap: () {
                      _launchURL("https://inspireui.com/about");
                    },
                    title: Text(
                      AppLocalizations.of(context).about_us,
                    ),
                    leading: Icon(
                      Icons.info_outline,
                      size: 24,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).dividerColor,
                  ),
                  ListTile(
                    onTap: () {
                      _launchURL(
                          "https://cdejewelry-egypt.com/policies/privacy-policy");
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => WebView(
                      //         url:
                      //         "https://cdejewelry-egypt.com/policies/privacy-policy",
                      //       ),
                      //     ));
                    },
                    title: Text(
                      AppLocalizations.of(context).privacy,
                    ),
                    leading: Icon(
                      Icons.supervised_user_circle_outlined,
                      size: 24,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: (MediaQuery.of(context).size.width -
                              MediaQuery.of(context).padding.horizontal) *
                          0.03,
                    ),
                    child: Text(
                      AppLocalizations.of(context).Communicate,
                      style: TextStyle(
                        color: Color(0xFFff8500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        0.03,
                  ),
                  ListTile(
                    onTap: () {
                      sharess(context);
                      // const String url =
                      //     "https://play.google.com/store/apps/details?id=com.inspireui.superK";
                      // final RenderBox box = context.findRenderObject();
                      // Share.share(url,
                      //     sharePositionOrigin:
                      //     box.localToGlobal(Offset.zero) & box.size);
                    },
                    title: Text(
                      AppLocalizations.of(context).share_app,
                    ),
                    leading: Icon(
                      Icons.share,
                      size: 24,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).dividerColor,
                  ),
                  ListTile(
                    onTap: () {
                      launchMailto('Info@Cdejewelry');
                      // customLaunch(
                      //     'mailto:Info@Cdejewelry-Egypt.Com?subject=%20subject&body=%20body');
                    },
                    title: Text(
                      AppLocalizations.of(context).send_mail,
                    ),
                    leading: Icon(
                      Icons.mail_outline,
                      size: 24,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).dividerColor,
                  ),
                  ListTile(
                    onTap: () {
                      customLaunch('tel:+2 01203230030');
                    },
                    title: Text(
                      AppLocalizations.of(context).call_us,
                    ),
                    leading: Icon(
                      Icons.call,
                      size: 24,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  // Divider(
                  //   color: Theme.of(context).dividerColor,
                  // ),
                  // SizedBox(
                  //   height: (MediaQuery.of(context).size.height -
                  //       MediaQuery.of(context).padding.top) *
                  //       0.05,
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: (MediaQuery.of(context).size.width -
                  //         MediaQuery.of(context).padding.horizontal) *
                  //         0.03,
                  //   ),
                  //   child: const Text(
                  //     'Exit',
                  //     style: TextStyle(
                  //       color: Color(0xFF1533e8),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: (MediaQuery.of(context).size.height -
                  //       MediaQuery.of(context).padding.top) *
                  //       0.02,
                  // ),
                  // ListTile(
                  //   onTap: () {
                  //     return showDialog(
                  //         context: context,
                  //         builder: (context) => AlertDialog(
                  //           title: Text("areYouSure"),
                  //           content: Text("doYouWantToExitApp"),
                  //           actions: <Widget>[
                  //             FlatButton(
                  //               onPressed: () =>
                  //                   Navigator.of(context).pop(false),
                  //               child: Text("no"),
                  //             ),
                  //             FlatButton(
                  //               onPressed: () => exit(0),
                  //               child: Text("yes"),
                  //             ),
                  //           ],
                  //         ));
                  //   },
                  //   title: const Text(
                  //     'Exit From App',
                  //   ),
                  //   leading: Icon(
                  //     Icons.exit_to_app_outlined,
                  //     size: 24,
                  //     color: Theme.of(context).iconTheme.color,
                  //   ),
                  //   trailing: Icon(
                  //     Icons.arrow_forward_ios,
                  //     size: 18,
                  //     color: Theme.of(context).iconTheme.color,
                  //   ),
                  // ),
                  // Divider(
                  //   color: Theme.of(context).dividerColor,
                  // ),
                  loggedIn == true
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).padding.vertical) *
                                0.05,
                            horizontal: (MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).padding.horizontal) *
                                0.07,
                          ),
                          child: Container(
                            height: (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).padding.vertical) *
                                0.07,
                            child: OutlineButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.login,
                                    color: Theme.of(context).iconTheme.color,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: (MediaQuery.of(context).size.width -
                                            MediaQuery.of(context)
                                                .padding
                                                .horizontal) *
                                        0.03,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)
                                        .logout
                                        .toUpperCase(),
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ],
                              ),
                              borderSide: const BorderSide(
                                color: Color(0xFFff8500),
                                width: 2,
                              ),
                              onPressed: () async {
                                SharedPreferences sharedPrefs =
                                    await SharedPreferences.getInstance();
                                sharedPrefs.setBool("login", false);
                                setState(() {
                                  Login = false;
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .logout();
                                });
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => LoginPage()));
                              },
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).padding.vertical) *
                                0.05,
                            horizontal: (MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).padding.horizontal) *
                                0.07,
                          ),
                          child: Container(
                            height: (MediaQuery.of(context).size.height -
                                    MediaQuery.of(context).padding.vertical) *
                                0.07,
                            child: OutlineButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.login,
                                    color: Theme.of(context).iconTheme.color,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: (MediaQuery.of(context).size.width -
                                            MediaQuery.of(context)
                                                .padding
                                                .horizontal) *
                                        0.03,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)
                                        .login
                                        .toUpperCase(),
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ],
                              ),
                              borderSide: const BorderSide(
                                color: Color(0xFFff8500),
                                width: 2,
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                            ),
                          ),
                        ),
                ]),
              )
            ],
          )),
    );
  }

  _onTap(int tabIndex) {
    switch (tabIndex) {
      case 0:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Deals(),
            ));
        break;
      //_navigatorKey.currentState.pushReplacementNamed("Home");
      //break;
      case 1:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => favorite(),
            ));
        break;
      case 2:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Offers(
                SellerId: 3,
                MainCategroy: 1,
                CatId: 35,
              ),
            ));
        break;
      case 3:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Cart(),
            ));
        break;
      case 4:
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => Cart(),
        //     ));
        break;
      // _navigatorKey.currentState.pushReplacementNamed("Settings");
      // break;
    }
  }

  _launchURL(url) async {
    //const url = 'http://2steps4u.com/contact-us';
    if (await canLaunch(url)) {
      await launch(url);
      //Navigator.pop(context);
    }
  }

  sharess(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    Share.share(
        "https://play.google.com/store/apps/details?id=com.inspireui.superK",
        //subject: "https://play.google.com/store/apps/details?id=com.thanwya_app&fbclid=IwAR0bbk2aTHtvRvkWsiRKrLnnHNZOeBCoPs8Lipjz0MeJc-1RCmHQLm0H76A",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  launchMailto(emailC) async {
    final mailtoLink = Mailto(
      to: ['$emailC'],
      //cc: ['cc1@example.com', 'cc2@example.com'],
      subject: 'Urate Contact us',
      body: 'write in body',
    );
    // Convert the Mailto instance into a string.
    // Use either Dart's string interpolation
    // or the toString() method.
    await launch('$mailtoLink');
  }

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {}
  }
}
