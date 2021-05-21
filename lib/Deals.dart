import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:easy_localization/public.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:http/http.dart' as http;
import 'package:superk_new/Cart.dart';
import 'package:superk_new/Genral.dart';
import 'package:superk_new/MyHomePage.dart';
import 'package:superk_new/Offers.dart';
import 'package:superk_new/favorite_tow.dart';
import 'package:superk_new/product_detail_page.dart';
import 'package:superk_new/product_detail_page_linking.dart';
import 'package:superk_new/profile.dart';
import 'package:superk_new/ui/widgets/Deals.dart';
import 'package:superk_new/ui/widgets/DealsOfTheDay.dart';
import 'package:superk_new/ui/widgets/FeaturedBrand.dart';
import 'package:superk_new/ui/widgets/Offers.dart';
import 'package:superk_new/ui/widgets/OffersInList.dart';
import 'package:superk_new/user_location2.dart';

import 'Settings.dart';
import 'locale/localization.dart';

class Deals extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DealsState();
  }

}
List<Note> ListNew = new List();
int pageIndex = 0;
int tabIndex = 0;

class DealsState extends State<Deals>{
  final TextEditingController _phone = new TextEditingController();
  List ADs = ['images/Capture.PNG','images/ads3.PNG','images/ads2.PNG','images/ads4.PNG'];
  List dd = ['Fashion','Electronic','Furniture','Baby','Health','Sport','Gaming','School',];
  List Categorys = [];
  List Sliders = [];
  List HotDeals = [];
  List BRANCHES = [];
  List BRANCHES2 = [];
  List SuperMarket = [];
  int groub = 0;
  List pharmacy = [];
  String Address = '';
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getSellerName();
    getCategorys();
    initDynamicLinks();
    getSlidrs();
    getHotDeals();


    handleDynamicLinks();
    //ContactMEs();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // var datal = EasyLocalizationProvider.of(context).data;
    // Locale myLocale = Localizations.localeOf(context);
    return
      // EasyLocalizationProvider(
      // data: datal,
      Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:Stack(children: [
        Column(
            children: [
              Container(width:double.infinity,height: MediaQuery.of(context).size.height*0.34,child:Stack(children: [
                Container(width:double.infinity,height: MediaQuery.of(context).size.height*0.25,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/pgn.png"), fit: BoxFit.cover)),
                  child: Column(children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    InkWell(onTap: (){_changeBranch();},child: Padding(padding: EdgeInsets.only(left: 10,right: 10),
                      child: Text(
                        "$Address",
                        // textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.018,color: Colors.white),
                        maxLines: 2,),),),

                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.height*0.03,right: MediaQuery.of(context).size.height*0.03,bottom: MediaQuery.of(context).size.height*0.03),child: Row(children: [
                      // InkWell(child: Icon(
                      //   Icons.arrow_back_outlined,
                      //   color: Colors.white,
                      //   size: 30,
                      // ),onTap: (){
                      //   Navigator.pop(context);
                      // },),
                      Text("    "),
                      Expanded(
                        flex: 6,
                        child: new GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => discover_userRealySearch(),
                            //     ));
                            //print("sads");
                            // showSearch(
                            //     context: context,
                            //     delegate: DataSearch());
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 8,right: 8),
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                Text("    "),

                                Expanded(
                                  flex: 6,
                                  child: InkWell(onTap: (){showSearch(
                                      context: context,
                                      delegate: DataSearch(ListNew));
                                  },child: Container(
                                    // padding: EdgeInsets.all(8),

                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    child: Text(AppLocalizations.of(context).search_any,style: TextStyle(color: Colors.grey),),
                                  ),),

                                ),
                                // Spacer(),
                                // Icon(
                                //   Icons.camera_alt_outlined,
                                //   color: Colors.grey,
                                // ),
                                // Text(
                                //   "إبحث عن كل ما تريده",
                                //   style: TextStyle(
                                //       fontSize: 14,
                                //       color: Colors.grey,
                                //       fontFamily: 'Jana'),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Icon(
                      //   Icons.notifications,
                      //   color: Colors.white,
                      // ),

                      // Text("    "),
                      // InkWell(child: Icon(
                      //   Icons.tune,
                      //   color: Colors.white,
                      //   size: 30,
                      // ),onTap: (){
                      //   // if(myLocale.toString() == "ar_AR"){
                      //   //   datal.changeLocale(locale: Locale('en', 'US'));
                      //   // }else{
                      //   //   datal.changeLocale(locale: Locale('ar', 'AR'));
                      //   // }
                      //   },),
                    ],),),




                  ],),
                ),
               Sliders.isEmpty?Container(): Container(
                    height: MediaQuery.of(context).size.height*0.20,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15),
                    child: CarouselSlider.builder(
                      itemCount: Sliders.length,
                      options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          pageSnapping: true,
                          enableInfiniteScroll: true,
                          //viewportFraction: 1.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              pageIndex = index;
                             // print(index);
                              // _currentKeyword = keywords[_currentPage];
                            });
                          }

                      ),
                      itemBuilder: (context, index, realIdx) {
                        return new InkWell(
                          onTap: (){

                            // _launchURL(ADs[index]['url']);
                          },
                          child:   Image.network("${Sliders[index]['photo']}",),
                        );
                      },
                    )
                ),

              ],) ,),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Sliders.isEmpty?Container():Container(child:  DotsIndicator(
                dotsCount: Sliders.length,
                position: double.parse("$pageIndex"),
                decorator: DotsDecorator(
                  color: Colors.grey[200], // Inactive color
                  activeColor:Color(0xFFff8500),
                ),
              ),),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),

              Container(child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: Categorys.length,
                itemBuilder: (ctx, id) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(CatId: Categorys[id]['id'],),
                          ));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.04),
                      child: Column(
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
                            width: MediaQuery.of(context).size.width*0.12,
                            height: MediaQuery.of(context).size.width*0.12,
                            padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFede8e8)),
                              // color: Color(0xFFf8f8f8),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)
                              ),
                              image: DecorationImage(
                                  image: NetworkImage("${Categorys[id]['photo']}"), fit: BoxFit.cover),
                            ),
                            //child:  Image.network("${Categorys[id]['photo']}"),
                          ),
                          Text(
                            Langs=="ar"?"${Categorys[id]['name_ar']}":"${Categorys[id]['name']}",
                            style: TextStyle(
                              fontWeight:
                              FontWeight.normal,
                              color:  Colors.black ,
                              fontSize: MediaQuery.of(context).size.height*0.015,
                            ),
                          ),
                          SizedBox(height: 20,),
                          // active == id ? Container(
                          //   width: 50,
                          //   height: 3,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(5.0),
                          //       color: Colors.cyan
                          //   ),
                          // ) : Container(),
                        ],
                      ),
                    ),
                  );
                },
              ),height:  MediaQuery.of(context).size.height*0.13,),

              Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.height*0.03,left: MediaQuery.of(context).size.height*0.03,),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Text(AppLocalizations.of(context).hot_deals,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: MediaQuery.of(context).size.height*0.02),),
                Spacer(),
               // Text(AppLocalizations.of(context).shop_now,style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFff8500),fontSize: MediaQuery.of(context).size.height*0.017),),
                //Text("View all",style: TextStyle(color: Color(0xFFbceefa),fontSize: MediaQuery.of(context).size.height*0.02),),
              ],),),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Container(
                height:  MediaQuery.of(context).size.height*0.34,
                margin: EdgeInsets.only(left: 15,right: 15),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: HotDeals.length,
                  itemBuilder: (BuildContext context, int index){
                    double x = -(double.parse(HotDeals[index]["price"].toString())/double.parse(HotDeals[index]["compare_price"].toString()))+1;
                    double y = x*100;
                    return new InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailPage(
                            id: HotDeals[index]["id"],
                            seller_name: '',
                            seller_name_ar: '',
                            deliv_free: HotDeals[index]["deliv_free"],
                            deliv_time: HotDeals[index]["deliv_time"],
                            from_where: "Deals",
                            name: HotDeals[index]["product_name"],
                            name_ar: HotDeals[index]["name_ar"],
                            img: HotDeals[index]["photo"],
                            code: HotDeals[index]["description"],
                            code_ar: HotDeals[index]["description_ar"],
                            active: HotDeals[index]["active"],
                            specification: HotDeals[index]["specification"],
                            specification_ar: HotDeals[index]["specification_ar"],
                            pPrice: HotDeals[index]["compare_price"].toString(),
                            pPromotionPrice: HotDeals[index]["price"].toString(),
                            // CatId: widget.CatId,
                            // MainCategroy: widget.MainCategroy,
                            // SellerId: widget.SellerId,
                          )));
                        },
                        child: Center(child: Stack(children: [
                          Container(
                            //margin: EdgeInsets.only(left: 15),
                            padding:EdgeInsets.only(left: 10,right: 10,top: 10),
                            decoration:BoxDecoration(
                              border:Border.all(color: Color(0xFFede8e8),width: 0),
                              color: Colors.white,
                              // borderRadius: BorderRadius.only(
                              //     topLeft: Radius.circular(10),
                              //     topRight: Radius.circular(10),
                              //     bottomLeft: Radius.circular(10),
                              //     bottomRight: Radius.circular(10)
                              // ),
                            ),
                            width: MediaQuery.of(context).size.width*0.36,
                            child: Column(mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(height:MediaQuery.of(context).size.height*0.15,width:MediaQuery.of(context).size.width*0.40, decoration: BoxDecoration(
                                  //color: Colors.yellow,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)
                                  ),
                                ),
                                  child: Container(
                                    //margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.04,right: MediaQuery.of(context).size.width*0.04,top: 3,bottom: 3),
                                    // width: MediaQuery.of(context).size.width*0.40,
                                    // height: MediaQuery.of(context).size.height*0.11,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      //borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                      // image: DecorationImage(
                                      //   image: NetworkImage("https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/92/03832/1.jpg?7566"),
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    child: Image.network("${HotDeals[index]['photo']}"),
                                  ),
                                ),

                                SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                                Text(
                                  Langs=="ar"?"${HotDeals[index]['name_ar']}":"${HotDeals[index]['product_name']}",
                                 // textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.018),
                                  maxLines: 2,),
                                // Langs=="ar"?Text("${HotDeals[index]['name_ar']}".length > 40 ? '${"${HotDeals[index]['name_ar']}".substring(0,40)}.':"${HotDeals[index]['name_ar']}",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.018),):
                                // Text("${HotDeals[index]['product_name']}".length > 40 ? '${"${HotDeals[index]['product_name']}".substring(0,40)}.':"${HotDeals[index]['product_name']}",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.018),),
                                SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                                Row(children: [
                                  Text('${NumberFormat.currency(name: '').format(double.parse("${HotDeals[index]['price']}"))}',style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,fontWeight: FontWeight.bold),),
                                  Text(' '+AppLocalizations.of(context).LE,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),),
                                ],),

                                Row(children: [
                                  Text("${NumberFormat.currency(name: '').format(double.parse("${HotDeals[index]['compare_price']}"))}  "+AppLocalizations.of(context).LE,style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height*0.015,
                                      fontWeight: FontWeight.w500,
                                      //color: warning,
                                      color: Color(0xFFff8500),
                                      decoration: TextDecoration.lineThrough
                                  ),),
                                ],),
                                SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                                Spacer(),
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
                                    child:  Text('${NumberFormat.currency(name: '',decimalDigits: 0).format(y)}% '+AppLocalizations.of(context).off,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.013,fontWeight: FontWeight.bold),),
                                  ),
                                  Spacer(),
                                  HotDeals[index]['active']==0?Container(): Container(
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
                                    child:  Text(AppLocalizations.of(context).express,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.height*0.013),),
                                  ),
                                ],),
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

                          // InkWell(onTap: (){
                          //
                          // },child: Container(height: MediaQuery.of(context).size.height*0.04,width: MediaQuery.of(context).size.height*0.04,child:Icon(Icons.favorite_border,color: Colors.grey,),),),


                        ],),)
                    );
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              //Fifthlist(),
              //Thirdlist(),
              //Fourthlist(),

              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.height*0.03,left: MediaQuery.of(context).size.height*0.03,),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Text(AppLocalizations.of(context).pharmacy_offers,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: MediaQuery.of(context).size.height*0.02),),
                Spacer(),
               // Text(AppLocalizations.of(context).shop_now,style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFff8500),fontSize: MediaQuery.of(context).size.height*0.017),),
                //Text("View all",style: TextStyle(color: Color(0xFFbceefa),fontSize: MediaQuery.of(context).size.height*0.02),),
              ],),),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Container(
                height:  MediaQuery.of(context).size.height*0.34,
                margin: EdgeInsets.only(left: 15,right: 15),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: pharmacy.length,
                  itemBuilder: (BuildContext context, int index){
                    double x = -(double.parse(pharmacy[index]["price"].toString())/double.parse(pharmacy[index]["compare_price"].toString()))+1;
                    double y = x*100;
                    return new InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailPage(
                            id: pharmacy[index]["id"],
                            seller_name: '',
                            seller_name_ar: '',
                            deliv_free: pharmacy[index]["deliv_free"],
                            deliv_time: pharmacy[index]["deliv_time"],
                            from_where: "Deals",
                            name: pharmacy[index]["product_name"],
                            name_ar: pharmacy[index]["name_ar"],
                            img: pharmacy[index]["photo"],
                            code: pharmacy[index]["description"],
                            code_ar: pharmacy[index]["description_ar"],
                            active: pharmacy[index]["active"],
                            specification: pharmacy[index]["specification"],
                            specification_ar: pharmacy[index]["specification_ar"],
                            pPrice: pharmacy[index]["compare_price"].toString(),
                            pPromotionPrice: pharmacy[index]["price"].toString(),
                            // CatId: widget.CatId,
                            // MainCategroy: widget.MainCategroy,
                            // SellerId: widget.SellerId,
                          )));
                        },
                        child: Center(child: Stack(children: [
                          Container(
                            //margin: EdgeInsets.only(left: 15),
                            padding: EdgeInsets.only(left: 10,right: 10,top: 10),
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
                            width: MediaQuery.of(context).size.width*0.36,
                            child: Column(mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(height:MediaQuery.of(context).size.height*0.15,width:MediaQuery.of(context).size.width*0.40, decoration: BoxDecoration(
                                  //color: Colors.yellow,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)
                                  ),
                                ),
                                  child: Container(
                                    //margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.04,right: MediaQuery.of(context).size.width*0.04,top: 3,bottom: 3),
                                    // width: MediaQuery.of(context).size.width*0.40,
                                    // height: MediaQuery.of(context).size.height*0.11,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      //borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                      // image: DecorationImage(
                                      //   image: NetworkImage("https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/92/03832/1.jpg?7566"),
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    child: Image.network("${pharmacy[index]['photo']}"),
                                  ),
                                ),

                                SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                                Text(
                                  Langs=="ar"?"${pharmacy[index]['name_ar']}":"${pharmacy[index]['product_name']}",
                                  // textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.018),
                                  maxLines: 2,),

                                SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                                Row(children: [
                                  Text('${NumberFormat.currency(name: '').format(double.parse("${pharmacy[index]['price']}"))}',style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,fontWeight: FontWeight.bold),),
                                  Text(' '+AppLocalizations.of(context).LE,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),),
                                ],),

                                Row(children: [
                                  Text("${NumberFormat.currency(name: '').format(double.parse("${pharmacy[index]['compare_price']}"))}  "+AppLocalizations.of(context).LE,style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height*0.015,
                                      fontWeight: FontWeight.w500,
                                      //color: warning,
                                      color: Color(0xFFff8500),
                                      decoration: TextDecoration.lineThrough
                                  ),),
                                ],),
                                SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                                Spacer(),
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
                                    child:  Text('${NumberFormat.currency(name: '',decimalDigits: 0).format(y)}% '+AppLocalizations.of(context).off,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.013,fontWeight: FontWeight.bold),),
                                  ),
                                  Spacer(),
                                  HotDeals[index]['active']==0?Container(): Container(
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
                                    child:  Text(AppLocalizations.of(context).express,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.height*0.013),),
                                  ),
                                ],),
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

                          // InkWell(onTap: (){
                          //
                          // },child: Container(height: MediaQuery.of(context).size.height*0.04,width: MediaQuery.of(context).size.height*0.04,child:Icon(Icons.favorite_border,color: Colors.grey,),),),


                        ],),)
                    );
                  },
                ),
              ),

              //Secondlist(),
              //Sixthlist(),

              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.height*0.03,left: MediaQuery.of(context).size.height*0.03,),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Text(AppLocalizations.of(context).supermarket_offers,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: MediaQuery.of(context).size.height*0.02),),
                Spacer(),
               // Text(AppLocalizations.of(context).shop_now,style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFff8500),fontSize: MediaQuery.of(context).size.height*0.017),),
                //Text("View all",style: TextStyle(color: Color(0xFFbceefa),fontSize: MediaQuery.of(context).size.height*0.02),),
              ],),),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Container(
                height:  MediaQuery.of(context).size.height*0.34,
                margin: EdgeInsets.only(left: 15,right: 15),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: SuperMarket.length,
                  itemBuilder: (BuildContext context, int index){
                    double x = -(double.parse(SuperMarket[index]["price"].toString())/double.parse(SuperMarket[index]["compare_price"].toString()))+1;
                    double y = x*100;
                    return new InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailPage(
                            id: SuperMarket[index]["id"],
                            seller_name: '',
                            seller_name_ar: '',
                            deliv_free: SuperMarket[index]["deliv_free"],
                            deliv_time: SuperMarket[index]["deliv_time"],
                            from_where: "Deals",
                            name: SuperMarket[index]["product_name"],
                            name_ar: SuperMarket[index]["name_ar"],
                            img: SuperMarket[index]["photo"],
                            code: SuperMarket[index]["description"],
                            code_ar: SuperMarket[index]["description_ar"],
                            active: SuperMarket[index]["active"],
                            specification: SuperMarket[index]["specification"],
                            specification_ar: SuperMarket[index]["specification_ar"],
                            pPrice: SuperMarket[index]["compare_price"].toString(),
                            pPromotionPrice: SuperMarket[index]["price"].toString(),
                            // CatId: widget.CatId,
                            // MainCategroy: widget.MainCategroy,
                            // SellerId: widget.SellerId,
                          )));
                        },
                        child: Center(child: Stack(children: [
                          Container(
                            //margin: EdgeInsets.only(left: 15),
                            padding: EdgeInsets.only(left: 10,right: 10,top: 10),
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
                            width: MediaQuery.of(context).size.width*0.36,
                            child: Column(mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(height:MediaQuery.of(context).size.height*0.15,width:MediaQuery.of(context).size.width*0.40, decoration: BoxDecoration(
                                  //color: Colors.yellow,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)
                                  ),
                                ),
                                  child: Container(
                                    //margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.04,right: MediaQuery.of(context).size.width*0.04,top: 3,bottom: 3),
                                    // width: MediaQuery.of(context).size.width*0.40,
                                    // height: MediaQuery.of(context).size.height*0.11,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      //borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                      // image: DecorationImage(
                                      //   image: NetworkImage("https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/92/03832/1.jpg?7566"),
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    child: Image.network("${SuperMarket[index]['photo']}"),
                                  ),
                                ),

                                SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                                Text(
                                  Langs=="ar"?"${SuperMarket[index]['name_ar']}":"${SuperMarket[index]['product_name']}",
                                  // textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.018),
                                  maxLines: 2,),

                                SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                                Row(children: [
                                  Text('${NumberFormat.currency(name: '').format(double.parse("${SuperMarket[index]['price']}"))}',style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,fontWeight: FontWeight.bold),),
                                  Text(' '+AppLocalizations.of(context).LE,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),),
                                ],),

                                Row(children: [
                                  Text("${NumberFormat.currency(name: '').format(double.parse("${SuperMarket[index]['compare_price']}"))}  "+AppLocalizations.of(context).LE,style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height*0.015,
                                      fontWeight: FontWeight.w500,
                                      //color: warning,
                                      color: Color(0xFFff8500),
                                      decoration: TextDecoration.lineThrough
                                  ),),
                                ],),
                                SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                                Spacer(),
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
                                    child:  Text('${NumberFormat.currency(name: '',decimalDigits: 0).format(y)}% '+AppLocalizations.of(context).off,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.013,fontWeight: FontWeight.bold),),
                                  ),
                                  Spacer(),
                                  SuperMarket[index]['active']==0?Container(): Container(
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
                                    child:  Text(AppLocalizations.of(context).express,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.height*0.013),),
                                  ),
                                ],),
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

                          // InkWell(onTap: (){
                          //
                          // },child: Container(height: MediaQuery.of(context).size.height*0.04,width: MediaQuery.of(context).size.height*0.04,child:Icon(Icons.favorite_border,color: Colors.grey,),),),


                        ],),)
                    );
                  },
                ),
              ),

            ]
        ),
        //Container(child: Image.asset("images/Rectangle.png"),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.13,bottom: MediaQuery.of(context).size.height*0.60),),
      ],),),
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
    )
    ;
  }
  //,)


  _onTap(int tabIndex) {
    switch (tabIndex) {
      case 0:
        //_navigatorKey.currentState.pushReplacementNamed("Home");
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
  void getSellerName() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    http.Response response = await http.get('http://wootc.net/api/customer_location/show?email=${sharedPrefs.getString("email")}&access_token=syEt93K5Gsg2Ozdgv8oK22NQLYNzMJtiLHD06JMrpkqF05Kc5VCl9aeWgpcdAB6r',headers: {"Accept":"application/json"},);
    Map map = json.decode(response.body);
    print(map);
    //BRANCHES.clear();
    if(map['Status'] == true){
      BRANCHES =map['Customer Locations'];

    }
    for(int n=0 ; n <BRANCHES.length ; n++){
      print("${sharedPrefs.getInt("AddressId")} oooooooooooooooooooooooooooooooooooooooo");
      print("${BRANCHES[n]['id']} 55555555555555555555555555555555555555");
      if(BRANCHES[n]['id'] == sharedPrefs.getInt("AddressId")){
        setState(() {
          Address = BRANCHES[n]['address'];
          print("${BRANCHES[n]['id']}");
        });
      }
    }
    for(int x = 0;x<map['Customer Locations'].length;x++){
      final coordinates = new Coordinates(double.parse("${map['Customer Locations'][x]['latitude']}"), double.parse("${map['Customer Locations'][x]['longitude']}"));
      if(BRANCHES[x]['id'] == sharedPrefs.getInt("AddressId")){
        setState(() {
         // Address = BRANCHES[x]['name'];
          print("${BRANCHES[x]['id']}");
        });
      }
      var addresses =
      await Geocoder.google("AIzaSyB-zre1gZSbbXHdzyGeWNnjGRbtVFZYbNs").findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
// print number of retured addresses
      debugPrint('${addresses.length}');
// print the best address
      debugPrint("${first.featureName} : ${first.addressLine}");
      setState(() {
        BRANCHES2.add(first.featureName.toString());
        groub == sharedPrefs.getInt("AddressId");
        // Address = first.featureName.toString();
      });

    }

  }
  void getSlidrs() async {
    http.Response response = await http.get(
      'http://wootc.net/api/sliders?access_token=syEt93K5Gsg2Ozdgv8oK22NQLYNzMJtiLHD06JMrpkqF05Kc5VCl9aeWgpcdAB6r',
      headers: {"Accept": "application/json"},);
    Map map = json.decode(response.body);
    print(map);
    if (map['Status'] == true) {
      setState(() {
        Sliders = map['Sliders'];
      });
      // ListNew.clear();
      // for (int i = 0; i < map.length; i++) {
      //   setState(() {
      //
      //   });
      // }
    }
  }

  void getHotDeals() async {
    http.Response response = await http.get(
      'http://wootc.net/api/products?access_token=syEt93K5Gsg2Ozdgv8oK22NQLYNzMJtiLHD06JMrpkqF05Kc5VCl9aeWgpcdAB6r',
      headers: {"Accept": "application/json"},);
    Map map = json.decode(response.body);
    print(map);
    if (map['Status'] == true) {
      HotDeals.clear();
      for (int i = 0; i < map['Products'].length; i++) {
        if(map['Products'][i]['compare_price'] > 0){
          setState(() {
            HotDeals.add(map['Products'][i]);
          });
          if(map['Products'][i]['compare_price'] > 0){
            setState(() {
              HotDeals.add(map['Products'][i]);
            });
          }
          if(map['Products'][i]['compare_price'] > 0 && map['Products'][i]['main_category_id'] == 2){
            setState(() {
              pharmacy.add(map['Products'][i]);
            });
          }
          if(map['Products'][i]['compare_price'] > 0 && map['Products'][i]['main_category_id'] == 1){
            setState(() {
              SuperMarket.add(map['Products'][i]);
            });
          }
        }

      }
    }
  }

  void getCategorys() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    http.Response response = await http.get('http://wootc.net/api/mainCategories?access_token=syEt93K5Gsg2Ozdgv8oK22NQLYNzMJtiLHD06JMrpkqF05Kc5VCl9aeWgpcdAB6r',headers: {"Accept":"application/json"},);
    Map map = json.decode(response.body);
    print(map);
    if(map['Status'] == true){
      setState(() {
        groub= sharedPrefs.getInt("AddressId");
        Categorys = map['Main Categories'];
        print("${sharedPrefs.getInt("AddressId")} oooooooooooooooooooooooooooooooooooooooo");
      });

      ListNew.clear();
      for(int i =0;i<map['Main Categories'].length;i++){
        setState(() {
          Note n = new Note();
          n.id = map['Main Categories'][i]['id'];
          n.name = map['Main Categories'][i]['name'];
          n.image = map['Main Categories'][i]['photo'];
          n.name_ar = map['Main Categories'][i]['name_ar'];
          ListNew.add(n);
        });
      }

    }
    final coordinates = new Coordinates(double.parse("$Lat"), double.parse("$Long"));
    // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // var first = addresses.first;
    // print("nnnnnnnnnnnnnnnnnnnn ${first.featureName} : ${first.addressLine}");
       print("@@@@@@@@@@@@@@@@@@@@@@@ $Lat $Long");
   // final coordinates = new Coordinates(position.latitude, position.longitude);
    debugPrint('coordinates is: $coordinates');

    var addresses =
    await Geocoder.google("AIzaSyB-zre1gZSbbXHdzyGeWNnjGRbtVFZYbNs").findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
// print number of retured addresses
    debugPrint('${addresses.length}');
// print the best address
    debugPrint("${first.featureName} : ${first.addressLine}");
    setState(() {
    //  Address = first.featureName.toString();
    });
//print other address names
    debugPrint("Country:${first.countryName} AdminArea:${first.adminArea} SubAdminArea:${first.subAdminArea}");
//print more address names
    debugPrint("Locality:${first.locality}: Sublocality:${first.subLocality}");
  }
  void sendCategorys() async {
    //SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    http.Response response = await http.post('https://7712bd6b62936aac7664b79616da13e2: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@superkshop.myshopify.com/admin/api/2020-10/orders.json',headers: {"Accept":"application/json","Content-Type": "application/json"},);
    List map = json.decode(response.body);
    print(map);
    setState(() {
      Categorys = map;
    });
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
                            context, MaterialPageRoute(builder: (context) => user_location2(Page: 'Deals',)));
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
                                          Address = BRANCHES[index]['address'];
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
  void DeleteAddress(id) async {
    http.Response response = await http.get('http://wootc.net/api/customer_location/delete/$id',headers: {"Accept":"application/json"},);
    Map map = json.decode(response.body);
    //BRANCHES.clear();
    if(map['Status'] == true){
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Deals()));
    }
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

    final Uri deeplink = data.link;
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
            if(queryParams.length > 0) {
              String userName = queryParams["username"];
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage_linking(id:int.parse(userName),),
                  ));
              // verify the username is parsed correctly
              print("My users username is: $userName");
            }else{
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
        },
        onError: (OnLinkErrorException e) async {
          print('onLinkError');
          print(e.message);
        }
    );

    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      final queryParams = deepLink.queryParameters;
      if(queryParams.length > 0) {
        String userName = queryParams['username'];
        // verify the username is parsed correctly
        print("My users username is: $userName");
      }else{
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

  Future<Uri> createDynamicLink({@required String userName}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      // This should match firebase but without the username query param
      uriPrefix: 'https://superk.page.link',
      // This can be whatever you want for the uri, https://yourapp.com/groupinvite?username=$userName
      link: Uri.parse('https://superk.shop/?username=$userName'),
      androidParameters: AndroidParameters(
        packageName: 'com.gorgov.superk',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.gorgov.superk',
        minimumVersion: '1',
        appStoreId: '',
      ),
    );
    final link = await parameters.buildUrl();
    final ShortDynamicLink shortenedLink = await DynamicLinkParameters.shortenUrl(
      link,
      DynamicLinkParametersOptions(shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
    );
    return shortenedLink.shortUrl;
  }

}

class DataSearch extends SearchDelegate<String> {
  DataSearch(this.items);
  // List vals,proName,proId,proImage,proPrice,ProSeller;

  Color color1 =  Color(0xFF1533e8);
  List<Note> items = new List();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
            //print(l);
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
//    vendor="unV";
//    vendorID=l[index]['id'].toString();
//    Navigator.pushNamed(context, "Vendor");
    print("ali");
    return Container(
      child: Center(
        child: Text(
          query,
          style: TextStyle(color: Colors.green),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //print(proName.toString());
    final suggestionList = query.isEmpty
        ? items
        :Langs=="ar"?items.where((p) => p.name_ar.toLowerCase().startsWith(query.toLowerCase())).toList(): items.where((p) => p.name.toLowerCase().startsWith(query.toLowerCase())).toList();
    return  Container(color: Colors.white,child: ListView.separated(
          itemBuilder: (context, index) => GestureDetector(
            child:  ListTile(
              leading: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  image: DecorationImage(
                    image: NetworkImage("${suggestionList[index].image}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //title: Text("${citic[index]}".length > 26 ? '${"${citic[index]}".substring(0, 26)}..':"${citic[index]}",style: TextStyle(fontSize:  MediaQuery.of(context).size.height*0.025,color: Color(0xFF284456)),),
              title: RichText(
                text: TextSpan(
                    text:Langs=="ar"?suggestionList[index].name_ar.substring(0, query.length):suggestionList[index].name.substring(0, query.length),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'jana',
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                          text:Langs=="ar"?suggestionList[index].name_ar.substring(query.length): suggestionList[index].name.substring(query.length),
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'jana',
                            fontSize: 16,
                          ))
                    ]),
              ),
              // subtitle: Row(children: [
              //   // Icon(
              //   //   Icons.star,
              //   //   color: Colors.yellow,
              //   //   // size: 30,
              //   // ),
              //   Text("${suggestionList[index].seller}",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,))
              // ],),
              // trailing: Text("${suggestionList[index].price} \$",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,fontWeight: FontWeight.bold,color: Color(0xFF284456))),
            ),
            // onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailPage(
            //   id: vals[index]['id'],
            //   name: vals[index]['product_name'],
            //   img: vals[index]['photo'],
            //   code: vals[index]['description'],
            //   pPrice: vals[index]['compare_price'].toString(),
            //   pPromotionPrice: vals[index]['price'].toString(),
            // ))),
            onTap: (){
              print("Sadsds");
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage(
                CatId: suggestionList[index].id,
              )));
            },

          ),
          itemCount: suggestionList.length,

          separatorBuilder: (context, index) {
            return Divider();
          }
      ),
    );
  }

}

class Note {
  int id;
  String name;
  String name_ar;
  String image;
  String price;
  String priceC;
  String seller;
  String description;
}