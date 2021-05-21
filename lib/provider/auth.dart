import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert' as json;

import 'package:superk_new/Settings.dart';

class AuthProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  bool loggedIn = false;

  Future<void> loginGoogle(BuildContext context) async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
      final http.Response response = await http.get(
        'https://people.googleapis.com/v1/people/me/connections'
        '?requestMask.includeField=person.names',
      );
      if (response == null) {
      } else {
        GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _auth.signInWithCredential(credential).then((value) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => Settings()));
        });
        var _user = _auth.currentUser;
        print("User Name: ${_user.displayName}");
        print("User Email ${_user.email}");
        await saveUserdata(_user.displayName, _user.email, true);
        notifyListeners();
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> loginFB(context) async {
    try {
      FacebookLogin facebooklogin = FacebookLogin();
      facebooklogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
      final result = await facebooklogin.logIn(['email', 'public_profile']);
      final tokenFB = result.accessToken.token;
      final graphResponse = await http.get(
          'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$tokenFB');
      final profile = json.jsonDecode(graphResponse.body);
      print(profile);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          FacebookAccessToken myToken = result.accessToken;
          AuthCredential credential =
              FacebookAuthProvider.credential(myToken.token);
          var user =
              await FirebaseAuth.instance.signInWithCredential(credential);
          print("User Name: ${user.user.displayName}");
          print("User Email ${user.user.email}");
          await saveUserdata(user.user.displayName, user.user.email, true)
              .then((value) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Settings()));
          });
          notifyListeners();
          break;
        case FacebookLoginStatus.cancelledByUser:
          print('cancel');
          break;
        case FacebookLoginStatus.error:
          print(result.errorMessage);
          break;
      }
      notifyListeners();
    } catch (err) {
      print(err.toString());
    }
  }

  /* Future<void> saveUserdata(username, email, photo, bool islogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setBool('loggedIn', islogin);
      await prefs.setString('uusername', username);
      await prefs.setString('uuseremail', email);
      await prefs.setString('uuserphoto', photo);
    } catch (err) {
      print(err);
    }
    notifyListeners();
  } */

  Future<void> saveUserdata(username, email, bool islogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setBool('login', islogin);
      await prefs.setString('name', username);
      await prefs.setString('email', email);
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  Future<void> logout() async {
    loggedIn = false;
    try {
      _auth.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('login', false);
      await prefs.remove('name');
      await prefs.remove('email');
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }
}
