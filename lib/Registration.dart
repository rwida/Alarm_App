import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:superk_new/Genral.dart';
import 'package:superk_new/Settings.dart';
import 'dart:math';

import 'package:superk_new/login.dart';

import 'locale/localization.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with ValidationMixin{
  final key = new GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtUsername = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();
  TextEditingController txtPhone = new TextEditingController();
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text( AppLocalizations.of(context).back,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
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
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }


  Widget passwordInputField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child:  Theme(
        data: new ThemeData(
            primaryColor: Color(0xFFff8500),
            //accentColor: Color(0xFF13446f),
            hintColor: Colors.grey
        ),
        child:TextFormField(
            controller: txtPassword,
            obscureText: true,
            onSaved: (String value){
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
            )),),
    );
  }
  Widget emailInputField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Theme(
        data: new ThemeData(
            primaryColor: Color(0xFFff8500),
            //accentColor: Color(0xFF13446f),
            hintColor: Colors.grey
        ),
        child:TextFormField(
          controller: txtEmail,
          //autofocus: true,
          onSaved: (String value){
            print(value);
          },
          validator: emailValidationMixin,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).Email,
            hintText: Langs=="ar"?'':'you@example.com',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Color(0xfff3f3f4),
            filled: true,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
          ),),),);
  }
  Widget usernameInputField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Theme(
        data: new ThemeData(
            primaryColor: Color(0xFFff8500),
            //accentColor: Color(0xFF13446f),
            hintColor: Colors.grey
        ),
        child:TextFormField(
          controller: txtUsername,
          //autofocus: true,
          onSaved: (String value){
            print(value);
          },
          validator: usernameValidationMixin,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).Username,
            //hintText: Langs=="ar"?'':'you@example.com',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Color(0xfff3f3f4),
            filled: true,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
          ),),),);
  }
  Widget PhoneInputField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Theme(
        data: new ThemeData(
            primaryColor: Color(0xFFff8500),
            //accentColor: Color(0xFF13446f),
            hintColor: Colors.grey
        ),
        child:TextFormField(
          controller: txtPhone,
          //autofocus: true,
          onSaved: (String value){
            print(value);
          },
          validator: phoneValidationMixin,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).phone,
            //hintText: Langs=="ar"?'':'you@example.com',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: Color(0xfff3f3f4),
            filled: true,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
          ),),),);
  }
  Widget _submitButton() {
    return InkWell(child: Container(
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
              colors: [Color(0xFF13446f), Color(0xFF1e527f)])),
      child: Text(
        AppLocalizations.of(context).Register,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),onTap: () async {
      if(formKey.currentState.validate())
        formKey.currentState.save();

        String x = await RegisterAPI();
        print(x.toString());
        if(x == "success"){
          //Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Settings()));
        }else{
          txtEmail.clear();
          txtPassword.clear();
          txtUsername.clear();
          txtPhone.clear();
          key.currentState.showSnackBar(new SnackBar(duration: const Duration(seconds: 8),
            content: new Text(AppLocalizations.of(context).login_error_message,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
          ));
        }



    },);
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage()));
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        //margin: EdgeInsets.symmetric(vertical: 20),
       // padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).Already_have,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              AppLocalizations.of(context).login,
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

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        usernameInputField(),
        emailInputField(),
        passwordInputField(),
        PhoneInputField(),
       // _entryField("Username"),
       // _entryField("Email id"),
       // _entryField("Password", isPassword: true),
      ],
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
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: Container(
                  child: Transform.rotate(
                    angle: -pi / 3.5,
                    child: ClipPath(
                      clipper: ClipPainter(),
                      child: Container(
                        height: MediaQuery.of(context).size.height *.5,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFF13446f),Color(0xFF1e527f)]
                            )
                        ),
                      ),
                    ),
                  )
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(key: formKey,child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .1),
                    //_title(),
                    Image.asset("images/superk2.png",width: 150,height: 150,),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 50,
                    ),
                    _submitButton(),
                    SizedBox(height: height * .08),
                    _loginAccountLabel(),
                  ],
                ),),
              ),
            ),
            Positioned(top: 20, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }

  RegisterAPI() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    // print("user id is ${sharedPrefs.getString('UserId')}");
    final coordinates = new Coordinates(double.parse("${sharedPrefs.getString("lat")}"), double.parse("${sharedPrefs.getString("lng")}"));
    print("@@@@@@@@@@@@@@@@@@@@@@@ $Lat $Long");
    debugPrint('coordinates is: $coordinates');
    var addresses =
    await Geocoder.google("AIzaSyB-zre1gZSbbXHdzyGeWNnjGRbtVFZYbNs").findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    var d ={
      "name":"${txtUsername.text}",
      "password":"${txtPassword.text}",
      "email":"${txtEmail.text}",
      "address":"${first.featureName.toString()}",
      "phone":"${txtPhone.text}",
      "latitude":"${sharedPrefs.getString("lat")}",
      "longitude":"${sharedPrefs.getString("lng")}"
    };
    http.Response response = await http.post('http://wootc.net/api/authentication/register',body: json.encode(d),headers: { "Accept":"application/json",'Content-type': 'application/json',});
    print(response.body.toString());
    var responsebody = json.decode(response.body);
    if(responsebody['Status'] == true){
      sharedPrefs.setBool("login", true);
      sharedPrefs.setString("name", "${responsebody['Customer']['name']}");
      sharedPrefs.setString("email", "${responsebody['Customer']['email']}");
      sharedPrefs.setString("phone", "${responsebody['Customer']['phone']}");
      sharedPrefs.setString("address", "${responsebody['Customer']['address']}");
      sharedPrefs.setString("UserId", "${responsebody['Customer']['id']}");
      setState((){
        Login = true;
      });
      return 'success';
    }else{
      return 'error';
    }
  }
}
class ValidationMixin{
  String emailValidationMixin(String value){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    if(!emailValid)
      // if(!value.contains('@gmail.com'))
      return "Invalid Email address !";
    return null;
  }
  String passwordValidationMixin(String value){
    if(value.length < 8)
      return 'Password must be atleast 8 characters';
    return null;
  }
  String usernameValidationMixin(String value){
    if(value.length < 6)
      return 'username must be atleast 6 characters';
    return null;
  }
  String phoneValidationMixin(String value){
    if(value.length < 11)
      return 'phone number must be atleast 11 number';
    return null;
  }
}
class ClipPainter extends CustomClipper<Path>{
  @override

  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    var path = new Path();

    path.lineTo(0, size.height );
    path.lineTo(size.width , height);
    path.lineTo(size.width , 0);

    /// [Top Left corner]
    var secondControlPoint =  Offset(0  ,0);
    var secondEndPoint = Offset(width * .2  , height *.3);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);



    /// [Left Middle]
    var fifthControlPoint =  Offset(width * .3  ,height * .5);
    var fiftEndPoint = Offset(  width * .23, height *.6);
    path.quadraticBezierTo(fifthControlPoint.dx, fifthControlPoint.dy, fiftEndPoint.dx, fiftEndPoint.dy);


    /// [Bottom Left corner]
    var thirdControlPoint =  Offset(0  ,height);
    var thirdEndPoint = Offset(width , height  );
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy, thirdEndPoint.dx, thirdEndPoint.dy);



    path.lineTo(0, size.height  );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }


}