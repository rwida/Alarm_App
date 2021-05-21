import 'dart:convert';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:superk_new/OrderFilter.dart';
import 'package:superk_new/invoice/invoice.dart';

import 'locale/localization.dart';

class Order extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderState();
  }

}

class OrderState extends State<Order>{
   TextEditingController _controller1;
  String _valueChanged1 = '';
  String _valueToValidate1 = '';
  String _valueSaved1 = '';
  int totalAmount = 0;
  int tabIndex = 1;
  List data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategorys();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(actions: [IconButton(icon: Icon(Icons.tune,color: Color(0xFFff8500),), onPressed: (){


        //_displayTextInputDialog(context);
        _selectDate(context);
        // showAnimatedDialog(
        //   context: context,
        //   barrierDismissible: false,
        //   builder: (BuildContext context) {
        //     return ClassicGeneralDialogWidget(
        //      // titleText: 'Title',
        //       contentText: 'content',
        //       actions: [
        //          new Row(
        //           children: <Widget>[
        //             new Expanded(
        //               child: new TextField(
        //                 autofocus: true,
        //                 decoration: new InputDecoration(
        //                     labelText: 'Full Name', hintText: 'eg. John Smith'),
        //               ),
        //             )
        //           ],
        //         ),
        //       ],
        //
        //       // onPositiveClick: () {
        //       //   Navigator.of(context).pop();
        //       // },
        //       // onNegativeClick: () {
        //       //   Navigator.of(context).pop();
        //       // },
        //     );
        //   },
        //   animationType: DialogTransitionType.size,
        //   curve: Curves.fastOutSlowIn,
        //   duration: Duration(seconds: 1),
        // );
      })],centerTitle: true,elevation: 0,title:  Text(AppLocalizations.of(context).all_orders,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.height*0.025),),backgroundColor: Color(0xFF284456),),
      body: SingleChildScrollView(
        child:Container(child: Container(child: ListView.builder(
            primary: false,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              List s = data[index]['line_items'];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Invoice(InvName:data[index]['name'].toString(),InvDate:"${data[index]['created_at']}".substring(0, 10),InvTotal: data[index]['total_price'].toString(),InvList: s,InvEmail: data[index]['email'],InvPhone: data[index]['phone'],),
                      ));
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
                              // borderRadius: BorderRadius.only(
                              //     topLeft: Radius.circular(10),
                              //     topRight: Radius.circular(10),
                              //     bottomLeft: Radius.circular(10),
                              //     bottomRight: Radius.circular(10)
                              // ),
                              // image: DecorationImage(
                              //   image: NetworkImage('https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823_960_720.jpg'),
                              //   fit: BoxFit.cover,
                              // ),
                              //color: Color(0xffe5e6ea),
                            ),
                            child: Image.asset("images/receipt.png"),
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
                                  //Text(itemName.length > 24 ? '${"${itemName}".substring(0, 24)}':"${itemName}",style: TextStyle(fontSize:  15,color: Colors.black),),
                                  Text('${data[index]['name']}',style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,fontWeight: FontWeight.bold),),

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
                              Text(data[index]['created_at'].length > 10 ? '${"${data[index]['created_at']}".substring(0, 10)}':"${data[index]['created_at']}",style: TextStyle(fontSize:  15,color: Colors.black),),
                              //Text('${data[index]['created_at']}',overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,fontWeight: FontWeight.bold),),

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

                             // SizedBox(height: 7.0),
                              Row(children: [
                                Row(children: [
                                  Text('${s.length}  ',style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,fontWeight: FontWeight.bold),),
                                  //Text('${NumberFormat.currency(name: '').format(double.parse("50.20"))}',style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,fontWeight: FontWeight.bold),),
                                  Text(AppLocalizations.of(context).Product,style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.height*0.015,color: Color(0xFFff8500)),),
                                ],),
                                //SizedBox(width: 10,),

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
                              Row(children: [
                                // Text("${NumberFormat.currency(name: '').format(double.parse("${data[index]['total_price']}"))}  EGP",style: TextStyle(
                                //     fontSize: MediaQuery.of(context).size.height*0.015,
                                //     fontWeight: FontWeight.w500,
                                //     //color: warning,
                                //     color: Color(0xFFff8500),
                                //     decoration: TextDecoration.lineThrough
                                // ),),
                                Text('${NumberFormat.currency(name: '').format(double.parse("${data[index]['total_price']}"))}  ',style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,fontWeight: FontWeight.bold),),
                                 Text(
                                   AppLocalizations.of(context).LE,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: MediaQuery.of(context).size.height*0.015,
                                      color: Color(0xFFff8500)),
                                ),

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
            }),margin: EdgeInsets.only(top: 20),),)
      ),
    );
  }
   DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
     final DateTime picked = await
     showDatePicker(
         context: context,
         initialDate: selectedDate,
         firstDate: DateTime(2015, 8),
         lastDate: DateTime(selectedDate.year,selectedDate.month,selectedDate.day),
          );
     if (picked != null && picked != selectedDate)
       setState(() {
         //print(selectedDate.year.toString());
         //selectedDate = picked;
         FilterDate(picked.toString().substring(0,10));
         Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => OrderFilter(InvDate: picked.toString().substring(0,10),),
             ));
         print(picked.toString());
         print(selectedDate.toString());
       });
   }
   FilterDate(String FiltterDate){
    List x = [];
    for(int i=0;i<data.length;i++){

    }
    print(FiltterDate);

   }
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Search in Orders'),
            content: Column(children: [
              InkWell(child: Text("asdsaddsa"),onTap: (){
                _selectDate(context);
              },),

              TextField(
                onChanged: (value) {
                  setState(() {

                    // valueText = value;
                  });
                },
                //controller: _textFieldController,
                decoration: InputDecoration(hintText: "Search by order number"),
              ),


            ],),
            actions: <Widget>[

              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                   // codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),

            ],
          );
        });
  }




  void getCategorys() async {
    //SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    http.Response response = await http.get('https://7712bd6b62936aac7664b79616da13e2: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@superkshop.myshopify.com/admin/api/2020-10/orders.json',headers: {"Accept":"application/json"},);
    Map map = json.decode(response.body);
    print(map['orders']);
    for(int i=0;i<map['orders'].length;i++){
      if(map['orders'][i]['email'].toString() == 'm.nabil1309@gmail.com'){
        setState(() {
          data.add(map['orders'][i]);
        });
      }
    }
  }


}
