/* import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:superk_new/Cart.dart';
import 'package:superk_new/Deals.dart';
import 'package:superk_new/NewItems.dart';
import 'package:superk_new/Settings.dart';
import 'package:superk_new/favorite_tow.dart';
import 'package:superk_new/locale/localization.dart';
import 'package:superk_new/profile_menu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:superk_new/user_location.dart';
import 'package:http/http.dart' as http;
import 'package:superk_new/user_location2.dart';

class profile extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return profileState();
  }

}
class profileState extends State<profile>{
  int tabIndex = 3;
  String username = '';
  String email = '';
  String phone = '';
  int groub = 0;
  List BRANCHES = [];
  List BRANCHES2 = [];

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getSellerName ();
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme:IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        //backgroundColor: Color(0xFF1533e8),
        title: Text(AppLocalizations.of(context).profile,style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            // SizedBox(
            //   height: 115,
            //   width: 115,
            //   child: Stack(
            //     fit: StackFit.expand,
            //     overflow: Overflow.visible,
            //     children: [
            //       CircleAvatar(
            //         backgroundImage: NetworkImage("https://soundforums.net/community/data/avatars/o/14/14453.jpg?1607066553"),
            //       ),
            //       Positioned(
            //         right: -16,
            //         bottom: 0,
            //         child: SizedBox(
            //           height: 46,
            //           width: 46,
            //           child: FlatButton(
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(50),
            //               side: BorderSide(color: Colors.white),
            //             ),
            //             color: Color(0xFFF5F6F9),
            //             onPressed: () {},
            //             child: SvgPicture.asset("images/Camera Icon.svg"),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            SizedBox(height: 20),
            ProfileMenu(
              text: "$username",
              icon: "images/User Icon.svg",
              press: () => {},
            ),
            ProfileMenu(
              text: "$email",
              icon: "images/Mail.svg",
              press: () {},
            ),
            // ProfileMenu(
            //   text: "Password",
            //   icon: "images/Lock.svg",
            //   press: () {},
            // ),
            ProfileMenu(
              text: "$phone",
              icon: "images/Phone.svg",
              press: () {},
            ),
            ProfileMenu(
              text: AppLocalizations.of(context).Location,
              icon: "images/Location point.svg",
              press: () {
                _changeBranch();
                // Navigator.pushReplacement(
                // context, MaterialPageRoute(builder: (context) => UserLocation()));
                },
            ),
          ],
        ),
      ),

    );

  }
  _changeBranch() {
    showModalBottomSheet<void>(
        backgroundColor: Colors.white,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0))),
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              height: (100 * BRANCHES.length) + 50.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(children: [
                      InkWell(child: Icon(Icons.add_location_alt_outlined,color:Color(0xFF13446f) ,),onTap:(){
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => user_location2(Page: 'profile',)));
                      } ,),
                      // IconButton(icon: Icon(Icons.home,color:Color(0xFF13446f) ,), onPressed: null)
                      Spacer(),
                      Text(
                        AppLocalizations.of(context).Select_Location,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Text(
                        "",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w500),
                      ),
                    ],),
                  ),
                  // SizedBox(height: 5,),
                  // Row(children: [
                  //   InkWell(child: Icon(Icons.home,color:Color(0xFF13446f) ,),),
                  //  // IconButton(icon: Icon(Icons.home,color:Color(0xFF13446f) ,), onPressed: null)
                  //   Spacer(),
                  //   Text(
                  //     "SELECT LOCATION",
                  //     style: TextStyle(
                  //         fontSize: 18.0, fontWeight: FontWeight.w500),
                  //   ),
                  //   Spacer(),
                  //   Text(
                  //     "",
                  //     style: TextStyle(
                  //         fontSize: 18.0, fontWeight: FontWeight.w500),
                  //   ),
                  // ],),
                  // SizedBox(height: 5,),
                  Expanded(
                    child: ListView.builder(
                        itemCount: BRANCHES.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            // onTap: () =>
                            //     _onBranchSelected(_myBranches[index].id),
                            child: Container(
                              padding: EdgeInsets.only(left:8 ,right: 8),
                              margin: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                  color: Color(0xFF13446f),
                                  borderRadius: BorderRadius.circular(50.0),
                                  border:
                                  Border.all(color: Colors.grey[200])),
                              child: Row(children: [
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    unselectedWidgetColor: Colors.white38,
                                    //disabledColor: Colors.blue
                                  ),
                                  child:Radio(
                                      activeColor: Colors.white,
                                      value: BRANCHES[index]['id'],
                                      hoverColor: Colors.white,
                                      groupValue: groub,
                                      onChanged: (T) async {
                                        print(T);
                                        SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
                                        setState(() {
                                          groub = T;
                                          sharedPrefs.setInt("AddressId", T);
                                         // BranchName = BRANCHES[index]['name'];
                                        });
                                        Navigator.of(context).pop();
                                      }),),
                                //Spacer(),
                                Text("${BRANCHES[index]['address']}".length > 40 ? '${"${BRANCHES[index]['address']}".substring(0,40)}':"${BRANCHES[index]['address']}",style: TextStyle(fontSize: 14,color: Colors.white),),
                                // Text(
                                //   '${BRANCHES[index]['address']}',
                                //   overflow: TextOverflow.ellipsis,
                                //   maxLines: 2,
                                //   style: TextStyle(
                                //     color: Colors.white,
                                //     fontFamily: 'jana',
                                //     fontSize: 14,
                                //   ),
                                // ),
                                Spacer(),
                                InkWell(child:Icon(Icons.delete_forever_outlined,color:Colors.red ,),onTap:(){
                                  DeleteAddress(BRANCHES[index]['id'].toString());
                                },),
                              ],),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
    //print(map);
  });
}
void getSellerName() async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  http.Response response = await http.get('http://wootc.net/api/customer_location/show?email=${sharedPrefs.getString("email")}&access_token=syEt93K5Gsg2Ozdgv8oK22NQLYNzMJtiLHD06JMrpkqF05Kc5VCl9aeWgpcdAB6r',headers: {"Accept":"application/json"},);
  Map map = json.decode(response.body);
  print(map);
  //BRANCHES.clear();
  if(map['Status'] == true){
    BRANCHES =map['Customer Locations'];
  }
  for(int x = 0;x<map['Customer Locations'].length;x++){
    final coordinates = new Coordinates(double.parse("${map['Customer Locations'][x]['latitude']}"), double.parse("${map['Customer Locations'][x]['longitude']}"));
    var addresses =
    await Geocoder.google("AIzaSyB-zre1gZSbbXHdzyGeWNnjGRbtVFZYbNs").findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
// print number of retured addresses
    debugPrint('${addresses.length}');
// print the best address
    debugPrint("${first.featureName} : ${first.addressLine}");
    setState(() {
      BRANCHES2.add(first.featureName.toString());
      // Address = first.featureName.toString();
    });

  }

}

getData() async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  setState(() {
    username = sharedPrefs.getString("name");
    email = sharedPrefs.getString("email");
    phone = sharedPrefs.getString("phone");
    groub= sharedPrefs.getInt("AddressId");
  });

  // username = sharedPrefs.getString("name");
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
            builder: (context) => Cart(),
          ));
      break;
  // _navigatorKey.currentState.pushReplacementNamed("Settings");
  // break;
    case 3:
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => Cart(),
    //     ));
      break;
    case 4:
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Settings(),
          ));
      break;
  }

}


void DeleteAddress(id) async {
  http.Response response = await http.get('http://wootc.net/api/customer_location/delete/$id',headers: {"Accept":"application/json"},);
  Map map = json.decode(response.body);
    //BRANCHES.clear();
    if(map['Status'] == true){
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => profile()));
    }
  }
} */

import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:superk_new/Cart.dart';
import 'package:superk_new/Deals.dart';
import 'package:superk_new/NewItems.dart';
import 'package:superk_new/Settings.dart';
import 'package:superk_new/favorite_tow.dart';
import 'package:superk_new/locale/localization.dart';
import 'package:superk_new/profile_menu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:superk_new/user_location.dart';
import 'package:http/http.dart' as http;
import 'package:superk_new/user_location2.dart';

class profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return profileState();
  }
}

class profileState extends State<profile> {
  int tabIndex = 3;
  //String username = '';
  //String email = '';
  String phone = '';
  int groub = 0;
  List BRANCHES = [];
  List BRANCHES2 = [];

  bool loggedIn;
  String username, useremail;

  getsaveLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var login = pref.getBool('login') ?? false;
    var usernames = pref.getString('name') ?? "";
    var useremails = pref.getString('email') ?? "";
    if (login != null || username != null || useremail != null) {
      setState(() {
        loggedIn = login;
        username = usernames;
        useremail = useremails;
        phone = pref.getString("phone");
        groub = pref.getInt("AddressId");
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsaveLogin();
    //getData();
    getSellerName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        //backgroundColor: Color(0xFF1533e8),
        title: Text(
          AppLocalizations.of(context).profile,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            // SizedBox(
            //   height: 115,
            //   width: 115,
            //   child: Stack(
            //     fit: StackFit.expand,
            //     overflow: Overflow.visible,
            //     children: [
            //       CircleAvatar(
            //         backgroundImage: NetworkImage("https://soundforums.net/community/data/avatars/o/14/14453.jpg?1607066553"),
            //       ),
            //       Positioned(
            //         right: -16,
            //         bottom: 0,
            //         child: SizedBox(
            //           height: 46,
            //           width: 46,
            //           child: FlatButton(
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(50),
            //               side: BorderSide(color: Colors.white),
            //             ),
            //             color: Color(0xFFF5F6F9),
            //             onPressed: () {},
            //             child: SvgPicture.asset("images/Camera Icon.svg"),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            SizedBox(height: 20),
            ProfileMenu(
              text: "$username",
              icon: "images/User Icon.svg",
              press: () => {},
            ),
            ProfileMenu(
              text: "$useremail",
              icon: "images/Mail.svg",
              press: () {},
            ),
            // ProfileMenu(
            //   text: "Password",
            //   icon: "images/Lock.svg",
            //   press: () {},
            // ),
            ProfileMenu(
              text: "$phone",
              icon: "images/Phone.svg",
              press: () {},
            ),
            ProfileMenu(
              text: AppLocalizations.of(context).Location,
              icon: "images/Location point.svg",
              press: () {
                _changeBranch();
                // Navigator.pushReplacement(
                // context, MaterialPageRoute(builder: (context) => UserLocation()));
              },
            ),
          ],
        ),
      ),
    );
  }

  _changeBranch() {
    showModalBottomSheet<void>(
        backgroundColor: Colors.white,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0))),
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              height: (100 * BRANCHES.length) + 50.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        InkWell(
                          child: Icon(
                            Icons.add_location_alt_outlined,
                            color: Color(0xFF13446f),
                          ),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => user_location2(
                                          Page: 'profile',
                                        )));
                          },
                        ),
                        // IconButton(icon: Icon(Icons.home,color:Color(0xFF13446f) ,), onPressed: null)
                        Spacer(),
                        Text(
                          AppLocalizations.of(context).Select_Location,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          "",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 5,),
                  // Row(children: [
                  //   InkWell(child: Icon(Icons.home,color:Color(0xFF13446f) ,),),
                  //  // IconButton(icon: Icon(Icons.home,color:Color(0xFF13446f) ,), onPressed: null)
                  //   Spacer(),
                  //   Text(
                  //     "SELECT LOCATION",
                  //     style: TextStyle(
                  //         fontSize: 18.0, fontWeight: FontWeight.w500),
                  //   ),
                  //   Spacer(),
                  //   Text(
                  //     "",
                  //     style: TextStyle(
                  //         fontSize: 18.0, fontWeight: FontWeight.w500),
                  //   ),
                  // ],),
                  // SizedBox(height: 5,),
                  Expanded(
                    child: ListView.builder(
                        itemCount: BRANCHES.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            // onTap: () =>
                            //     _onBranchSelected(_myBranches[index].id),
                            child: Container(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              margin: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                  color: Color(0xFF13446f),
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(color: Colors.grey[200])),
                              child: Row(
                                children: [
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: Colors.white38,
                                      //disabledColor: Colors.blue
                                    ),
                                    child: Radio(
                                        activeColor: Colors.white,
                                        value: BRANCHES[index]['id'],
                                        hoverColor: Colors.white,
                                        groupValue: groub,
                                        onChanged: (T) async {
                                          print(T);
                                          SharedPreferences sharedPrefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          setState(() {
                                            groub = T;
                                            sharedPrefs.setInt("AddressId", T);
                                            // BranchName = BRANCHES[index]['name'];
                                          });
                                          Navigator.of(context).pop();
                                        }),
                                  ),
                                  //Spacer(),
                                  Text(
                                    "${BRANCHES[index]['address']}".length > 40
                                        ? '${"${BRANCHES[index]['address']}".substring(0, 40)}'
                                        : "${BRANCHES[index]['address']}",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                  // Text(
                                  //   '${BRANCHES[index]['address']}',
                                  //   overflow: TextOverflow.ellipsis,
                                  //   maxLines: 2,
                                  //   style: TextStyle(
                                  //     color: Colors.white,
                                  //     fontFamily: 'jana',
                                  //     fontSize: 14,
                                  //   ),
                                  // ),
                                  Spacer(),
                                  InkWell(
                                    child: Icon(
                                      Icons.delete_forever_outlined,
                                      color: Colors.red,
                                    ),
                                    onTap: () {
                                      DeleteAddress(
                                          BRANCHES[index]['id'].toString());
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
          //print(map);
        });
  }

  void getSellerName() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    http.Response response = await http.get(
      'http://wootc.net/api/customer_location/show?email=${sharedPrefs.getString("email")}&access_token=syEt93K5Gsg2Ozdgv8oK22NQLYNzMJtiLHD06JMrpkqF05Kc5VCl9aeWgpcdAB6r',
      headers: {"Accept": "application/json"},
    );
    Map map = json.decode(response.body);
    print(map);
    //BRANCHES.clear();
    if (map['Status'] == true) {
      BRANCHES = map['Customer Locations'];
    }
    for (int x = 0; x < map['Customer Locations'].length; x++) {
      final coordinates = new Coordinates(
          double.parse("${map['Customer Locations'][x]['latitude']}"),
          double.parse("${map['Customer Locations'][x]['longitude']}"));
      var addresses =
          await Geocoder.google("AIzaSyB-zre1gZSbbXHdzyGeWNnjGRbtVFZYbNs")
              .findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
// print number of retured addresses
      debugPrint('${addresses.length}');
// print the best address
      debugPrint("${first.featureName} : ${first.addressLine}");
      setState(() {
        BRANCHES2.add(first.featureName.toString());
        // Address = first.featureName.toString();
      });
    }
  }

  /* getData() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPrefs.getString("name");
      email = sharedPrefs.getString("email");
      phone = sharedPrefs.getString("phone");
      groub = sharedPrefs.getInt("AddressId");
    });

    // username = sharedPrefs.getString("name");
  } */

  _onTap(int tabIndex) {
    switch (tabIndex) {
      case 0:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Deals(),
            ));
        break;
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
              builder: (context) => Cart(),
            ));
        break;
      // _navigatorKey.currentState.pushReplacementNamed("Settings");
      // break;
      case 3:
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => Cart(),
        //     ));
        break;
      case 4:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Settings(),
            ));
        break;
    }
  }

  void DeleteAddress(id) async {
    http.Response response = await http.get(
      'http://wootc.net/api/customer_location/delete/$id',
      headers: {"Accept": "application/json"},
    );
    Map map = json.decode(response.body);
    //BRANCHES.clear();
    if (map['Status'] == true) {
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => profile()));
    }
  }
}
