import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:superk_new/AuthProvider.dart';
import 'dart:math';
import 'package:superk_new/Registration.dart';
import 'package:superk_new/Settings.dart';
import 'package:superk_new/locale/localization.dart';
import 'package:superk_new/provider/auth.dart';
import 'Genral.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationMixin {
  bool _isLoggedIn = false;
  GoogleSignInAccount _userObj;
  bool _isLoggedInFace = false;
  Map _userObjFace = {};
  GoogleSignIn _googleSignIn = GoogleSignIn();
  int x = 0;
  final key = new GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String error = '';

  String errorphone = '';

  TextEditingController txtEmail = new TextEditingController();

  TextEditingController txtPassword = new TextEditingController();

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Settings()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text(AppLocalizations.of(context).back,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Theme(
            data: new ThemeData(
                primaryColor: x == 0 ? Color(0xff1e527f) : Colors.red,
                primaryColorDark: Colors.red,
                cursorColor: Color(0xffe46b10)),
            child: TextField(
                controller: controller,
                obscureText: isPassword,
                decoration: InputDecoration(
                    //border: InputBorder.none,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      //borderRadius: BorderRadius.circular(10),
                    ),
                    //border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true)),
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        if (formKey.currentState.validate()) formKey.currentState.save();
        setState(() {
          x = 1;
          error = '';
          errorphone = '';
        });
        print(x.toString());
        bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(txtEmail.text);
        if (!emailValid) {
          setState(() {
            error = "Email Not Maching";
          });
        } else {
          String x = await LoginAPI();
          print(x.toString());
          if (x == "success") {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Settings()));
          } else {
            txtEmail.clear();
            txtPassword.clear();
            key.currentState.showSnackBar(new SnackBar(
              duration: const Duration(seconds: 8),
              content: new Text(
                AppLocalizations.of(context).login_error_message,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ));
          }
        }

        //Navigator.pop(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF1e527f), Color(0xff03447a)])),
        child: Text(
          AppLocalizations.of(context).login,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return InkWell(
      onTap: () {
        Provider.of<AuthProvider>(context, listen: false).loginFB(context);
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff1959a9),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text('f',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff2872ba),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text(AppLocalizations.of(context).login_facebook,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _googleButton() {
    return InkWell(
      onTap: () {
        Provider.of<AuthProvider>(context, listen: false).loginGoogle(context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            border: Border.all(color: Colors.blueAccent)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                height: 38.0, // 40dp - 2*1dp border
                width: 38.0, // matches above
                // decoration: BoxDecoration(
                //   //color: darkMode ? Colors.white : null,
                //   borderRadius: BorderRadius.circular(this.defaultBorderRadius),
                // ),
                child: Center(
                  child: Image(
                    image: AssetImage(
                      "images/google-logo.png",
                    ),
                    height: 18.0,
                    width: 18.0,
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.0 /* 24.0 - 10dp padding */),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        //margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).dont_have,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              AppLocalizations.of(context).Register,
              style: TextStyle(
                  color: Color(0xFFff8500),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'd',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'ev',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'rnz',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget emailInputField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Theme(
        data: new ThemeData(
            primaryColor: Color(0xFFff8500),
            //accentColor: Color(0xFF13446f),
            hintColor: Colors.grey),
        child: TextFormField(
          controller: txtEmail,
          //autofocus: true,
          onSaved: (String value) {
            print(value);
          },
          validator: emailValidationMixin,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).Email,
            hintText: Langs == "ar" ? '' : 'you@example.com',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Color(0xfff3f3f4),
            filled: true,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        // emailInputField(),

        _entryField(AppLocalizations.of(context).Email, txtEmail),
        Row(
          children: [
            Text(
              "$error",
              style: TextStyle(color: Colors.red, fontSize: 11),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        // passwordInputField(),
        _entryField(
          AppLocalizations.of(context).Password,
          txtPassword,
          isPassword: true,
        ),
        Row(
          children: [
            Text(
              "$errorphone",
              style: TextStyle(color: Colors.red, fontSize: 11),
            ),
          ],
        ),
      ],
    );
  }

  Widget passwordInputField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Theme(
        data: new ThemeData(
            primaryColor: Color(0xFFff8500),
            //accentColor: Color(0xFF13446f),
            hintColor: Colors.grey),
        child: TextFormField(
            controller: txtPassword,
            obscureText: true,
            onSaved: (String value) {
              print(value);
            },
            validator: passwordValidationMixin,
            decoration: InputDecoration(
              // fillColor: Color(0xfff3f3f4),
              labelText: AppLocalizations.of(context).Password,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              fillColor: Color(0xfff3f3f4),
              filled: true,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        key: key,
        body: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: Container(
                      child: Transform.rotate(
                    angle: -pi / 3.5,
                    child: ClipPath(
                      clipper: ClipPainter(),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Color(0xff1e527f),
                              Color(0xff03447a)
                            ])),
                      ),
                    ),
                  ))),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .1),
                        Image.asset(
                          "images/superk2.png",
                          width: 150,
                          height: 150,
                        ),
                        // _title(),
                        SizedBox(height: 40),
                        // _emailPasswordWidget(),
                        emailInputField(),

                        //SizedBox(height: 20),
                        passwordInputField(),
                        SizedBox(height: 40),
                        _submitButton(),
                        // SizedBox(height: 20),
                        // passwordInputField(),
                        // SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerRight,
                          child: Text(
                              AppLocalizations.of(context).Forgot_Password,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                        _divider(),
                        _facebookButton(),
                        _googleButton(),
                        SizedBox(height: height * .03),
                        _createAccountLabel(),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(top: 20, left: 0, child: _backButton()),
            ],
          ),
        ));
  }

  LoginAPI() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    // print("user id is ${sharedPrefs.getString('UserId')}");
    var d = {"email": "${txtEmail.text}", "password": "${txtPassword.text}"};
    http.Response response = await http.post(
        'http://wootc.net/api/authentication/login',
        body: json.encode(d),
        headers: {
          "Accept": "application/json",
          'Content-type': 'application/json',
        });
    print(response.body.toString());
    var responsebody = json.decode(response.body);
    if (responsebody['Status'] == true) {
      sharedPrefs.setBool("login", true);
      sharedPrefs.setString("name", "${responsebody['Customer']['name']}");
      sharedPrefs.setString("email", "${responsebody['Customer']['email']}");
      sharedPrefs.setString("phone", "${responsebody['Customer']['phone']}");
      sharedPrefs.setString(
          "address", "${responsebody['Customer']['address']}");
      sharedPrefs.setString("UserId", "${responsebody['Customer']['id']}");
      setState(() {
        Login = true;
      });
      return 'success';
    } else {
      return 'error';
    }
  }
}

class ValidationMixin {
  String emailValidationMixin(String value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!emailValid)
      // if(!value.contains('@gmail.com'))
      return "Invalid Email address !";
    return null;
  }

  String passwordValidationMixin(String value) {
    if (value.length < 8) return 'Password must be atleast 8 characters';
    return null;
  }
}
