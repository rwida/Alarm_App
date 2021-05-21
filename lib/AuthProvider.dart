import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class HomePage3 extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage3> {
  final _auth = FirebaseAuth.instance;
  bool loggedIn = false;
  bool _isLoggedIn = false;
  GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Codesundar")),
      body: Container(
        child: _isLoggedIn
            ? Column(
          children: [
            Image.network(_userObj.photoUrl),
            Text(_userObj.displayName),
            Text(_userObj.email),
            TextButton(
                onPressed: () {
                  loginGoogle(context);
                  _googleSignIn.signOut().then((value) {
                    setState((){
                      _isLoggedIn = false;
                    });
                  }).catchError((e) {});
                },
                child: Text("Logout"))
          ],
        )
            : Center(
          child: ElevatedButton(
            child: Text("Login with Google"),
            onPressed: () {
              loginGoogle(context);
              // _googleSignIn.signIn().then((userData) {
              //   setState(() {
              //     _isLoggedIn = true;
              //     _userObj = userData;
              //   });
              // }).catchError((e) {
              //   print(e);
              // });
            },
          ),
        ),
      ),
    );
  }


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
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (_) => HomePage()));
        });
        var _user = _auth.currentUser;
        print("User Name: ${_user.displayName}");
        print("User Email ${_user.email}");
        // await saveUserdata(
        //     _user.displayName, _user.email, _user.photoURL, true);
        // notifyListeners();
        setState(() {

        });
      }
    } catch (err) {
      print("Please Check Connection to the internet  $err");
    }
  }
}