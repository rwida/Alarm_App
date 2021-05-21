import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;
import 'package:superk_new/Cagtegroy.dart';
import 'package:superk_new/Genral.dart';
import 'package:superk_new/constant/data.dart';
import 'package:superk_new/product_detail_page.dart';
//import 'package:superk_them/Cagtegroy.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'locale/localization.dart';
//import 'items.dart';

class MyHomePage extends StatefulWidget{
  final int CatId;
  MyHomePage({
    this.CatId,
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyHomePageState();
  }

}
class MyHomePageState extends State<MyHomePage>{
 // ScrollController _scrollController = new ScrollController();
  int basket = 3;
  int SellerID = 0;
  int CategroyActive = 0;
  List Sellers = [];
  List AllCate = [];
  List Products = [];
  List proName = [];
  List proImage = [];
  List proPrice = [];
  List proId = [];
  List ProSeller = [];
  List<Note> ListNew = new List();
  final TextEditingController _phone = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategorys();
    //getProducts();
   // print(WidgetsBinding.instance.window.physicalSize.height);
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // TODO: implement build
    return Scaffold(
      floatingActionButton: SpeedDial(
        /// both default to 16
        marginEnd: 18,
        marginBottom: 20,
        // animatedIcon: AnimatedIcons.menu_close,
        // animatedIconTheme: IconThemeData(size: 22.0),
        /// This is ignored if animatedIcon is non null
        icon: Icons.chat_outlined,
        activeIcon: Icons.remove,
        // iconTheme: IconThemeData(color: Colors.grey[50], size: 30),
        /// The label of the main button.
        // label: Text("Open Speed Dial"),
        /// The active label of the main button, Defaults to label if not specified.
        // activeLabel: Text("Close Speed Dial"),
        /// Transition Builder between label and activeLabel, defaults to FadeTransition.
        // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
        /// The below button size defaults to 56 itself, its the FAB size + It also affects relative padding and other elements
        buttonSize: 56.0,
        visible: true,
        /// If true user is forced to close dial manually
        /// by tapping main button and overlay is not rendered.
        closeManually: false,
        /// If true overlay will render no matter what.
        renderOverlay: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Color(0xFF13446f),
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        // orientation: SpeedDialOrientation.Up,
        // childMarginBottom: 2,
        // childMarginTop: 2,
        children: [
          SpeedDialChild(
            child: Icon(Icons.phone,color: Colors.white,),
            backgroundColor: Color(0xFF13446f),
           // label: 'call',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => launchURL('tel:01117933913'),
            //onLongPress: () => print('FIRST CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: SvgPicture.asset("images/speechbubble.svg",color: Colors.white,),
            backgroundColor: Color(0xFF13446f),
            //label: 'Message',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => launchURL('sms:+201117933913'),
            //onLongPress: () => print('SECOND CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: Icon(Icons.chat,color: Colors.white,),
            backgroundColor: Color(0xFF13446f),
          //  label: 'Chat',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => launchURL('https://superk.shop/?chat'),
           // onLongPress: () => print('THIRD CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child:SvgPicture.asset("images/whatsapp.svg",color: Colors.white,),
            backgroundColor: Color(0xFF13446f),
          //  label: 'whats app',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => launchURL('https://api.whatsapp.com/send?phone=+201117933913'),
            //onLongPress: () => print('THIRD CHILD LONG PRESS'),
          ),
        ],
      ),
      body: Container(child: SingleChildScrollView(scrollDirection: Axis.vertical,child:
      Column(children: [
        Container(width:double.infinity,height: MediaQuery.of(context).size.height*0.32,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/pgn.png"), fit: BoxFit.cover)),
          child: Column(children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.02,),
            Container(margin: EdgeInsets.all(MediaQuery.of(context).size.height*0.03,),child: Row(children: [
              InkWell(onTap: (){Navigator.of(context).pop();},child:  Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),),
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
                          child: InkWell(onTap: (){ showSearch(
                              context: context,
                              delegate: DataSearch(SellerID,ListNew));},child: Container(
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

              // Text("    "),
              // (basket == 0)?Icon(Icons.chat_outlined,size: 30,):Badge(padding:EdgeInsets.all(8.0),
              //   badgeContent: Text('$basket',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              //   child:GestureDetector(child:Icon(Icons.chat_outlined,size: 30,color: Colors.white,) ,onTap: (){
              //     // showSearch(
              //     //      context: context,
              //     //      delegate: DataSearch(Products,proName,proId,proImage,proPrice,ProSeller,ListNew));
              //     },),
              // ),
              // Icon(
              //   Icons.notifications,
              //   color: Colors.white,
              // ),
              //Text("    "),

            ],),),
            Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.height*0.03,left: MediaQuery.of(context).size.height*0.03,),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

              Text(AppLocalizations.of(context).near_stores,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),),
              Spacer(),
              //Text("View all",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.025),),
            ],),),
            Sellers.isEmpty?Container(): Row(children: [
              Container(margin: EdgeInsets.all(MediaQuery.of(context).size.height*0.017,),height:MediaQuery.of(context).size.height*0.115,child: ListView.builder(

                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: Sellers.length,
                itemBuilder: (BuildContext context, int index){
                  // String s = Sellers[index]['photo'];
                  // String name = s.replaceAll('assets', 'super_k/assets');
                  return InkWell(onTap: (){
                    //getAllCategorys(Sellers[index]['id']);
                    setState(() {
                      SellerID = Sellers[index]['id'];
                      print(SellerID.toString());
                      //getProducts();
                      CategroyActive = index;
                    });
                  },child: Column(children: [
                    CategroyActive==index? Container(height:MediaQuery.of(context).size.height*0.07,width: MediaQuery.of(context).size.height*0.07,decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFff8500),width:  CategroyActive==index?3:0),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      image: DecorationImage(
                          image: NetworkImage("${Sellers[index]['photo']}"), fit: BoxFit.cover)),): Container(height:MediaQuery.of(context).size.height*0.07,width: MediaQuery.of(context).size.height*0.07,decoration: BoxDecoration(
                       // border: Border.all(color: Color(0xFFff8500),),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        image: DecorationImage(
                            image: NetworkImage("${Sellers[index]['photo']}"), fit: BoxFit.cover)),),
                    Container(height: MediaQuery.of(context).size.height*0.045,width: MediaQuery.of(context).size.height*0.14,child: Center(child:
                    Text(Langs=="ar"?"${Sellers[index]['store_ar']}":"${Sellers[index]['store_name']}",
                      //"${Sellers[index]['seller_name']}",
                      textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),maxLines: 2,),),)
                    //Text("Category",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02))
                  ],),);
                },
              ),),
            ],)

            // Container(margin: EdgeInsets.all(MediaQuery.of(context).size.height*0.02,),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            //   Column(children: [
            //     Container(height:MediaQuery.of(context).size.height*0.07,width: MediaQuery.of(context).size.height*0.07,decoration: BoxDecoration(
            //         image: DecorationImage(
            //             image: AssetImage("images/categor.png"), fit: BoxFit.cover)),),
            //     Text("Product",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02)),
            //     Text("Category",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02))
            //   ],),
            //   Column(children: [
            //     Container(height:MediaQuery.of(context).size.height*0.07,width: MediaQuery.of(context).size.height*0.07,decoration: BoxDecoration(
            //         image: DecorationImage(
            //             image: AssetImage("images/paymen.png"), fit: BoxFit.cover))),
            //     Text("Payment &",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02)),
            //     Text("Service",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02))
            //   ],),
            //
            //   Column(children: [
            //     Container(height:MediaQuery.of(context).size.height*0.07,width: MediaQuery.of(context).size.height*0.07,decoration: BoxDecoration(
            //         image: DecorationImage(
            //             image: AssetImage("images/vouche.png"), fit: BoxFit.cover))),
            //     Text("Voucher &",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),),
            //     Text("Discount",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02))
            //   ],),
            //
            //   Column(children: [
            //     Container(height:MediaQuery.of(context).size.height*0.07,width: MediaQuery.of(context).size.height*0.07,decoration: BoxDecoration(
            //         image: DecorationImage(
            //             image: AssetImage("images/trave.png"), fit: BoxFit.cover))),
            //     Text("Travel &",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02)),
            //     Text("Entertain",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02))
            //   ],),
            //
            //
            //
            // ],),)


          ],),
        ),
        SizedBox(height: 10,),
        AllCate.isEmpty?Container():Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.height*0.03,left: MediaQuery.of(context).size.height*0.03,),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

          Text(AppLocalizations.of(context).all_category,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: MediaQuery.of(context).size.height*0.025),),
          Spacer(),
          //Text("View all",style: TextStyle(color: Color(0xFFbceefa),fontSize: MediaQuery.of(context).size.height*0.025),),
        ],),),
        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
        AllCate.isEmpty?Container():Container(
          height:  MediaQuery.of(context).size.height*0.62,
          child: GridView.builder(
            //controller: _scrollController,
            itemCount: AllCate.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              // String s = Categorys[index]['photo'];
              // String name = s.replaceAll('assets', 'super_k/assets');
              return GestureDetector(
                onTap: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Cagtegroy(CatId:AllCate[index]['id'] ,MainCategroy: widget.CatId,SellerId: SellerID,),
                      ));
                },
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10,right: 10,bottom: 3),
                        width: MediaQuery.of(context).size.width*0.16,
                        height: MediaQuery.of(context).size.width*0.16,
                        // padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03),
                        decoration: BoxDecoration(
                          //border: Border.all(color: Color(0xFFede8e8)),
                          // color: Color(0xFFf8f8f8),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)
                          ),
                          image: DecorationImage(
                              image: NetworkImage("${AllCate[index]['photo']}"), fit: BoxFit.cover),
                        ),

                      ),

                      Text(
                        Langs=="ar"?"${AllCate[index]['category_name_ar']}":"${AllCate[index]['category_name']}",
                        //"${AllCate[index]['category_name']}",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.018),
                        maxLines: 2,),
                      // Text(
                      //   "${AllCate[index]['category_name']}",
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     fontWeight:
                      //     FontWeight.normal,
                      //     color:  Colors.black ,
                      //     fontSize: MediaQuery.of(context).size.height*0.02,
                      //   ),
                      // ),
                      SizedBox(height: 24,),
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
          ),
        ),

        // SizedBox(height: MediaQuery.of(context).size.height*0.01,),
        // Products.isEmpty?Container():Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.height*0.03,left: MediaQuery.of(context).size.height*0.03,),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
        //
        //   Text("Popular Products",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: MediaQuery.of(context).size.height*0.025),),
        //   Spacer(),
        //  // Text("View all",style: TextStyle(color: Color(0xFFbceefa),fontSize: MediaQuery.of(context).size.height*0.025),),
        // ],),),
        // SizedBox(height: 10,),
        // Products.isEmpty?Container():Container(height:AllCate.isEmpty?MediaQuery.of(context).size.height*0.60:MediaQuery.of(context).size.height*0.35,child: ListView.separated(
        //   // controller: _scrollController,
        //   //shrinkWrap: true,
        //   itemCount: Products.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     //final Message chat = chats[index];
        //     return GestureDetector(
        //       child:  ListTile(
        //         leading: Container(
        //           width: 50.0,
        //           height: 50.0,
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.all(Radius.circular(100.0)),
        //             image: DecorationImage(
        //               image: NetworkImage("${Products[index]['photo']}"),
        //               fit: BoxFit.cover,
        //             ),
        //           ),
        //         ),
        //         title: Text("${Products[index]['product_name']}".length > 26 ? '${"${Products[index]['product_name']}".substring(0, 26)}..':"${Products[index]['product_name']}",style: TextStyle(fontSize:  MediaQuery.of(context).size.height*0.025,color: Color(0xFF284456)),),
        //         //title: AutoSizeText('${Products[index]['product_name']}',presetFontSizes: [MediaQuery.of(context).size.height*0.025, MediaQuery.of(context).size.height*0.02, MediaQuery.of(context).size.height*0.015,],style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF284456)),),
        //         subtitle: Row(children: [
        //           // Icon(
        //           //   Icons.star,
        //           //   color: Colors.yellow,
        //           //   // size: 30,
        //           // ),
        //           Text("${Products[index]['description']}",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,))
        //         ],),
        //         trailing: Text("${Products[index]['price']} \$",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,fontWeight: FontWeight.bold,color: Color(0xFF284456))),
        //       ),
        //       onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailPage(
        //         id: Products[index]['id'],
        //         name: Products[index]['product_name'],
        //         img: Products[index]['photo'],
        //         code: Products[index]['description'],
        //         pPrice: Products[index]['compare_price'].toString(),
        //         pPromotionPrice: Products[index]['price'].toString(),
        //       ))),
        //
        //
        //     );
        //   },
        //   separatorBuilder: (context, index) {
        //     return Divider();
        //   },
        // ),),
      ],),
      ),),

    );
  }
  void getCategorys() async {
    //SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    http.Response response = await http.get('http://wootc.net/api/sellers?access_token=syEt93K5Gsg2Ozdgv8oK22NQLYNzMJtiLHD06JMrpkqF05Kc5VCl9aeWgpcdAB6r',headers: {"Accept":"application/json"},);
    Map map = json.decode(response.body);
    print(widget.CatId.toString()+"pppppppppppppppppppppppppppppppppppppppp");
    print(map);
    if(map['Status'] == true){
      for(int i =0;i<map['Sellers'].length;i++){
        if(map['Sellers'][i]['main_category_id']==widget.CatId){
          setState(() {
            Sellers.add(map['Sellers'][i]);
          });
        }
      }
      setState(() {
        SellerID = Sellers[0]['id'];
      });
      getAllCategorys();
    }



  }
  void getAllCategorys() async {
    //SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    http.Response response = await http.get('http://wootc.net/api/categories?access_token=syEt93K5Gsg2Ozdgv8oK22NQLYNzMJtiLHD06JMrpkqF05Kc5VCl9aeWgpcdAB6r',headers: {"Accept":"application/json"},);
    Map map = json.decode(response.body);
   // print(widget.CatId.toString());
    print(map);
    if(map['Status'] == true){
      AllCate.clear();
      for(int i =0;i<map['Categories'].length;i++){
        if(map['Categories'][i]['main_category_id']==widget.CatId){
          setState(() {
            AllCate.add(map['Categories'][i]);
            Note n = new Note();
            n.id = map['Categories'][i]['id'];
            n.name = map['Categories'][i]['category_name'];
            n.name_ar = map['Categories'][i]['category_name_ar'];
            n.image = map['Categories'][i]['photo'];
            n.price = SellerID;
            // n.priceC = map[i]['compare_price'].toString();
            // n.id = map[i]['id'];
            n.description = widget.CatId;
            ListNew.add(n);
          });
        }
      }
    }



  }
  void getProducts() async {
    //SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    http.Response response = await http.get('http://wootc.net/api/products?access_token=syEt93K5Gsg2Ozdgv8oK22NQLYNzMJtiLHD06JMrpkqF05Kc5VCl9aeWgpcdAB6r',headers: {"Accept":"application/json"},);
    List map = json.decode(response.body);
    Products.clear();
    print(map);
    for(int i =0;i<map.length;i++){
      if(map[i]['seller_id'] == SellerID){
        setState(() {
          // Note n = new Note();
          // n.id = map[i]['id'];
          // n.name = map[i]['product_name'];
          // n.image = map[i]['photo'];
          // n.price = map[i]['price'].toString();
          // n.priceC = map[i]['compare_price'].toString();
          // n.id = map[i]['id'];
          // n.description = map[i]['description'].toString();
          Products.add(map[i]);
          proName.add('${map[i]['product_name']}');
          proPrice.add(map[i]['price']);
          proId.add(map[i]['id']);
          proImage.add(map[i]['photo']);
          //String SellerName = '';
         //  print("------------ ${map[i]['seller_id']}");
         //  print("------------ ${getSellername(map[i]['seller_id'])}");
          ProSeller.add(getSellername(map[i]['seller_id']));
          // n.seller = getSellername(map[i]['seller_id']);
          // ListNew.add(n);
        });
      }


    }
    }
    String getSellername(SID){
    String SellerName;
      for(int y = 0;y<Sellers.length;y++){
        if(Sellers[y]['id'] == SID){
          setState(() {
            SellerName = Sellers[y]['seller_name'];
          });
        }
      }
      return SellerName;
    }

  launchURL(String url) async {
    //const url = 'https://api.whatsapp.com/send?phone=+201098664233';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  }

class DataSearch extends SearchDelegate<String> {
  DataSearch(this.sellerID,this.items);
  int sellerID;

  final citic = [
    'شقه في شمال الرياض تبعد عن وادي الحياه بحوالي 650 متر فقط','واد يا محسن','كبيرت يا واد',
    'فيلا في الرياض 2 دور + حمام سباحة + الفيلا تطل على اسفارة الامريكية','any day you','can i work with you','fund day'
  ];
  final citics = ['1000 \$', '40000 \$'];
  final citics2 = ['شقة', 'فيلا'];
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
        : Langs=="ar"?items.where((p) => p.name_ar.toLowerCase().startsWith(query.toLowerCase())).toList(): items.where((p) => p.name.toLowerCase().startsWith(query.toLowerCase())).toList();
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
                    text: Langs=="ar"?suggestionList[index].name_ar.substring(0, query.length):suggestionList[index].name.substring(0, query.length),
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
              //trailing: Text("${suggestionList[index].price} \$",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,fontWeight: FontWeight.bold,color: Color(0xFF284456))),
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
              Navigator.push(context, MaterialPageRoute(builder: (_) => Cagtegroy(
                CatId: suggestionList[index].id,
                MainCategroy: suggestionList[index].description,
                SellerId: sellerID,

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
  int price;
  String priceC;
  String seller;
  int description;
}
