import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:superk_new/Cart.dart';
import 'package:superk_new/Deals.dart';
import 'package:superk_new/Settings.dart';
import 'package:superk_new/favorite_tow.dart';
import 'package:superk_new/locale/localization.dart';
import 'package:superk_new/product_detail_page.dart';
import 'Genral.dart';
import 'NewItems.dart';

class Offers extends StatefulWidget{
  final int CatId,MainCategroy,SellerId;
  Offers({
    this.CatId,this.MainCategroy,this.SellerId  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OffersState();
  }

}
class OffersState extends State<Offers>{
  int active = 0;
  int tabIndex = 2;
  int load = 0;
  List cc = [];
  List<Note> ListNew = new List();
  List SubCate = [];
  List Products = [];
  List Fav = [];
  List dd = ['Fashion','Electronic','Furniture','Baby','Health','Sport','Gaming','School',];
  List Fashion = ['Fashion','Fashion','Fashion','Fashion','Fashion','Fashion','Fashion','Fashion','Fashion','Fashion','Fashion','Fashion',];
  List Electronic = ['Electronic','Electronic','Electronic','Electronic','Electronic','Electronic','Electronic','Electronic','Electronic','Electronic','Electronic','Electronic',];
  List Furniture = ['Furniture','Furniture','Furniture','Furniture','Furniture','Furniture','Furniture','Furniture','Furniture','Furniture','Furniture','Furniture',];
  List Baby = ['Baby','Baby','Baby','Baby','Baby','Baby','Baby','Baby','Baby','Baby','Baby','Baby',];
  List Health = ['Health','Health','Health','Health','Health','Health','Health','Health','Health','Health','Health','Health',];
  List Sport = ['Sport','Sport','Sport','Sport','Sport','Sport','Sport','Sport','Sport','Sport','Sport','Sport',];
  List Gaming = ['Gaming','Gaming','Gaming','Gaming','Gaming','Gaming','Gaming','Gaming','Gaming','Gaming','Gaming','Gaming',];
  List School = ['School','School','School','School','School','School','School','School','School','School','School','School',];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getSubCategorys();
    getCategorys();
    cc = Fashion;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(actions: [IconButton(icon: Icon(Icons.search,color: Color(0xFFff8500),), onPressed: (){
        showSearch(
            context: context,
            delegate: DataSearch(ListNew));
      })],iconTheme: IconThemeData(
        color: Color(0xFFff8500), //change your color here
      ),centerTitle: true,elevation: 0,title:  Text(AppLocalizations.of(context).deals,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0,),),backgroundColor: Colors.white,),
      body: Container(padding:EdgeInsets.only(bottom: 20),child: Row(children: [
        Container(width: MediaQuery.of(context).size.width*0.25,
          alignment: Alignment.center,
          child: ListView.builder(
            //shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: SubCate.length,
            itemBuilder: (ctx, id) {
              return GestureDetector(
                onTap: () {
                  getProducts(SubCate[id]['id']);
                  setState(() {
                    active = id;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 6,right: 6,top: 2,bottom: 2),
                        width: MediaQuery.of(context).size.width*0.10,
                        height: MediaQuery.of(context).size.width*0.10,
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                        decoration: BoxDecoration(
                          color: Color(0xFFf8f8f8),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)
                          ),
                          image: DecorationImage(
                              image: NetworkImage("${SubCate[id]['photo']}"), fit: BoxFit.cover),
                        ),
                       // child: SubCate[id]['photo'].toString().isEmpty?Icon(Icons.category_outlined,color:active == id ?Color(0xFFff8500):Colors.grey ,):Image.network("${SubCate[id]['photo']}"),
                        //child:  Image.asset("images/${dd[id]}.png"),
                      ),
                      Text(
                        Langs=="ar"?"${SubCate[id]['name_ar']}":"${SubCate[id]['name']}",
                         textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017,color: active == id ?Color(0xFFff8500):Colors.black ),
                        maxLines: 2,),

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
          ),),
        Container(
          width: MediaQuery.of(context).size.width*0.005,
         // width: double.maxFinite,
          color: Color(0xFFf7f8fb),
        ),
        Products.isEmpty?Container():(Products.contains("no_data"))?Container(padding:EdgeInsets.only(left: 20,right: 20),width: MediaQuery.of(context).size.width*0.67,child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
          Image.asset("images/bad.png"),
          SizedBox(height: 20,),
          Text("Opss!",style: TextStyle(fontSize:  MediaQuery.of(context).size.height*0.04,color: Color(0xFF284456)),),
          SizedBox(height: 5,),
          Text("No Products Found",style: TextStyle(color: Color(0xFF284456))),
        ],),),):Container(width: MediaQuery.of(context).size.width*0.73,child:
        Container(child: GridView.builder(
          itemCount: Products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 4,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemBuilder: (ctx, i) {
            double x = -(double.parse(Products[i]["price"].toString())/double.parse(Products[i]["compare_price"].toString()))+1;
            double y = x*100;
            int ch =0;
            int FavIndex;
            for(int x =0;x<Fav.length;x++){
              if(Fav[x]['id'].toString()==Products[i]['id'].toString()){
                ch =1;
                FavIndex = x;
              }
            }
            return InkWell(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailPage(
                id: Products[i]["id"],
                seller_name: '',
                seller_name_ar: '',
                deliv_free: Products[i]["deliv_free"],
                deliv_time: Products[i]["deliv_time"],
                from_where: "Offers",
                name: Products[i]["product_name"],
                name_ar: Products[i]["name_ar"],
                img: Products[i]["photo"],
                code: Products[i]["description"],
                code_ar: Products[i]["description_ar"],
                active: Products[i]["active"],
                specification: Products[i]["specification"],
                specification_ar: Products[i]["specification_ar"],
                pPrice: Products[i]["compare_price"].toString(),
                pPromotionPrice: Products[i]["price"].toString(),
                CatId: widget.CatId,
                MainCategroy: widget.MainCategroy,
                SellerId: widget.SellerId,
              )));
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
                      Langs=="ar"?"${Products[i]['name_ar']}":"${Products[i]['product_name']}",
                      // textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.018),
                      maxLines: 2,),

                    SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                    Row(children: [
                      Text('${NumberFormat.currency(name: '').format(Products[i]['price'])}',style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,fontWeight: FontWeight.bold),),
                      Text(' '+AppLocalizations.of(context).LE,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),),
                    ],),

                    Row(children: [
                      Text("${NumberFormat.currency(name: '').format(Products[i]['compare_price'])}  "+AppLocalizations.of(context).LE,style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height*0.015,
                          fontWeight: FontWeight.w500,
                          //color: warning,
                          color: Color(0xFFff8500),
                          decoration: TextDecoration.lineThrough
                      ),),
                    ],),
                    SizedBox(height:  MediaQuery.of(context).size.height*0.01,),
                    Row(children: [
                      Products[i]['compare_price']==0?Container():Container(
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
                        child: Text('${NumberFormat.currency(name: '',decimalDigits: 0).format(y)}% '+AppLocalizations.of(context).off,style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.013,fontWeight: FontWeight.bold),),
                        //  child:  Text("23% OFF",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.height*0.013),),
                      ),
                      Spacer(),
                      Products[i]['active']==0?Container():Container(
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

              InkWell(onTap: () async {
                SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
                 if(ch == 0){
                   setState(() {
                     Map maps = {"name":"${Products[i]["product_name"]}",
                       "id":"${Products[i]["id"]}",
                       "qty":"1",
                       "price":"${Products[i]["compare_price"]}",
                       "pprice":"${Products[i]["price"]}",
                       "image":"${Products[i]["photo"]}"
                     };
                     Fav.add(maps);

                     sharedPrefs.setString("proFav", json.encode(Fav));
                   });
                 }else{
                   setState(() {
                     Fav.removeAt(FavIndex);
                     sharedPrefs.setString("proFav", json.encode(Fav));
                     print(Fav.toString());
                   });

                 }



                  // }else{
                  //   activeFav = 0;
                  //   Map maps = {"name":"${Products[i]["product_name"]}",
                  //     "id":"${Products[i]["id"]}",
                  //     "qty":"1",
                  //     "price":"${Products[i]["compare_price"]}",
                  //     "pprice":"${Products[i]["price"]}",
                  //     "image":"${Products[i]["photo"]}"
                  //   };
                  //   Fav.removeAt(FavIndex);
                  //   sharedPrefs.setString("proFav", json.encode(Fav));
                  //   print(Fav.toString());
                  // }

              },child: Container(margin: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),height: MediaQuery.of(context).size.height*0.04,width: MediaQuery.of(context).size.height*0.04,child:(ch==1)?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border,color: Colors.grey,),),),


            ],),),);
          },
        ),),),
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
    //_navigatorKey.currentState.pushReplacementNamed("Home");
    //break;
      case 1:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => favorite(),
            ));
        break;
      case 2:
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => Offers(SellerId: 3,MainCategroy: 1,CatId: 35,),
        //     ));
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
    // _navigatorKey.currentState.pushReplacementNamed("Settings");
    // break;
    }

  }
  void getCategorys() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    if(sharedPrefs.getString("proFav") != null) {
      setState(() {
        Fav = json.decode(sharedPrefs.getString("proFav"));
      });

      print(Fav.toString());
    }
    http.Response response = await http.get('http://wootc.net/api/mainCategories?access_token=syEt93K5Gsg2Ozdgv8oK22NQLYNzMJtiLHD06JMrpkqF05Kc5VCl9aeWgpcdAB6r',headers: {"Accept":"application/json"},);
    Map map = json.decode(response.body);
    print(map);
    if(map['Status'] == true){
      setState(() {
        SubCate = map['Main Categories'];
      });
      if(SubCate.isNotEmpty){
        getProducts(SubCate[0]['id']);
      }else{
        setState(() {
          Products.add("no_data");
        });
      }
    }

  }
  void getSubCategorys() async {
    //SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    if(sharedPrefs.getString("proFav") != null) {
      setState(() {
        Fav = json.decode(sharedPrefs.getString("proFav"));
      });

      print(Fav.toString());
    }
    http.Response response = await http.get('http://wootc.net/api/subCategories?access_token=XtOqtttIf4LDLN6yDBXomthsuzAyzj2XWVrxyizaNzyzYsd8puQfQ04RiKDy2nXa',headers: {"Accept":"application/json"},);
    List map = json.decode(response.body);
    // print(widget.CatId.toString());
    print(map);
    SubCate.clear();
    for(int i =0;i<map.length;i++){
      if(map[i]['category_id']==widget.CatId){
        setState(() {
          SubCate.add(map[i]);
        });
      }
    }
    if(SubCate.isNotEmpty){
      getProducts(SubCate[0]['id']);
    }else{
      setState(() {
        Products.add("no_data");
      });
    }

  }
  void getProducts(subId) async {
    print("${widget.CatId}  ${subId}  ${widget.MainCategroy}  ${widget.SellerId}");
    //SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    http.Response response = await http.get('http://wootc.net/api/products?access_token=syEt93K5Gsg2Ozdgv8oK22NQLYNzMJtiLHD06JMrpkqF05Kc5VCl9aeWgpcdAB6r',headers: {"Accept":"application/json"},);
    Map map = json.decode(response.body);
    // print(widget.CatId.toString());
    //print(map);
    Products.clear();
    ListNew.clear();
    for(int i =0;i<map['Products'].length;i++){
      if(map['Products'][i]['main_category_id']==subId && map['Products'][i]['compare_price'] > 0){
        setState(() {
          Products.add(map['Products'][i]);
          Note n = new Note();
          n.id = map['Products'][i]['id'];
          n.name = map['Products'][i]['product_name'];
          n.name_ar = map['Products'][i]['name_ar'];
          n.image = map['Products'][i]['photo'];
          n.specification = map['Products'][i]['specification'];
          n.specification_ar = map['Products'][i]['specification_ar'];
          n.deliv_free = map['Products'][i]['deliv_free'];
          n.deliv_time = map['Products'][i]['deliv_time'];
          n.seller = '';
          n.seller_ar = '';
          n.price = map['Products'][i]['price'].toString();
          n.priceC = map['Products'][i]['compare_price'].toString();
          n.id = map['Products'][i]['id'];
          n.active = map['Products'][i]['active'];
          n.description = map['Products'][i]['description'].toString();
          n.description_ar= map['Products'][i]['description_ar'].toString();
          ListNew.add(n);
        });
      }
    }

    print("$map 8888888888888888888");
    if(Products.isEmpty){
      setState(() {
        Products.add("no_data");
      });
    }

  }


}

class DataSearch extends SearchDelegate<String> {
  DataSearch(this.items);


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
        itemBuilder: (context, index){
          double x = -(double.parse(suggestionList[index].price)/double.parse(suggestionList[index].priceC))+1;
          double y = x*100;
          return GestureDetector(
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
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
                          text:Langs=="ar"? suggestionList[index].name_ar.substring(query.length): suggestionList[index].name.substring(query.length),
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'jana',
                            fontSize: 16,
                          ))
                    ]),
              ),
              subtitle: Row(children: [
                // Icon(
                //   Icons.star,
                //   color: Colors.yellow,
                //   // size: 30,
                // ),
                Text("${NumberFormat.currency(name: '').format(double.parse(suggestionList[index].priceC))}  "+AppLocalizations.of(context).LE,style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.height*0.02,color: Colors.black
                ),),

                SizedBox(width: 10,),
                Text("${NumberFormat.currency(name: '').format(double.parse(suggestionList[index].priceC))}  "+AppLocalizations.of(context).LE,style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height*0.015,
                    fontWeight: FontWeight.w500,
                    //color: warning,
                    color: Color(0xFFff8500),
                    decoration: TextDecoration.lineThrough
                ),),
                 // Text(suggestionList[index].priceC),
              ],),
              trailing: Column(children: [
                Container(
                  //margin: EdgeInsets.only(top: 3,bottom: 3),
                  //width: MediaQuery.of(context).size.width*0.12,
                  // height: MediaQuery.of(context).size.width*0.05,
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.005),
                  decoration: BoxDecoration(
                    color: Color(0xFF13446f),
                    // borderRadius: BorderRadius.only(
                    //     topLeft: Radius.circular(5),
                    //     topRight: Radius.circular(5),
                    //     bottomLeft: Radius.circular(5),
                    //     bottomRight: Radius.circular(5)
                    // ),

                  ),
                  child: Text("${NumberFormat.currency(name: '',decimalDigits: 0).format(y)}% "+AppLocalizations.of(context).off,style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.of(context).size.height*0.013,color: Colors.white
                  ),),
                  // child:  Text("${(-()+1)*100}% OFF",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.height*0.013),),
                ),
                SizedBox(height: 5,),
                suggestionList[index].active==0?Text(""):Container(
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
              Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailPage(
                id: suggestionList[index].id,
                name: suggestionList[index].name,
                img: suggestionList[index].image,
                code: suggestionList[index].description,
                code_ar: suggestionList[index].description_ar,
                specification_ar: suggestionList[index].specification_ar,
                specification: suggestionList[index].specification,
                name_ar: suggestionList[index].name_ar,
                deliv_time: suggestionList[index].deliv_time,
                deliv_free: suggestionList[index].deliv_free,
                seller_name: suggestionList[index].seller,
                seller_name_ar: suggestionList[index].seller_ar,
                active: suggestionList[index].active,
                pPrice: suggestionList[index].priceC,
                from_where: "Offers",
                //CatId: ,
               // MainCategroy: MainCategroy,
                //SellerId: SellerId,
                pPromotionPrice: suggestionList[index].price,
              )));
            },

          );},
          itemCount: suggestionList.length,

          separatorBuilder: (context, index) {
            return Divider();
          }
      ),);
  }

}
class Note {
  int id;
  int active;
  String name;
  String name_ar;
  String image;
  String price;
  String priceC;
  String seller;
  String seller_ar;
  String description;
  String description_ar;
  String specification;
  String specification_ar;
  int deliv_free;
  String deliv_time;
}