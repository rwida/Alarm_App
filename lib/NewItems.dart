import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:easy_localization/public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:superk_new/Cart.dart';
import 'package:superk_new/MyHomePage.dart';
import 'package:superk_new/favorite_tow.dart';
import 'package:superk_new/profile.dart';

import 'Settings.dart';

class NewItems extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewItemState();
  }

}
List<Note> ListNew = new List();
int pageIndex = 0;
int tabIndex = 0;
class NewItemState extends State<NewItems>{
  final TextEditingController _phone = new TextEditingController();
  List ADs = ['https://image.freepik.com/free-vector/abstack-background-cartoon-style-bigbamm-sunlight_68708-513.jpg','https://image.freepik.com/free-vector/yellow-background-with-halftone-lines-design_1017-30148.jpg','https://image.freepik.com/free-photo/wall-wallpaper-concrete-colored-painted-textured-concept_53876-31799.jpg','https://image.freepik.com/free-photo/dark-stone-texture_125540-768.jpg'];
  List dd = ['Fashion','Electronic','Furniture','Baby','Health','Sport','Gaming','School',];
  List Categorys = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategorys();
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
      // child:
      Scaffold(
      body:Stack(children: [
        Column(
            children: [
              Container(width:double.infinity,height: MediaQuery.of(context).size.height*0.34,child:Stack(children: [
                Container(width:double.infinity,height: MediaQuery.of(context).size.height*0.25,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/pgn.png"), fit: BoxFit.cover)),
                  child: Column(children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                    Container(margin: EdgeInsets.all(MediaQuery.of(context).size.height*0.03,),child: Row(children: [
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
                                  child: Container(
                                    // padding: EdgeInsets.all(8),

                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      child:  TextField(
                                        controller: _phone,
                                        onTap: (){
                                          showSearch(
                                              context: context,
                                              delegate: DataSearch(ListNew));
                                        },
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            fontFamily: 'Jana'),
                                        //autofocus: true,
                                        // onSubmitted: onSubmitted,
                                        decoration: InputDecoration.collapsed(
                                          hintText: 'Search any thing',
                                          hintStyle: TextStyle(
                                              fontSize: MediaQuery.of(context).size.height*0.02,
                                              color: Colors.grey,
                                              fontFamily: 'Jana'),
                                          border: InputBorder.none,
                                        ),
                                        maxLines: 1,
                                      )
                                  ),

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
                Container(
                    height: MediaQuery.of(context).size.height*0.20,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.14),
                    child: CarouselSlider.builder(
                      itemCount: ADs.length,
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
                          child:   Container(
                            padding: EdgeInsets.all(30),
                            //padding: EdgeInsets.all(20),
                            //margin: EdgeInsets.only(left: 10),
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)
                              ),
                              color: Colors.black,
                              image: new DecorationImage(
                                fit: BoxFit.cover,
                                //colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                                image: new NetworkImage(
                                  "${ADs[index]}",
                                ),

                              ),
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  //tr("Categories"),
                                  'Exciting bonus',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'jana',
                                    fontSize:  MediaQuery.of(context).size.height*0.025,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'for new users',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'jana',
                                    fontSize:  MediaQuery.of(context).size.height*0.025,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        );
                      },
                    )
                ),

              ],) ,),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Container(child:  DotsIndicator(
                dotsCount: ADs.length,
                position: double.parse("$pageIndex"),
                decorator: DotsDecorator(
                  color: Colors.grey[200], // Inactive color
                  activeColor:Color(0xFFff8500),
                ),
              ),),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              // Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.height*0.03,left: MediaQuery.of(context).size.height*0.03,),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              //
              //   Text("All Catego",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: MediaQuery.of(context).size.height*0.025),),
              // ],),),
              // SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              //SizedBox(height: 10,),
              // Container(child: ListView.builder(
              //   shrinkWrap: true,
              //   scrollDirection: Axis.horizontal,
              //   itemCount: dd.length,
              //   itemBuilder: (ctx, id) {
              //     return GestureDetector(
              //       onTap: () {
              //
              //
              //       },
              //       child: Container(
              //         margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.04),
              //         child: Column(
              //           children: <Widget>[
              //             Container(
              //               margin: EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
              //               width: MediaQuery.of(context).size.width*0.12,
              //               height: MediaQuery.of(context).size.width*0.12,
              //               padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03),
              //               decoration: BoxDecoration(
              //                 border: Border.all(color: Color(0xFFede8e8)),
              //                 // color: Color(0xFFf8f8f8),
              //                 borderRadius: BorderRadius.only(
              //                     topLeft: Radius.circular(10),
              //                     topRight: Radius.circular(10),
              //                     bottomLeft: Radius.circular(10),
              //                     bottomRight: Radius.circular(10)
              //                 ),
              //
              //               ),
              //               child:  Image.asset("images/${dd[id]}.png"),
              //             ),
              //             Text(
              //               "${dd[id]}",
              //               style: TextStyle(
              //                 fontWeight:
              //                 FontWeight.normal,
              //                 color:  Colors.black ,
              //                 fontSize: MediaQuery.of(context).size.height*0.015,
              //               ),
              //             ),
              //             SizedBox(height: 24,),
              //             // active == id ? Container(
              //             //   width: 50,
              //             //   height: 3,
              //             //   decoration: BoxDecoration(
              //             //       borderRadius: BorderRadius.circular(5.0),
              //             //       color: Colors.cyan
              //             //   ),
              //             // ) : Container(),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // ),height:  MediaQuery.of(context).size.height*0.14,),
              // SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.height*0.03,left: MediaQuery.of(context).size.height*0.03,),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Text("Main Categories",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: MediaQuery.of(context).size.height*0.025),),
                Spacer(),
                //Text("View all",style: TextStyle(color: Color(0xFFbceefa),fontSize: MediaQuery.of(context).size.height*0.02),),
              ],),),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Categorys.isEmpty?Container():Expanded(
                child: GridView.builder(
                  //controller: _scrollController,
                  itemCount: Categorys.length,
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
                              builder: (context) => MyHomePage(CatId: Categorys[index]['id'],),
                            ));
                      },
                      child: Container(
                        // margin: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 10,right: 10,bottom: 3),
                              width: MediaQuery.of(context).size.width*0.18,
                              height: MediaQuery.of(context).size.width*0.18,
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
                                      image: NetworkImage("${Categorys[index]['photo']}"), fit: BoxFit.cover),
                              ),

                            ),
                            Text(
                              "${Categorys[index]['name']}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight:
                                FontWeight.normal,
                                color:  Colors.black ,
                                fontSize: MediaQuery.of(context).size.height*0.02,
                              ),
                            ),
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
              )



            ]
        ),
        //Container(child: Image.asset("images/Rectangle.png"),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.13,bottom: MediaQuery.of(context).size.height*0.60),),
      ],),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: tabIndex,
          type: BottomNavigationBarType.fixed,
          //selectedItemColor: Color(0xFFf97e9c),
          selectedItemColor: Color(0xFFff8500),
          onTap: _onTap,// this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.favorite),
              title: new Text('Favorite'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text('Cart')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Account')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('Setting')
            ),
          ],
        ),
    )
      //,)
    ;
  }

  _onTap(int tabIndex) {
    switch (tabIndex) {
      case 0:
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
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Cart(),
            ));
        break;
      case 3:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => profile(),
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
  void getCategorys() async {
    //SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    http.Response response = await http.get('http://wootc.net/api/mainCategories?access_token=XtOqtttIf4LDLN6yDBXomthsuzAyzj2XWVrxyizaNzyzYsd8puQfQ04RiKDy2nXa',headers: {"Accept":"application/json"},);
    List map = json.decode(response.body);
    print(map);
    setState(() {
      Categorys = map;
    });
    ListNew.clear();
    for(int i =0;i<map.length;i++){
      setState(() {
        Note n = new Note();
        n.id = map[i]['id'];
        n.name = map[i]['name'];
        n.image = map[i]['photo'];
        ListNew.add(n);
      });
    }
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
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
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
        : items.where((p) => p.name.toLowerCase().startsWith(query.toLowerCase())).toList();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(color: Colors.white,child: ListView.separated(
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
                    text: suggestionList[index].name.substring(0, query.length),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'jana',
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                          text: suggestionList[index].name.substring(query.length),
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
      ),),
    );
  }

}

class Note {
  int id;
  String name;
  String image;
  String price;
  String priceC;
  String seller;
  String description;
}