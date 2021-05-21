import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:http/http.dart' as http;
import 'package:rating_dialog/rating_dialog.dart';
import 'package:share/share.dart';
import 'package:superk_new/Cart.dart';
import 'package:superk_new/Deals.dart';
import 'package:superk_new/Genral.dart';
import 'package:superk_new/Offers.dart';
import 'package:superk_new/constant/data.dart';
import 'package:superk_new/favorite_tow.dart';
import 'package:superk_new/locale/localization.dart';
import 'package:superk_new/proDetails.dart';
import 'package:superk_new/theme/colors.dart';
import 'package:line_icons/line_icons.dart';

import 'Cagtegroy.dart';

class ProductDetailPage extends StatefulWidget {
  final int id;
  final String seller_name;
  final String seller_name_ar;
  final String name;
  final String name_ar;
  final String img;
  final String code;
  final String code_ar;
  final String specification;
  final String specification_ar;
  final String pPrice;
  final int active;
  final String deliv_time;
  final int deliv_free;
  final String from_where;
  final String pPromotionPrice;
  final int CatId,MainCategroy,SellerId;
  ProductDetailPage(
      {this.id,this.seller_name,this.seller_name_ar,
      this.name, this.name_ar,
      this.img,
      this.from_where,
      this.code,this.code_ar,
      this.specification,this.specification_ar,
      this.pPrice,
      this.active,
      this.deliv_time,
      this.deliv_free,
      this.CatId,this.MainCategroy,this.SellerId,
      this.pPromotionPrice});
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> with SingleTickerProviderStateMixin{
  List ADs = ['https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/70/689212/1.jpg?5084','https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/70/689212/2.jpg?5085','https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/70/689212/6.jpg?5089','https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/70/689212/5.jpg?5088','https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/70/689212/4.jpg?5087','https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/70/689212/3.jpg?5086'];
  List ADs2 = ['https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/90/689212/1.jpg?5150','https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/90/689212/2.jpg?5151','https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/90/689212/3.jpg?5152','https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/90/689212/2.jpg?5151','https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/90/689212/3.jpg?5152','https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/90/689212/4.jpg?5153'];
  List ADs3 = ['https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/01/689212/1.jpg?5415','https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/01/689212/2.jpg?5417','https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/01/689212/3.jpg?5418','https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/01/689212/4.jpg?5419','https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/01/689212/5.jpg?5420','https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/01/689212/6.jpg?5421'];
  List work = [];
  int pageIndex = 0;

  int tabIndex = 0;
  String im = '';
  List<Tab> _tabs;
  List<Widget> _pages;
  static TabController _controller;
  int qty = 1;
  int checkRepet = 0;
  int activeFav = 0;
  List Fav = [];
  List ADs5 = ['BLACK','BLUE','RED'];
  List ADs4 = ['https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/70/689212/1.jpg?5084','https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/90/689212/1.jpg?5150','https://eg.jumia.is/unsafe/fit-in/680x680/filters:fill(white)/product/01/689212/1.jpg?5415'];
  List proIds = [];
  bool Login ;
  List reviews = [];
  String SellerName = '';
  int FavIndex = 0;
  int CategroyActive = 0;
  double y;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    double x = -(double.parse(widget.pPromotionPrice)/double.parse(widget.pPrice))+1;
     y = x*100;
     im = widget.img;
    checkFav();
    getSellerName ();
    work = ADs;
    _pages = [new ProductDesc(text: Langs=="ar"?widget.code_ar:widget.code,), new Specification(text: Langs=="ar"?[widget.specification_ar]:[widget.specification],), new UserReview(text: reviews,login: Login,id: widget.id,)];
    _controller = new TabController(
      length: 3,
      vsync: this,
    );
  }

  var _appbar = new Align(
    heightFactor: 0.35,
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: new IconButton(
              icon: new Icon(
                CustomIcons.menu,
                color: Colors.black87,
              ),
              onPressed: () {
                print("menu Clicked");
              },
              splashColor: Colors.black,
            )),
        new Expanded(
          child: new Container(),
        ),
        new Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: new Icon(
            Icons.shopping_cart,
            color: Colors.black87,
          ),
        )
      ],
    ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF13446f),title: Image.asset("images/logo.png",width: 150,height: 80,),leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
       if(widget.from_where == "favorite"){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => favorite(
         )));
       }else if(widget.from_where == "Cagtegroy"){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Cagtegroy(SellerId: widget.SellerId,MainCategroy: widget.MainCategroy,CatId: widget.CatId,
         )));
       }else if(widget.from_where == "Offers"){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Offers(
         )));
       }else if(widget.from_where == "Deals"){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Deals(
         )));
       }

      }),),
      body: getBody(),
    );
  }

  Widget getBody() {
    return SafeArea(

    child:

      Stack(children: [
          SingleChildScrollView(
          physics: ScrollPhysics(),
      controller: _scrollController,
      //scrollDirection: Axis.vertical,

      child:Container(padding: EdgeInsets.all(8),color: Colors.white,child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //SizedBox(height: 10,),
          // Text(
          //   widget.name,
          //   // textAlign: TextAlign.justify,
          //   overflow: TextOverflow.ellipsis,
          //   style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022),
          //   maxLines: 2,),
          // Row(children: [
          //   // Text(
          //   //   widget.name,
          //   //   // textAlign: TextAlign.justify,
          //   //   overflow: TextOverflow.ellipsis,
          //   //   style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022),
          //   //   maxLines: 2,),
          //   Text(widget.name.length > 37 ? '${"${widget.name}".substring(0, 37)}':"${widget.name}",style: TextStyle(fontSize:  MediaQuery.of(context).size.height*0.022,color: Colors.black),)
          // ],),

          Text(
            Langs=="ar"?widget.name_ar:widget.name,
            // textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            //textAlign: TextAlign.right,
            style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022),
            maxLines: 3,),
          // Container(color: Colors.white,child: Row(children: [
          //   // Text(
          //   //   widget.name,
          //   //   // textAlign: TextAlign.justify,
          //   //   overflow: TextOverflow.ellipsis,
          //   //   style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022),
          //   //   maxLines: 2,),
          //   Text(widget.name.length > 37 ? '${"${widget.name}".substring(0, 37)}':"${widget.name}",style: TextStyle(fontSize:  MediaQuery.of(context).size.height*0.022,color: Colors.black),)
          // ],),padding: EdgeInsets.only(left: 12,right: 12,top: 12),),
          Container(color: Colors.white,padding: EdgeInsets.only(left: 12,right: 12,top: 12),child: Row(children: [
            widget.seller_name.isEmpty?Text(""): Text(AppLocalizations.of(context).Sold_by+" ",style: TextStyle()),
            Text(Langs=="ar"?widget.seller_name_ar:widget.seller_name,style: TextStyle(color: Color(0xFFff8500)),),
          ],),),

          Stack(children: [
            // Container(
            //     color: Colors.white,
            //     height: MediaQuery.of(context).size.height*0.30,
            //     width: MediaQuery.of(context).size.width,
            //     // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.14),
            //     child: CarouselSlider.builder(
            //       itemCount: work.length,
            //       options: CarouselOptions(
            //         //autoPlay: true,
            //           aspectRatio: 2.0,
            //           enlargeCenterPage: true,
            //           pageSnapping: true,
            //           //enableInfiniteScroll: true,
            //           viewportFraction: 1.0,
            //           onPageChanged: (index, reason) {
            //             setState(() {
            //               pageIndex = index;
            //               print(index);
            //               // _currentKeyword = keywords[_currentPage];
            //             });
            //           }
            //
            //       ),
            //       itemBuilder: (context, index, realIdx) {
            //         return new InkWell(
            //           onTap: (){
            //
            //             // _launchURL(ADs[index]['url']);
            //           },
            //           child: Container(
            //             padding: EdgeInsets.all(15),
            //             //padding: EdgeInsets.all(20),
            //             //margin: EdgeInsets.only(left: 10),
            //             decoration: new BoxDecoration(
            //               // borderRadius: BorderRadius.only(
            //               //     topLeft: Radius.circular(8),
            //               //     topRight: Radius.circular(8),
            //               //     bottomLeft: Radius.circular(8),
            //               //     bottomRight: Radius.circular(8)
            //               // ),
            //               // color: Colors.black,
            //               // image: new DecorationImage(
            //               //   fit: BoxFit.cover,
            //               //   //colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
            //               //   image: new NetworkImage(
            //               //     "${ADs[index]}",
            //               //   ),
            //               //
            //               // ),
            //             ),
            //             width: MediaQuery.of(context).size.width,
            //             child: Image.network(work[index],),
            //           ),
            //         );
            //       },
            //     )
            // ),
            Container(child:Center(child: Image.network("${widget.img}"),)),
            Column(children: [
              InkWell(
                onTap: () async {
                  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
                  setState(() {
                    if(activeFav==0){
                      activeFav = 1;
                      setState(() {
                        FavIndex = Fav.length;
                      });
                      Map maps = {"name":"${widget.name}",
                        "name_ar":"${widget.name_ar}",
                        "id":"${widget.id}",
                        "qty":"$qty",
                        "seller_name":"${widget.seller_name}",
                        "seller_name_ar":"${widget.seller_name_ar}",
                        "deliv_free":"${widget.deliv_free}",
                        "deliv_time":"${widget.deliv_time}",
                        "active":"${widget.active}",
                        "specification":"${widget.specification}",
                        "specification_ar":"${widget.specification_ar}",
                        "code":"${widget.code}",
                        "code_ar":"${widget.code_ar}",
                        "pprice":"${widget.pPromotionPrice}",
                        "price":"${widget.pPrice}",
                        "image":"${widget.img}"
                      };
                      Fav.add(maps);
                      sharedPrefs.setString("proFav", json.encode(Fav));
                    }else{
                      activeFav = 0;
                      Map maps = {"name":"${widget.name}",
                        "name_ar":"${widget.name_ar}",
                        "id":"${widget.id}",
                        "qty":"$qty",
                        "seller_name":"${widget.seller_name}",
                        "seller_name_ar":"${widget.seller_name_ar}",
                        "deliv_free":"${widget.deliv_free}",
                        "deliv_time":"${widget.deliv_time}",
                        "active":"${widget.active}",
                        "specification":"${widget.specification}",
                        "specification_ar":"${widget.specification_ar}",
                        "code":"${widget.code}",
                        "code_ar":"${widget.code_ar}",
                        "pprice":"${widget.pPromotionPrice}",
                        "price":"${widget.pPrice}",
                        "image":"${widget.img}"
                      };
                      Fav.removeAt(FavIndex);
                      sharedPrefs.setString("proFav", json.encode(Fav));
                      print(Fav.toString());
                    }
                  });

                  // if(sharedPrefs.getString("proFav") != null){
                  //   setState(() {
                  //     proIds = json.decode(sharedPrefs.getString("proIds"));
                  //
                  //   });
                  //   for(int i =0;i<proIds.length;i++){
                  //     print(proIds[i]['id']);
                  //     if(proIds[i]['id'] == "${widget.id}"){
                  //
                  //       setState(() {
                  //         checkRepet = 1;
                  //       });
                  //     }
                  //   }
                  // }
                  //
                  // if(checkRepet == 0){
                  //   proFav.add(maps);
                  //
                  //   sharedPrefs.setString("proFav", json.encode(proIds));
                  //
                  // }
                },
                child:   Container(
                  margin: EdgeInsets.only(left: 10,right: 20,top:20,bottom: 3),
                  width: MediaQuery.of(context).size.height*0.05,
                  height: MediaQuery.of(context).size.height*0.05,
                  decoration: BoxDecoration(
                    color: activeFav==0?Colors.grey[200]:Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),

                  ),
                  child:  Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.height*0.03,
                  ),
                ),
              ),
              //Spacer(),
              InkWell(
                onTap: () async {
                  var xx = await createDynamicLink(userName: "${widget.id}");
                  print("$xx");
                  Share.share('$xx', subject: 'Superk');

                },
                child:Container(
                  margin: EdgeInsets.only(left: 10,right: 20,top:10,bottom: 3),
                  width: MediaQuery.of(context).size.height*0.05,
                  height: MediaQuery.of(context).size.height*0.05,
                  decoration: BoxDecoration(
                    color: Color(0xFFff8500),
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),

                  ),
                  child:  Icon(
                    Icons.share,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.height*0.03,
                  ),
                ),
              ),
            ],),
          ],),
          // Container(color: Colors.white,child:  DotsIndicator(
          //   dotsCount: work.length,
          //   position: double.parse("$pageIndex"),
          //   decorator: DotsDecorator(
          //     color:  Colors.grey[200], // Inactive color
          //     activeColor: Color(0xFFff8500),
          //   ),
          // ),width: double.infinity,),
          Container(color: Colors.white,child: Row(children: [
            Text('${NumberFormat.currency(name: '').format(double.parse(widget.pPromotionPrice))}  '+AppLocalizations.of(context).LE,style: TextStyle(fontSize:  MediaQuery.of(context).size.height*0.03,color: Colors.black,fontWeight: FontWeight.bold),),

//            Text("${widget.pPromotionPrice}  EGP",style: TextStyle(fontSize:  MediaQuery.of(context).size.height*0.03,color: Colors.black,fontWeight: FontWeight.bold),)
          ],),padding: EdgeInsets.only(left: 12,right: 12,top: 12),),
          Container(child: Row(children: [
            // Text(widget.pPrice+"  EGP",style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.w500,
            //     //color: warning,
            //     color: Color(0xFFff8500),
            //     decoration: TextDecoration.lineThrough
            // ),),
            Text("${NumberFormat.currency(name: '').format(double.parse(widget.pPrice))}  "+AppLocalizations.of(context).LE,style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                //color: warning,
                color: Color(0xFFff8500),
                decoration: TextDecoration.lineThrough
            ),),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
              //width: MediaQuery.of(context).size.width*0.12,
              //height: MediaQuery.of(context).size.width*0.10,
              padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
              decoration: BoxDecoration(
                color: Color(0xFF13446f),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5)
                ),

              ),
              child:Text('${NumberFormat.currency(name: '',decimalDigits: 0).format(y)}%  '+AppLocalizations.of(context).off,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            ),
          ],),padding: EdgeInsets.only(right: 12,left: 12,bottom: 12,),color: Colors.white,),

          Container(child: Row(children: [
            Text(AppLocalizations.of(context).order_in+widget.deliv_time,style: TextStyle(
                fontSize: 14,color: Colors.grey,
            ),),
            Spacer(),
            (widget.deliv_free ==0)?Container():Text(AppLocalizations.of(context).Free_delivery,style: TextStyle(
                fontSize: 14,color: Color(0xFF13446f),
            ),),
          ],),padding: EdgeInsets.only(right: 12,left: 12,bottom: 12,),color: Colors.white,),
          Container(child: Row(
            children: <Widget>[
              InkWell(
                onTap: (){
                  if(qty > 1){
                    setState(() {
                      qty = --qty;
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
                onTap: (){
                  setState(() {
                    qty = ++qty;
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
              Spacer(),
              widget.active==0?Container():Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
                //width: MediaQuery.of(context).size.width*0.12,
                //height: MediaQuery.of(context).size.width*0.10,
                padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                decoration: BoxDecoration(
                  color: Color(0xFFff8500),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)
                  ),

                ),
                child:  Text(AppLocalizations.of(context).express,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
              ),
            ],
          ),padding: EdgeInsets.only(right: 12,left: 12,bottom: 12,),color: Colors.white,),
          //SizedBox(height: MediaQuery.of(context).size.height*0.01,),
          // Row(children: [
          //   Container(margin: EdgeInsets.all(12),height:MediaQuery.of(context).size.height*0.14,child: ListView.builder(
          //
          //     shrinkWrap: true,
          //     scrollDirection: Axis.horizontal,
          //     itemCount: ADs4.length,
          //     itemBuilder: (BuildContext context, int index){
          //       // String s = Sellers[index]['photo'];
          //       // String name = s.replaceAll('assets', 'super_k/assets');
          //       return InkWell(onTap: (){
          //         //getAllCategorys(Sellers[index]['id']);
          //
          //         setState(() {
          //           CategroyActive = index;
          //
          //         });
          //         if(CategroyActive == 0){
          //           setState(() {
          //             print(CategroyActive.toString());
          //             // work.clear();
          //             work = ADs;
          //           });
          //
          //         }else if(CategroyActive == 1){
          //           setState(() {
          //             print(CategroyActive.toString());
          //             // work.clear();
          //             work = ADs2;
          //           });
          //         }else if(CategroyActive == 2){
          //           setState(() {
          //             print(CategroyActive.toString());
          //             // work.clear();
          //             work = ADs3;
          //           });
          //         }
          //
          //       },child: Column(children: [
          //         CategroyActive==index? Container(margin: EdgeInsets.all(5),height:MediaQuery.of(context).size.height*0.07,width: MediaQuery.of(context).size.height*0.07,decoration: BoxDecoration(
          //           border: Border.all(color: Color(0xFFff8500),width:  CategroyActive==index?2:0),
          //           borderRadius: BorderRadius.only(
          //               topLeft: Radius.circular(5),
          //               topRight: Radius.circular(5),
          //               bottomLeft: Radius.circular(5),
          //               bottomRight: Radius.circular(5)),
          //         ),child: Image.network("${ADs4[index]}"),): Container(margin: EdgeInsets.all(5),height:MediaQuery.of(context).size.height*0.07,width: MediaQuery.of(context).size.height*0.07,decoration: BoxDecoration(
          //           // border: Border.all(color: Color(0xFF13446f),width:  CategroyActive==index?2:0),
          //           borderRadius: BorderRadius.only(
          //               topLeft: Radius.circular(5),
          //               topRight: Radius.circular(5),
          //               bottomLeft: Radius.circular(5),
          //               bottomRight: Radius.circular(5)),
          //         ),child: Image.network("${ADs4[index]}"),),
          //         Container(height: MediaQuery.of(context).size.height*0.045,child: Center(child: Text("${ADs5[index]}",textAlign: TextAlign.center,style: TextStyle(color: CategroyActive==index?Color(0xFFff8500):Colors.black,fontSize: MediaQuery.of(context).size.height*0.02),maxLines: 2,),),)
          //         //Text("Category",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02))
          //       ],),);
          //     },
          //   ),),
          // ],),
          // SizedBox(height: MediaQuery.of(context).size.height*0.01,),

          new TabBar(
            isScrollable: true,
            controller: _controller,
            tabs: [
              new Tab(
                child: new Text(
                  AppLocalizations.of(context).ProductDesc,
                  style: new TextStyle(color: Colors.black),
                ),
              ),
              new Tab(
                child: new Text(
                  AppLocalizations.of(context).Specification,
                  style: new TextStyle(color: Colors.black),
                ),
              ),
              new Tab(
                child: new Text(
                  AppLocalizations.of(context).UserReview,
                  style: new TextStyle(color: Colors.black),
                ),
              ),
            ],
            indicatorColor: Color(0xFFff8500),
          ),
          new Divider(
            height: 1.0,
          ),
          // NestedScrollView(
          // controller: _scrollController,
          // headerSliverBuilder: (context, value) {
          // return [
          // SliverToBoxAdapter(child: _buildCarousel()),
          // SliverToBoxAdapter(
          // child:new TabBarView(
          // controller: _controller,
          // children: _pages,
          // ),);),
          new Container(
            height: 400,
            child: new TabBarView(
              controller: _controller,
              children: _pages,
            ),
          ),
          // SizedBox(height: 50,),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20,right: 20),
          //   child: Row(
          //     children: <Widget>[
          //       Text("Name :",style: TextStyle(
          //           fontSize: 17,
          //           fontWeight: FontWeight.w500
          //       ),),
          //       SizedBox(width: 10,),
          //       Text(widget.name.length > 30 ? '${"${widget.name}".substring(0, 30)}.':"${widget.name}",style: TextStyle(fontSize:  MediaQuery.of(context).size.height*0.022,color: Colors.black),),
          //
          //       // Text(widget.name,style: TextStyle(
          //       //   fontSize: 18,
          //       //   fontWeight: FontWeight.w500
          //       // ),)
          //
          //     ],
          //   ),
          // ),
          // SizedBox(height: 20,),
          // // Padding(
          // //   padding: const EdgeInsets.only(left: 20,right: 20),
          // //   child: Row(
          // //     children: <Widget>[
          // //       Text("Code :",style: TextStyle(
          // //         fontSize: 17,
          // //         fontWeight: FontWeight.w500
          // //       ),),
          // //       SizedBox(width: 20,),
          // //       Text(widget.code,style: TextStyle(
          // //         fontSize: 18,
          // //         fontWeight: FontWeight.w500
          // //       ),)
          // //
          // //     ],
          // //   ),
          // // ),
          // // SizedBox(height: 20,),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20,right: 20),
          //   child: Row(
          //     children: <Widget>[
          //       Text("Price :",style: TextStyle(
          //         fontSize: 17,
          //         fontWeight: FontWeight.w500
          //       ),),
          //       SizedBox(width: 20,),
          //       Row(
          //         children: <Widget>[
          //           Text(widget.pPromotionPrice+" LE",style: TextStyle(
          //         fontSize: 17,
          //         fontWeight: FontWeight.w500
          //       ),),
          //       SizedBox(width: 20,),
          //       Text(widget.pPrice+" LE",style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.w500,
          //         //color: warning,
          //           color: Color(0xFFf97e9c),
          //         decoration: TextDecoration.lineThrough
          //       ),)
          //         ],
          //       )
          //
          //     ],
          //   ),
          // ),
          // // SizedBox(height: 25,),
          // // Padding(
          // //   padding: const EdgeInsets.only(left: 20,right: 20),
          // //   child: Row(
          // //     crossAxisAlignment: CrossAxisAlignment.start,
          // //     children: <Widget>[
          // //       Text("Colors :",style: TextStyle(
          // //         fontSize: 17,
          // //         fontWeight: FontWeight.w500
          // //       ),),
          // //       SizedBox(width: 20,),
          // //       Flexible(
          // //                         child: Wrap(
          // //           children: List.generate(colors.length, (index) =>
          // //           Padding(
          // //             padding: const EdgeInsets.only(right: 15,bottom: 15),
          // //             child: Container(
          // //             height: 25,
          // //             width: 25,
          // //             decoration: BoxDecoration(
          // //               color: colors[index],
          // //               shape: BoxShape.circle
          // //             ),
          // //         ),
          // //           )),
          // //         ),
          // //       )
          // //
          // //     ],
          // //   ),
          // // ),
          // SizedBox(height: 20,),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20,right: 20),
          //   child: Row(
          //     children: <Widget>[
          //       Text("Description :",style: TextStyle(
          //           fontSize: 17,
          //           fontWeight: FontWeight.w500
          //       ),),
          //       SizedBox(width: 20,),
          //       Text(widget.code.length > 40 ? '${"${widget.code}".substring(0, 40)}..':"${widget.code}",style: TextStyle(fontSize:  MediaQuery.of(context).size.height*0.022,color: Colors.black),),
          //
          //       // Text(widget.name,style: TextStyle(
          //       //   fontSize: 18,
          //       //   fontWeight: FontWeight.w500
          //       // ),)
          //
          //     ],
          //   ),
          // ),
          // // Container(height: 200,padding: EdgeInsets.only(left: 20,right: 20),child: Row(
          // //   children: <Widget>[
          // //     Text(widget.code,style: TextStyle(
          // //         fontSize: 17,
          // //         fontWeight: FontWeight.w500
          // //     ),maxLines: 4,),
          // //
          // //   ],
          // // ),),
          // SizedBox(height: 20,),
          // Padding(
          //   padding: const EdgeInsets.only(right: 20,left: 20),
          //   child: Row(
          //     children: <Widget>[
          //       Text("Qty :",style: TextStyle(
          //           fontSize: 17,
          //           fontWeight: FontWeight.w500
          //         ),),
          //         SizedBox(width: 20,),
          //         Row(
          //           children: <Widget>[
          //             InkWell(
          //               onTap: (){
          //                 if(qty > 1){
          //                  setState(() {
          //                     qty = --qty;
          //                   });
          //                 }
          //
          //                 // minus here
          //               },
          //              child: Container(
          //                 width: 25,
          //                 height: 25,
          //                 decoration: BoxDecoration(
          //                   border: Border.all(color: primary),
          //                   shape: BoxShape.circle
          //                 ),
          //                 child: Icon(LineIcons.minus,size: 15,),
          //               ),
          //             ),
          //             SizedBox(width: 15,),
          //             Text(qty.toString(),style: TextStyle(
          //               fontSize: 16
          //             ),),
          //             SizedBox(width: 15,),
          //             InkWell(
          //               onTap: (){
          //                 setState(() {
          //                   qty = ++qty;
          //                 });
          //                 // minus here
          //               },
          //                                     child: Container(
          //                 width: 25,
          //                 height: 25,
          //                 decoration: BoxDecoration(
          //                   border: Border.all(color: primary),
          //                   shape: BoxShape.circle
          //                 ),
          //                 child: Icon(LineIcons.plus,size: 15,),
          //               ),
          //             ),
          //
          //           ],
          //         )
          //     ],
          //   ),
          // ),
          // // SizedBox(height: 20,),
          // // Align( alignment: Alignment.bottomCenter,
          // //   child: new ButtonBar(
          // //     alignment: MainAxisAlignment.center,
          // //     children: <Widget>[
          // //       Padding(
          // //         padding: EdgeInsets.all(10.0),
          // //         child: new Text(
          // //           "This is a very bigggggggg text !!!",textDirection: TextDirection.ltr,
          // //           style: new TextStyle(fontSize: 20.0, color: Colors.black),
          // //           maxLines: 5,
          // //         ),
          // //       )
          // //     ],
          // //   ),
          // // ),
          //
          // SizedBox(height: 50,),

          // InkWell(
          //   onTap: () async {
          //     // your add cart function here
          //     SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
          //     Map maps = {"name":"${widget.name}",
          //       "id":"${widget.id}",
          //       "qty":"$qty",
          //       "price":"${widget.pPromotionPrice}",
          //       "pprice":"${widget.pPrice}",
          //       "image":"${widget.img}"
          //     };
          //     if(sharedPrefs.getString("proIds") != null){
          //       setState(() {
          //         proIds = json.decode(sharedPrefs.getString("proIds"));
          //
          //       });
          //       for(int i =0;i<proIds.length;i++){
          //         print(proIds[i]['id']);
          //         if(proIds[i]['id'] == "${widget.id}"){
          //
          //           setState(() {
          //             checkRepet = 1;
          //           });
          //         }
          //       }
          //     }
          //
          //     if(checkRepet == 0){
          //       proIds.add(maps);
          //
          //       sharedPrefs.setString("proIds", json.encode(proIds));
          //
          //     }
          //
          //     print(proIds);
          //     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          //         Cart()), (Route<dynamic> route) => false);
          //     //Navigator.pushReplacementNamed(context, "Cart");
          //     // your add cart function here
          //   },
          //   child: Padding(padding: EdgeInsets.only(left: 20,right: 20),
          //     child: Container(
          //       height: 50,
          //       width: double.infinity,
          //       decoration: BoxDecoration(
          //           color: Color(0xFF1533e8),
          //           borderRadius: BorderRadius.circular(30)
          //       ),
          //       child: Center(
          //         child: Text("ADD TO CART",style: TextStyle(
          //           color: white,
          //           fontSize: 20,
          //
          //         ),),
          //       ),
          //     ),),
          // )
        ],
      ), ),
          ),


    Align(
    alignment: Alignment.bottomCenter,
    child:
    InkWell(
      onTap: () async {
        // your add cart function here
        SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
        Map maps = {"name":"${widget.name}",
          "name_ar":"${widget.name_ar}",
          "id":"${widget.id}",
          "qty":"$qty",
          "seller_name":"${widget.seller_name}",
          "seller_name_ar":"${widget.seller_name_ar}",
          "deliv_free":"${widget.deliv_free}",
          "deliv_time":"${widget.deliv_time}",
          "active":"${widget.active}",
          "specification":"${widget.specification}",
          "specification_ar":"${widget.specification_ar}",
          "code":"${widget.code}",
          "code_ar":"${widget.code_ar}",
          "pprice":"${widget.pPromotionPrice}",
          "price":"${widget.pPrice}",
          "image":"${widget.img}"
        };
        if(sharedPrefs.getString("proIds") != null){
          setState(() {
            proIds = json.decode(sharedPrefs.getString("proIds"));

          });
          for(int i =0;i<proIds.length;i++){
            print(proIds[i]['id']);
            if(proIds[i]['id'] == "${widget.id}"){

              setState(() {
                checkRepet = 1;
              });
            }
          }
        }

        if(checkRepet == 0){
          proIds.add(maps);

          sharedPrefs.setString("proIds", json.encode(proIds));

        }

        print(proIds);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            Cart()), (Route<dynamic> route) => false);
        //Navigator.pushReplacementNamed(context, "Cart");
        // your add cart function here
      },
      child: Padding(padding: EdgeInsets.only(left: 20,right: 20),
        child: Container(
          margin: EdgeInsets.all(10),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color(0xFF13446f),
              borderRadius: BorderRadius.circular(30)
          ),
          child: Container(padding: EdgeInsets.only(top: 8,bottom: 8,left: 20,right: 20),
            child: Row(children: [
              Text(AppLocalizations.of(context).add_to_cart,style: TextStyle(
                color: white,
                fontSize: 20,
              ),),
              Spacer(),
              Icon(Icons.add_shopping_cart_rounded,color: Color(0xFFff8500),),
            ],),
          ),
        ),),
    ),
    )
      ],),

    );
  }

  void checkFav() async {
    // for(int i =0;i<ADs2.length;i++){
    //   work.add(ADs3[i]);
    // }
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      Login = sharedPrefs.getBool("login");
      print("$Login 9999999999999999999999999999999999999999999");
    });
    if(sharedPrefs.getString("proFav") != null){
      setState(() {
        Fav = json.decode(sharedPrefs.getString("proFav"));
      });
      print(Fav.toString());

      for(int i=0;i<Fav.length;i++){

        if(Fav[i]['id']==widget.id.toString()){

          setState(() {
            FavIndex = i;
            activeFav = 1;
          });
        }
      }
      print(activeFav.toString());
      print(widget.id.toString());

    }


  }
  void getSellerName() async {
    http.Response response = await http.get('http://wootc.net/api/rates/?access_token=XtOqtttIf4LDLN6yDBXomthsuzAyzj2XWVrxyizaNzyzYsd8puQfQ04RiKDy2nXa',headers: {"Accept":"application/json"},);
    Map map = json.decode(response.body);
    print(map);
    reviews.clear();
    if(map['Status'] == true){
         for(int x = 0;x<map['Rates'].length;x++){
           if(map['Rates'][x]['product_id'] == widget.id){
             setState(() {
               reviews.add(map['Rates'][x]);
             });
           }
         }
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

class UserReview extends StatefulWidget {
  final List text;
  final int id;
  final bool login;
  UserReview({this.text,this.login,this.id});

  @override
  State<StatefulWidget> createState(){
    // TODO: implement createState
    return UserReviewState();
  }

}
class UserReviewState extends State<UserReview>{
  bool Log;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLogin();
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: new Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Container(child: Center(
          child: Column(children: [
            Log != true?Container():Padding(
              padding: EdgeInsets.all(5),
              child: Row(children: [
                InkWell(child: Icon(Icons.edit_outlined,color:Color(0xFF13446f),),onTap:() async {
                  _showRatingDialog();
                  //_showAlert();
                  // Navigator.pushReplacement(
                  //     context, MaterialPageRoute(builder: (context) => user_location2()));
                },),
                // IconButton(icon: Icon(Icons.home,color:Color(0xFF13446f) ,), onPressed: null)

              ],),
            ),
            Expanded(child: ListView.builder(
              // padding: EdgeInsets.all(12.0),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        // leading: CircleAvatar(
                        //   backgroundColor: Color(0xFFb41a51),
                        //   backgroundImage:  NetworkImage('https://st.depositphotos.com/1779253/5140/v/950/depositphotos_51405259-stock-illustration-male-avatar-profile-picture-use.jpg'),
                        // ),
                        title: Text(
                          "${widget.text[index]['email']}",
                          style:
                          TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Row(children: [
                          StarRating(
                            color: Colors.yellow,
                            starCount: 5,
                            rating: double.parse("${widget.text[index]['rate']}"),
                            size: 14,
                          ),
                          // Text("created_at",style: TextStyle(fontSize: 12)),
                          // Text("  |  ",style: TextStyle(fontSize: 12)),
                          // Text("created_at",style: TextStyle(fontSize: 12)),
                          // Text("${widget.list[index]['created_at']}",style: TextStyle(fontSize: 12),),
                          // Text("${widget.list[index]['created_at']}",style: TextStyle(fontSize: 12),),
                        ],),
                        trailing:Text(widget.text[index]['created_at'].length > 10 ? '${"${widget.text[index]['created_at']}".substring(0, 10)}':"${widget.text[index]['created_at']}",style: TextStyle(fontSize:  12,color: Colors.black),),
                        //Text("21-04-2021",style: TextStyle(fontSize: 12)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "${widget.text[index]['message']}",
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                );
                // return ConversationCard(
                //   conversation: snapshot.data[index],
                //   onChatButtonClicked: _onCoversationClicked,
                // );
              },
              itemCount: widget.text.length,
            ),),
          ],),
        ),margin: EdgeInsets.only(bottom: 50),),
      ),
    );
  }

  LoginAPI(rate,message) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    // print("user id is ${sharedPrefs.getString('UserId')}");
    var d ={
      "product_id": "${widget.id}",
      "email": "${sharedPrefs.getString('email')}",
      "rate": "$rate",
      "message": "$message"
    };
    http.Response response = await http.post('http://wootc.net/api/rates/store?access_token=syEt93K5Gsg2Ozdgv8oK22NQLYNzMJtiLHD06JMrpkqF05Kc5VCl9aeWgpcdAB6r',body: json.encode(d),headers: { "Accept":"application/json",'Content-type': 'application/json',});
    print(response.body.toString());
    var responsebody = json.decode(response.body);
    if(responsebody['Status'] == true){

      setState(() {
        Login = true;
      });
      return 'success';
    }else{
      return 'error';
    }
  }
  void _showRatingDialog() {
    // We use the built in showDialog function to show our Rating Dialog
    showDialog(
        context: context,
        barrierDismissible: false, // set to false if you want to force a rating
        builder: (context) {
          return RatingDialog(
            icon: Image(height:100,width:100,image:AssetImage("images/superk2.png")), // set your own image/icon widget
            title: AppLocalizations.of(context).reviewPro,
            description: AppLocalizations.of(context).proImp,
            submitButton: AppLocalizations.of(context).save,
            //alternativeButton: "Contact us instead?", // optional
            //positiveComment: "We are so happy to hear :)", // optional
            //negativeComment: "We're sad to hear :(", // optional
            accentColor: Color(0xff03447a), // optional
            onSubmitPressed: (int rating) async{
              print("onSubmitPressed: rating = $rating");
              if(rating > 3){
                LoginAPI(rating,'We are so happy to hear');
              } else {
                LoginAPI(rating,"We're sad to hear");
              }

//              String Res = await Meeting(GroupId,"thanwya$GroupId","end");
//              print("Result of rate is : $Res");
//              setState(() {
//                isJoinMeeting = false;
//                JitsiMeet.closeMeeting();
//              });
              // TODO: open the app's page on Google Play / Apple App Store
            },
            onAlternativePressed: () {
              print("onAlternativePressed: do something");
              // TODO: maybe you want the user to contact you instead of rating a bad review
            },
          );
        });
  }

  void _showAlert() {
    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 260.0,
        height: 230.0,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // dialog top
            new Expanded(
              child: new Row(
                children: <Widget>[
                  new Container(
                    // padding: new EdgeInsets.all(10.0),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                    ),
                    child: new Text(
                      'Rate',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontFamily: 'helvetica_neue_light',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            // dialog centre
            new Expanded(
              child: new Container(
                  child: new TextField(
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      filled: false,
                      contentPadding: new EdgeInsets.only(
                          left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                      hintText: ' add review',
                      hintStyle: new TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12.0,
                        fontFamily: 'helvetica_neue_light',
                      ),
                    ),
                  )),
              flex: 2,
            ),

            // dialog bottom
            new Expanded(
              child: new Container(
                padding: new EdgeInsets.all(16.0),
                decoration: new BoxDecoration(
                  color: const Color(0xFF33b17c),
                ),
                child: new Text(
                  'Rate product',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    showDialog(context: context, child: dialog);
  }


  void getLogin() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      Log = sharedPrefs.getBool("login");
    });
  }

}
class Specification extends StatelessWidget {
  final List text;
  Specification({this.text});
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(child:ListView.builder(
        shrinkWrap: true,
        // scrollDirection: Axis.horizontal,
        itemCount: text.length,
        //reverse: true,
        itemBuilder: (ctx, id) {
          return GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => MyHomePage(CatId: Categorys[id]['id'],),
              //     ));
            },
            child: Text(text[id]),
          );
        },
      ),),
    );
  }
}
class ProductDesc extends StatelessWidget {
  final String text;
  ProductDesc({this.text});
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(children: [
          new Text(text,
            // "A smart Personal assistant at your beck and call, who makes doing your everyday tasks"
            //     "easier - isn't that the dream? whether it it managing your calendar, playing music, or "
            //     "controlling your home entertainment, these can all be done by the Google Home - all you have to do is say "
            //     "\"Ok Google\" \n\n you can know the status of real-time information such as the current weather, important news,"
            //     "match dates and scores of your favourite sports team and much more by using your voice.",
            style: new TextStyle(
                fontFamily: "OpenSans",
                color: Colors.black,
                fontSize: 13.0,
                fontWeight: FontWeight.w200),
          )
        ],),
      ),
    );
  }


}
