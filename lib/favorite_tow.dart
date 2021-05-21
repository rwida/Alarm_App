import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:superk_new/Cart.dart';
import 'package:superk_new/Genral.dart';
import 'package:superk_new/NewItems.dart';
import 'package:superk_new/Offers.dart';
import 'package:superk_new/Settings.dart';
import 'package:superk_new/locale/localization.dart';
import 'package:superk_new/product_detail_page.dart';
import 'package:superk_new/profile.dart';

import 'Deals.dart';

class favorite extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return favoriteState();
  }

}

class favoriteState extends State<favorite>{
  List picked = [false, false];
  int totalAmount = 0;
  int tabIndex = 1;
  List data = [];

  pickToggle(index) {
    setState(() {
      picked[index] = !picked[index];
      getTotalAmount();
    });
  }

  getTotalAmount() {
    var count = 0;
    for (int i = 0; i < picked.length; i++) {
      if (picked[i]) {
        count = count + 1;
      }
      if (i == picked.length - 1) {
        setState(() {
          totalAmount = 248 * count;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child:data.isEmpty?Container():(data.contains("no_data"))?
        Container(child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
          Container(margin: EdgeInsets.only(top: 50),child: Center(child: Text(
            AppLocalizations.of(context).favorite,
            style: TextStyle(
              // fontFamily: 'Montserrat',
                 fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),),),
          SizedBox(height: 100,),
          Image.asset("images/found.png"),
        ],),):Stack(children: <Widget>[
        Stack(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
          ),
          Container(
            height: 250.0,
            width: double.infinity,
            color: Color(0xFF03447a),
          ),
          Positioned(
            bottom: 450.0,
            right: 100.0,
            child: Container(
              height: 400.0,
              width: 400.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200.0),
                color: Color(0xFF1e527f),
              ),
            ),
          ),
          Positioned(
            bottom: 500.0,
            left: 150.0,
            child: Container(
              height: 300.0,
              width: 300.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150.0),
                  color: Color(0xFF13446f).withOpacity(0.5)),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(top: 15.0),
          //   child: IconButton(
          //       alignment: Alignment.topLeft,
          //       icon: Icon(Icons.arrow_back),
          //       onPressed: () {}),
          // ),
          Container(margin: EdgeInsets.only(top: 50),child: Center(child: Text(
            AppLocalizations.of(context).favorite,
            style: TextStyle(
              // fontFamily: 'Montserrat',
              fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),),),


          // Padding(
          //   padding: EdgeInsets.only(top: 700.0),
          //   child: Container(
          //     height: 50.0,
          //     width: double.infinity,
          //     color: Colors.white,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: <Widget>[
          //         Text('Total: \$' + totalAmount.toString()),
          //         SizedBox(width: 10.0),
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: RaisedButton(
          //             onPressed: () {},
          //             elevation: 0.5,
          //             color: Colors.red,
          //             child: Center(
          //               child: Text(
          //                 'Pay Now',
          //               ),
          //             ),
          //             textColor: Colors.white,
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ]), Container(child: ListView.builder(
              primary: false,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return itemCard('${data[index]['name']}','${data[index]['name_ar']}', data[index]['id'], '${data[index]['price']}', '${data[index]['pprice']}',
                    '${data[index]['image']}','${data[index]['seller_name']}','${data[index]['seller_name_ar']}','${data[index]['deliv_free']}','${data[index]['deliv_time']}','${data[index]['active']}','${data[index]['specification']}','${data[index]['specification_ar']}','${data[index]['code']}','${data[index]['code_ar']}',);
              }),margin: EdgeInsets.only(top: 70),),
      ]),),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        //selectedItemColor: Color(0xFFf97e9c),
        selectedItemColor: Color(0xFFff8500),// this will be set when a new tab is tapped
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
  Widget itemCard(itemName,itemName_ar,color, price, pprice,imgPath,seller_name,seller_name_ar,deliv_free,deliv_time,active,specification,specification_ar,code,code_ar ) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProductDetailPage(
          id: int.parse(color),
          name: itemName,
          name_ar: itemName_ar,
          img: imgPath,
          code: code,
          code_ar: code_ar,
          from_where: "favorite",
          active: int.parse(active),
          seller_name: seller_name,
          seller_name_ar: seller_name_ar,
          specification: specification,
          specification_ar: specification_ar,
          deliv_free:int.parse(deliv_free) ,
          deliv_time: deliv_time,
          pPrice: price,
          pPromotionPrice: pprice,
        )));
        // if (available) {
        //   pickToggle(i);
        // }
      },
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Material(
          borderRadius: BorderRadius.circular(10.0),
          elevation: 3.0,
          child: Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            width: MediaQuery.of(context).size.width - 20.0,
             height: 100.0,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10),
                  decoration: BoxDecoration(
                   // color: Colors.yellow,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    // image: DecorationImage(
                    //   image: NetworkImage(imgPath),
                    //   fit: BoxFit.cover,
                    // ),
                    //color: Color(0xffe5e6ea),
                  ),
                  // child: Container(
                  //   margin: EdgeInsets.all(8),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  //     image: DecorationImage(
                  //       image: NetworkImage("${Products[i]['photo']}"),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  child: Image.network("$imgPath"),
                  height: MediaQuery.of(context).size.height*0.13,
                  width: MediaQuery.of(context).size.height*0.13,
                ),

                SizedBox(width: 10.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Langs=="ar"?Text(itemName_ar.length > 24 ? '${"${itemName_ar}".substring(0, 24)}':"${itemName_ar}",style: TextStyle(fontSize:  15,color: Colors.black),):
                        Text(itemName.length > 24 ? '${"${itemName}".substring(0, 24)}':"${itemName}",style: TextStyle(fontSize:  15,color: Colors.black),),
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
                    // available
                    //     ? Text(
                    //   'Color: ' + color,
                    //   style: TextStyle(
                    //       fontFamily: 'Quicksand',
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 14.0,
                    //       color: Colors.grey),
                    // )
                    //     : OutlineButton(
                    //   onPressed: () {},
                    //   borderSide: BorderSide(
                    //       color: Colors.red,
                    //       width: 1.0,
                    //       style: BorderStyle.solid),
                    //   child: Center(
                    //     child: Text(
                    //       'Find Similar',
                    //       //maxLines: 2,
                    //       style: TextStyle(
                    //           fontFamily: 'Quicksand',
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 12.0,
                    //           color: Colors.red),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 7.0),
                    Row(children: [
                      Row(children: [
                        Text('${NumberFormat.currency(name: '').format(double.parse(pprice))}',style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,fontWeight: FontWeight.bold),),
                        Text(' '+AppLocalizations.of(context).LE,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),
                      ],),
                      SizedBox(width: 15,),
                      Row(children: [
                        Text("${NumberFormat.currency(name: '').format(double.parse(price))}  "+AppLocalizations.of(context).LE,style: TextStyle(
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
                    //  Text(
                    //   price+'  EGP',
                    //   style: TextStyle(
                    //       fontFamily: 'Montserrat',
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 20.0,
                    //       color: Color(0xFFff8500)),
                    // ),
                    //Container(padding:EdgeInsets.all(8) ,height: MediaQuery.of(context).size.height*0.04,width: MediaQuery.of(context).size.height*0.04,color: Color(0xFFff8500),child: Image.asset('images/cart.png'),)
                    // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    //    Text("wew"),
                    //   // Spacer(),
                    //   //SizedBox(width: MediaQuery.of(context).size.width*0.48,),
                    //
                    // ],),
                  ],
                )
              ],
            ),
          ),
        ),
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
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => favorite(),
      //     ));
           break;
      case 2:
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Offers(SellerId: 3,MainCategroy: 1,CatId: 35,),
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
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Settings(),
            ));
        break;

    }

  }

  void getData() async{
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    if(sharedPrefs.getString("proFav") != null){
      print('nulll nulll nulllnonono');
      setState(() {
        data = json.decode(sharedPrefs.getString("proFav"));
      });
      if(data.isEmpty){
        setState(() {
          data.add("no_data");
        });
      }
    }else{
      print('nulll nulll nulll');
      setState(() {
        data.add("no_data");
      });
    }
  }
}