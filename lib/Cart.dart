import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:superk_new/Deals.dart';
import 'package:superk_new/Genral.dart';
import 'package:superk_new/NewItems.dart';
import 'package:superk_new/favorite_tow.dart';
import 'package:superk_new/profile.dart';
import 'package:superk_new/theme/colors.dart';

import 'Offers.dart';
import 'Settings.dart';
import 'locale/localization.dart';

class Cart extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CartState();
  }

}

class CartState extends State<Cart>{

  double _quantity = 0.0;
  double _quantity2 = 0.0;
  int tabIndex = 3;
  List data = [];
  int SendSuccess = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.grey[200],
      appBar: AppBar(
        // leading:  IconButton(icon: Icon(Icons.arrow_back_sharp,color: Colors.black,),onPressed: (){
        //    Navigator.pushReplacementNamed(context, "products");
        //  },),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          AppLocalizations.of(context).shopping_cart,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: data.isEmpty?Container():(data.contains("no_data"))? Center(child: Image.asset("images/found.png"),):Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                itemBuilder: (ctx, i) {
                  int qty = int.parse(data[i]['qty']);
                  // String str = '';
                  // if (data[i]['price'] != null && data[i]['price'].length > 0) {
                  //   str = data[i]['price'].substring(0, data[i]['price'].length - 1);
                  // }
                  var totalpricepro = num.tryParse(data[i]['price'])?.toDouble() * int.parse(data[i]['qty']);
                  var totalpricepro2 = num.tryParse(data[i]['pprice'])?.toDouble() * int.parse(data[i]['qty']);
                  totalpricepro2 = totalpricepro2 - totalpricepro;
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
                    height: MediaQuery.of(context).size.height / 5,
                    child: Stack(
                      //alignment: Alignment.topLeft,
                      children: <Widget>[

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200],
                                blurRadius: 3.0,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 10,bottom: 10),
                                decoration: BoxDecoration(
                                 // color: Colors.white,
                                 //  borderRadius: BorderRadius.only(
                                 //      topLeft: Radius.circular(10),
                                 //      topRight: Radius.circular(10),
                                 //      bottomLeft: Radius.circular(10),
                                 //      bottomRight: Radius.circular(10)
                                 //  ),
                                 //  image: DecorationImage(
                                 //    image: NetworkImage('${data[i]['image']}'),
                                 //    fit: BoxFit.cover,
                                 //  ),
                                  //color: Color(0xffe5e6ea),
                                ),
                                child: Image.network('${data[i]['image']}'),
                                height: MediaQuery.of(context).size.height*0.13,
                                width: MediaQuery.of(context).size.height*0.13,
                              ),
                              SizedBox(width: 10,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      // Text(
                                      //   Langs=="ar"?data[i]['name_ar']:data[i]['name'],
                                      //   // textAlign: TextAlign.justify,
                                      //   overflow: TextOverflow.ellipsis,
                                      //   style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.018),
                                      //   maxLines: 2,),
                                      Langs=="ar"?Text(data[i]['name_ar'].length > 25 ? '${"${data[i]['name']}".substring(0, 25)}.':"${data[i]['name']}",style: TextStyle(fontSize:  14,color: Colors.black,),overflow: TextOverflow.ellipsis,):Text(data[i]['name'].length > 25 ? '${"${data[i]['name']}".substring(0, 25)}.':"${data[i]['name']}",style: TextStyle(fontSize:  14,color: Colors.black,),overflow: TextOverflow.ellipsis,),

                                      // Text(
                                      //   itemName,
                                      //   style: TextStyle(
                                      //       fontFamily: 'Montserrat',
                                      //       fontWeight: FontWeight.bold,
                                      //       fontSize: 15.0),
                                      // ),
                                      // SizedBox(width: 7.0),
                                      // available
                                      //     ? picked[i]
                                      //     ? Text(
                                      //   'x1',
                                      //   style: TextStyle(
                                      //       fontFamily: 'Montserrat',
                                      //       fontWeight: FontWeight.bold,
                                      //       fontSize: 14.0,
                                      //       color: Colors.grey),
                                      // )
                                      //     : Container()
                                      //     : Container()
                                    ],
                                  ),
                                  // SizedBox(height: 7.0),
                                  // Text(
                                  //   'pieces: ${data[i]['qty']}' ,
                                  //   style: TextStyle(
                                  //       fontFamily: 'Quicksand',
                                  //       fontWeight: FontWeight.bold,
                                  //       fontSize: 14.0,
                                  //       color: Colors.grey),
                                  // ),
                                  SizedBox(height: 7.0),
                                  Row(children: [
                                    Row(children: [
                                      Text('${NumberFormat.currency(name: '').format(double.parse(data[i]['price']))}',style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,fontWeight: FontWeight.bold),),
                                      Text("  "+AppLocalizations.of(context).LE,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),
                                    ],),
                                    SizedBox(width: 15,),
                                    Row(children: [
                                      Text("${NumberFormat.currency(name: '').format(double.parse(data[i]['pprice']))}  "+AppLocalizations.of(context).LE,style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height*0.015,
                                          fontWeight: FontWeight.w500,
                                          //color: warning,
                                          color: Color(0xFFff8500),
                                          decoration: TextDecoration.lineThrough
                                      ),),
                                    ],),
                                    // Text(
                                    //   '${data[i]['price']} EGP',
                                    //   style: TextStyle(
                                    //       fontFamily: 'Montserrat',
                                    //       fontWeight: FontWeight.bold,
                                    //       fontSize: 20.0,
                                    //       color: Color(0xFFff8500)),
                                    // ),
                                    //  SizedBox(width: 20,),
                                    // Text(data[i]['pprice']+" EGP",style: TextStyle(
                                    //     fontSize: 14,
                                    //     fontWeight: FontWeight.w500,
                                    //     //color: warning,
                                    //     color: Colors.grey,
                                    //     decoration: TextDecoration.lineThrough
                                    // ),),
                                  ],),
                                  SizedBox(height: 10.0),
                                  Row(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () async {
                                          SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
                                          if(qty > 1){
                                            setState(() {
                                              qty = --qty;
                                             // var totalp = num.tryParse(data[i]['price'])?.toDouble() * qty;
                                              _quantity = _quantity - num.tryParse(data[i]['price'])?.toDouble();
                                              _quantity2 = _quantity2 - (num.tryParse(data[i]['pprice'])?.toDouble() - num.tryParse(data[i]['price'])?.toDouble());
                                              data[i]['qty'] = "$qty";
                                              sharedPrefs.setString("proIds", json.encode(data));
                                            });
                                          }

                                          // minus here
                                        },
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: primary),
                                              shape: BoxShape.circle
                                          ),
                                          child: Icon(LineIcons.minus,size: 15,),
                                        ),
                                      ),
                                      SizedBox(width: 15,),
                                      Text(qty.toString(),style: TextStyle(
                                          fontSize: 16
                                      ),),
                                      SizedBox(width: 15,),
                                      InkWell(
                                        onTap: () async {
                                          SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
                                          setState(() {
                                            qty = ++qty;
                                            // var totalp = num.tryParse(data[i]['price'])?.toDouble() * qty;
                                            _quantity = _quantity + num.tryParse(data[i]['price'])?.toDouble();
                                            double x = num.tryParse(data[i]['pprice'])?.toDouble() - num.tryParse(data[i]['price'])?.toDouble();
                                            print(x.toString());
                                            print(_quantity2.toString());
                                            _quantity2 = _quantity2 + x ;
                                            data[i]['qty'] = "$qty";
                                            sharedPrefs.setString("proIds", json.encode(data));
                                          });


                                          // minus here
                                        },
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: primary),
                                              shape: BoxShape.circle
                                          ),
                                          child: Icon(LineIcons.plus,size: 15,),
                                        ),
                                      ),

                                    ],
                                  )
                                ],
                              ),

                              // Flexible(
                              //   child: Container(
                              //     alignment: Alignment.bottomRight,
                              //     height: double.infinity,
                              //     child: Padding(
                              //       padding: const EdgeInsets.all(11.0),
                              //       child: Row(
                              //         children: <Widget>[
                              //           // GestureDetector(
                              //           //   child: Icon(Icons.add),
                              //           //   onTap: () {
                              //           //     setState(() {
                              //           //       _quantity += 1;
                              //           //     });
                              //           //   },
                              //           // ),
                              //           // SizedBox(
                              //           //   width: 5.0,
                              //           // ),
                              //           Text("Total : 200"),
                              //           // SizedBox(
                              //           //   width: 5.0,
                              //           // ),
                              //           // GestureDetector(
                              //           //   child: Icon(Icons.remove),
                              //           //   onTap: () {
                              //           //     setState(() {
                              //           //       _quantity -= 1;
                              //           //     });
                              //           //   },
                              //           // ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                        Langs=="ar"?Positioned(
                          top: 17,
                          left: 0,
                          child: GestureDetector(
                            onTap: () async {
                              SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
                              setState(() {
                                data.removeAt(i);
                                sharedPrefs.setString("proIds", json.encode(data));
                                _quantity = _quantity - totalpricepro;
                                _quantity2 = _quantity2 - totalpricepro2;
                              });
                              if(data.isEmpty){
                                setState(() {
                                  data.add("no_data");
                                });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(3.0),
                              color: Color(0xFF13446f),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ):Positioned(
                          top: 17,
                          right: 0,
                          child: GestureDetector(
                            onTap: () async {
                              SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
                              setState(() {
                                data.removeAt(i);
                                sharedPrefs.setString("proIds", json.encode(data));
                                _quantity = _quantity - totalpricepro;
                                _quantity2 = _quantity2 - totalpricepro2;
                              });
                              if(data.isEmpty){
                                setState(() {
                                  data.add("no_data");
                                });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(3.0),
                              color: Color(0xFF13446f),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Langs=="ar"?Positioned(
                          bottom: 17,
                          left: 0,
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            // height: double.infinity,
                            child:Text('${NumberFormat.currency(name: '').format(totalpricepro)}  '+AppLocalizations.of(context).LE,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,fontWeight: FontWeight.bold),),
                          ),
                        ):Positioned(
                          bottom: 17,
                          right: 0,
                          child: Container(
                             alignment: Alignment.bottomLeft,
                            // height: double.infinity,
                            child:Text('${NumberFormat.currency(name: '').format(totalpricepro)}  '+AppLocalizations.of(context).LE,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 9.0,
            ),
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).total_price,
                    style: TextStyle(fontSize: 19, color: Colors.grey),
                  ),
                  Text('${NumberFormat.currency(name: '').format(_quantity)}  '+AppLocalizations.of(context).LE,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,fontWeight: FontWeight.bold),),
                  // Text(
                  //   "$_quantity",
                  //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  // )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).Savings,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Text('${NumberFormat.currency(name: '').format(_quantity2)}  '+AppLocalizations.of(context).LE,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015,fontWeight: FontWeight.bold,color: Color(0xFFff8500)),),

                  // Text(
                  //   "${_quantity2 - _quantity}",
                  //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  // )
                ],
              ),

            ],),
           // Row(mainAxisAlignment: MainAxisAlignment.end,children: [
           //
           // ],),
            FractionallySizedBox(
              widthFactor: 2 / 3,
              child: RaisedButton(
                child: Text(
                  AppLocalizations.of(context).confirm_payment,
                  style: TextStyle(color: Colors.white,fontSize: 16),
                ),
                color: Color(0xFF13446f),
                onPressed: () {
                  ContactMEs();
                 // _onBackPress();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        type: BottomNavigationBarType.fixed,
        //selectedItemColor: Color(0xFFf97e9c),
        selectedItemColor: Color(0xFFff8500),
        onTap: _onTap,// this will be set when a new tab is tapped
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
              title: Text(AppLocalizations.of(context).deals)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text(AppLocalizations.of(context).cart)
          ),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.person),
          //     title: Text('Account')
          // ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(AppLocalizations.of(context).settings)
          ),
        ],
      ),
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
              builder: (context) => Offers(SellerId: 3,MainCategroy: 1,CatId: 35,),
            ));
         break;
    // _navigatorKey.currentState.pushReplacementNamed("Settings");
    // break;
      case 3:
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => profile(),
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

  void getData() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String str = '';
    if(sharedPrefs.getString("proIds") != null){
      print('nulll nulll nulllnonono'+sharedPrefs.getString("proIds"));
      setState(() {
        data = json.decode(sharedPrefs.getString("proIds"));
      });
      for(int i=0 ; i<data.length;i++){
        var totalpricepro2 =num.tryParse(data[i]['pprice'])?.toDouble() * int.parse(data[i]['qty']);
        var totalpricepro =num.tryParse(data[i]['price'])?.toDouble() * int.parse(data[i]['qty']);
        setState(() {
          _quantity = _quantity + totalpricepro;
          _quantity2 = _quantity2 + totalpricepro2;
        });
      }
      setState(() {
        _quantity2 = _quantity2 - _quantity;
      });
      print("555555555555555555 $_quantity2");
      if(data.isEmpty){
        setState(() {
          data.add("no_data");
        });
      }
    }else{
      setState(() {
        data.add("no_data");
      });
      print('nulll nulll nulll');
    }


  }

  Future<bool> _onBackPress() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              content:Container(child:Column(children: [
                Center(child: Image.asset("images/successw.png"),),
                SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                Text("Success !",style: TextStyle(color: Color(0xFFff8500),fontSize: 45)),
                Text("Your Order has been Created",style: TextStyle(color: Color(0xFFff8500),fontSize: 25)),
                Spacer(),
                FractionallySizedBox(
                  widthFactor: 2 / 3,
                  child: RaisedButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Color(0xFF13446f),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Cart(),
                          ));
                      //ContactMEs();

                    },
                  ),
                ),
              ],) ,height: MediaQuery.of(context).size.height*0.60,),
              // actions: <Widget>[
              //
              //   FlatButton(
              //     child: Text("yes",style: TextStyle(color: Color(0xFF1533e8)),),
              //     onPressed: () async {
              //       Navigator.of(context).pop();
              //
              //   }
              //   )
              // ]

          );
        }
    );
  }

  void ContactMEs() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var d ={
      "order": {
        "line_items": [
          for (int i = 0; i < data.length; i++)
            {
              'id': "2565", //(product_id)
              'price':"${data[i]['price']}",
              "name": "${data[i]['name']}",
              "title": "${data[i]['name']}",
              //"product_id": _newproduct[i].shopifyId, //(shopify_product_id)
              "quantity": "${data[i]['qty']}",
              "fulfillment_status": "pending",
              "requires_shipping": true,
              // "variant_id":36877211926693, //(shopify_variant_id)
              // "variant_title": "5 Minutes Bechamel Spices", //color
              "vendor": "${data[i]['seller_name']}",
              //"sku": _newproduct[i].sku,
              "gift_card": false,
              "taxable": true
            }

        ],
        "customer": {
          "email": "${sharedPrefs.getString("email")}",
        },
        "billing_address": {
          "first_name": "${sharedPrefs.getString("name")}",
          "address1": "${sharedPrefs.getString("address")}",
          "phone": "${sharedPrefs.getString("phone")}",
        },
        "shipping_address": {
          "first_name": "${sharedPrefs.getString("name")}",
          "address1": "${sharedPrefs.getString("address")}",
          "phone": "${sharedPrefs.getString("phone")}",
        },
        "phone": "${sharedPrefs.getString("phone")}",
        "email": "${sharedPrefs.getString("email")}",
        "financial_status": "pending",
        "note": "note",
      }
    };
    http.Response response = await http.post('https://7712bd6b62936aac7664b79616da13e2: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@superkshop.myshopify.com/admin/api/2020-10/orders.json',body: json.encode(d),headers: { "Accept":"application/json","Content-Type": "application/json"});
    print(response.body.toString());
    var responsebody = json.decode(response.body);
    if(responsebody['status'] == 200 || response.statusCode == 201){
      _onBackPress();
       setState(() {

         data.clear();
         sharedPrefs.setString("proIds", json.encode(data));
       });
      print("11111111111111111111");
    }else{
      print("222222222222222");

      // return 'error';
    }
  }
}