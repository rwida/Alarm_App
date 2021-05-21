import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:superk_new/AuthProvider.dart';
import 'package:superk_new/Deals.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:superk_new/MyHomePage.dart';
import 'package:superk_new/homeScreen.dart';
import 'package:superk_new/invoice/invoice.dart';
import 'package:superk_new/languages_screen.dart';
import 'package:superk_new/locale/localization.dart';
import 'package:superk_new/login.dart';
import 'package:superk_new/new_deals.dart';
import 'package:superk_new/product_detail_page_linking.dart';
import 'package:superk_new/profile.dart';
import 'package:superk_new/provider/auth.dart';
import 'package:superk_new/settings_screen.dart';
import 'package:superk_new/splash_screens.dart';
import 'package:superk_new/test_pro.dart';
import 'package:superk_new/ui/homePage.dart';
import 'package:superk_new/user_location.dart';
import 'Genral.dart';
import 'NewItems.dart';
import 'Order.dart';
import 'Registration.dart';
import 'Settings.dart';
import 'invoice/new_invoice.dart';

Future<void> main() async {
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),
  // );
  //EasyLocalization(child: MyApp());
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // runApp(EasyLocalization(child: MyApp()));
}

typedef LocaleChangeCallback(Locale locale);

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  String defaultLocale;
  int checklang = 0;
  SpecificLocalizationDelegate _specificLocalizationDelegate;
  @override
  void initState() {
    super.initState();
    //handleDynamicLinks();
    initDynamicLinks();
    defaultLocale = Platform.localeName;
    if (defaultLocale.contains('ar')) {
      _specificLocalizationDelegate =
          new SpecificLocalizationDelegate(new Locale("ar"));
    } else {
      _specificLocalizationDelegate =
          new SpecificLocalizationDelegate(new Locale("en"));
    }
    checkMap();
  }

  onLocaleChange(Locale locale) {
    setState(() {
      _specificLocalizationDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  checkMap() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    if (sharedPrefs.getBool("login") == true) {
      setState(() {
        Login = true;
      });
    }
    if (sharedPrefs.getString("lat") != null) {
      setState(() {
        checklang = 1;
        Lat = sharedPrefs.getString("lat");
        Long = sharedPrefs.getString("lng");
      });
    }

    if (sharedPrefs.getString("language") != null) {
      setState(() {
        Langs = sharedPrefs.getString('language');
      });
      print(
          "jhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh ${sharedPrefs.getString('language')}");
      onLocaleChange(Locale(sharedPrefs.getString('language')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            _specificLocalizationDelegate
          ],
          theme: ThemeData(
            primaryColor: Color(0xFF13446f),
            accentColor: Color(0xFFff8500),
            cursorColor: Color(0xFFff8500),
            colorScheme: ColorScheme.light(primary: const Color(0xFFff8500)),
          ),
          supportedLocales: [Locale('en'), Locale('ar')],
          locale: _specificLocalizationDelegate.overriddenLocale,
          //locale: DevicePreview.locale(context), // Add the locale here
          //builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          title: 'Clean Code',
          home: AnimatedSplashScreen(
              duration: 4000,
              splash: Image.asset("images/2.png"),
              nextScreen: checklang == 1 ? Deals() : UserLocation(),
              splashIconSize: 500,
              splashTransition: SplashTransition.rotationTransition,
              pageTransitionType: PageTransitionType.bottomToTop,
              backgroundColor: Colors.white),
          //home: Splash(),
          routes: <String, WidgetBuilder>{
            "LanguagesScreen": (BuildContext context) =>
                new LanguagesScreen(onLocaleChange),
          }),
    );
  }

  void handleDynamicLinks() async {
    ///To bring INTO FOREGROUND FROM DYNAMIC LINK.
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
        await _handleDeepLink(dynamicLinkData);
      },
      onError: (OnLinkErrorException e) async {
        print('DynamicLink Failed: ${e.message}');
        return e.message;
      },
    );

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    _handleDeepLink(data);
  }

  _handleDeepLink(PendingDynamicLinkData data) async {
    final deeplink = data.link;
    if (deeplink != null) {
      print('Handling Deep Link | deepLink: $deeplink');
    }
  }

  void initDynamicLinks() async {
    //var xx = await createDynamicLink(userName: "mohamed_nabil");
    // print("yourrrrrrrrrrrrrrrrrrr link is $xx");
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        final queryParams = deepLink.queryParameters;
        if (queryParams.length > 0) {
          String userName = queryParams["username"];
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage_linking(
                  id: int.parse(userName),
                ),
              ));
          // verify the username is parsed correctly
          print("My users username is: $userName");
        } else {
          print("$deepLink 55555555555555555555555555555555555555555555555");
        }
        //Navigator.pushNamed(context, deepLink.path);
        // print("${deepLink.query} 55555555555555555555555555555555555555555555555");
        // print("${deepLink.queryParameters['name']} 88888888888888888888888888888");
        // //print("${deepLink.queryParameters.keys} 55555555555555555555555555555555555555555555555");
        // //print("${deepLink.data.uri} 666666666666666666666666666");
        // print("${deepLink.origin} 77777777777777777777777777777777");
        // print("${deepLink.hasAuthority} 55555555555555555555555555555555555555555555555");
        // print("${deepLink.data} 55555555555555555555555555555555555555555555555");
        // print("${deepLink.queryParameters} 55555555555555555555555555555555555555555555555");
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      final queryParams = deepLink.queryParameters;
      if (queryParams.length > 0) {
        String userName = queryParams['username'];
        // verify the username is parsed correctly
        print("My users username is: $userName");
      } else {
        print("55555555555555555555555555555555555555555555555");
      }
      // print("${deepLink.query} 55555555555555555555555555555555555555555555555");
      // print("${deepLink.queryParameters['name']} 88888888888888888888888888888");
      // //print("${deepLink.data.uri} 6666666666666666666666");
      // print("${deepLink.origin} 77777777777777777777777777");
      // print("${deepLink.hasAuthority} 55555555555555555555555555555555555555555555555");
      // print("${deepLink.data.parameters} 55555555555555555555555555555555555555555555555");
      // print("${deepLink.queryParameters} 55555555555555555555555555555555555555555555555");
      //Navigator.pushNamed(context, deepLink.path);
    }
  }
}
