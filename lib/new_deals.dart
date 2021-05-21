import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class new_deals extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new_dealsState();
  }

}
class new_dealsState extends State<new_deals>{
  List Products = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(child: Container(child: GridView.builder(
        itemCount: Products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemBuilder: (ctx, i) {
          return InkWell(onTap: (){

          },child: Center(child: Stack(children: [
            Container(
              //margin: EdgeInsets.only(left: 15),
              padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFede8e8),width: 0),
                color: Colors.white,
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(10),
                //     topRight: Radius.circular(10),
                //     bottomLeft: Radius.circular(10),
                //     bottomRight: Radius.circular(10)
                // ),
              ),
              //width: MediaQuery.of(context).size.width*0.36,
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    //margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.04,right: MediaQuery.of(context).size.width*0.04,top: 3,bottom: 3),
                    // width: MediaQuery.of(context).size.width*0.40,
                    // height: MediaQuery.of(context).size.height*0.11,
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   //borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    //   // image: DecorationImage(
                    //   //   image: NetworkImage("https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/92/03832/1.jpg?7566"),
                    //   //   fit: BoxFit.cover,
                    //   // ),
                    // ),
                    child: Image.network("${Products[i]['photo']}",),
                  ),

                  SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                  Text(
                    "Sandisk 16GB Cruzer Blade USB 2.0 Flash Drive",
                    // textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.018),
                    maxLines: 2,),

                  SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                  Row(children: [
                    Text('${NumberFormat.currency(name: '').format(39)}',style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,fontWeight: FontWeight.bold),),
                    Text(' EGP',style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),),
                  ],),

                  Row(children: [
                    Text("${NumberFormat.currency(name: '').format(65)}  EGP",style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height*0.015,
                        fontWeight: FontWeight.w500,
                        //color: warning,
                        color: Color(0xFFff8500),
                        decoration: TextDecoration.lineThrough
                    ),),
                  ],),
                  SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                  Row(children: [
                    Container(
                      //margin: EdgeInsets.only(top: 3,bottom: 3),
                      //width: MediaQuery.of(context).size.width*0.12,
                      // height: MediaQuery.of(context).size.width*0.05,
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                      decoration: BoxDecoration(
                        color: Color(0xFF13446f),
                        // borderRadius: BorderRadius.only(
                        //     topLeft: Radius.circular(5),
                        //     topRight: Radius.circular(5),
                        //     bottomLeft: Radius.circular(5),
                        //     bottomRight: Radius.circular(5)
                        // ),

                      ),
                      child:  Text("23% OFF",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.height*0.013),),
                    ),
                    Spacer(),
                    Container(
                      //margin: EdgeInsets.only(top: 3,bottom: 3),
                      //width: MediaQuery.of(context).size.width*0.12,
                      //height: MediaQuery.of(context).size.width*0.05,
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                      decoration: BoxDecoration(
                        color: Color(0xFFff8500),
                        // borderRadius: BorderRadius.only(
                        //     topLeft: Radius.circular(5),
                        //     topRight: Radius.circular(5),
                        //     bottomLeft: Radius.circular(5),
                        //     bottomRight: Radius.circular(5)
                        // ),

                      ),
                      child:  Text("express",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.height*0.013),),
                    ),
                  ],),
                  //SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                  // Row(children: [
                  //   Text('Nike Product',style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,color: Colors.grey),),
                  // ],),
                  // Row(children: [
                  //   Text('\$67  ',style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.028,fontWeight: FontWeight.bold,color: Color(0xFF284456)),),
                  //   Text(' \$77',style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Color(0xFFf97e9c)),),
                  // ],),

                ],
              ),
            ),

            InkWell(onTap: (){

            },child: Container(margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),height: MediaQuery.of(context).size.height*0.04,width: MediaQuery.of(context).size.height*0.04,child:Icon(Icons.favorite_border,color: Colors.grey,),),),


          ],),),);
        },
      ),),),
    );
  }
  void getProducts() async {
    //SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    http.Response response = await http.get('http://wootc.net/api/products?access_token=XtOqtttIf4LDLN6yDBXomthsuzAyzj2XWVrxyizaNzyzYsd8puQfQ04RiKDy2nXa',headers: {"Accept":"application/json"},);
    List map = json.decode(response.body);
    Products.clear();
    print(map);

setState(() {
  Products = map;
});

  }

}