
import 'package:flutter/material.dart';
import 'package:superk_new/invoice/constants.dart';
import 'package:superk_new/invoice/invoice_body.dart';
import 'package:superk_new/locale/localization.dart';

class Invoice extends StatelessWidget {
  final String InvName,InvDate,InvEmail,InvPhone,InvTotal;
  final List InvList;
  Invoice({
    this.InvName,this.InvDate,this.InvEmail,this.InvPhone,this.InvTotal,this.InvList
  });
  @override
  Widget build(BuildContext context) {
    ScreenConfig.init(context);
    return Scaffold(

      backgroundColor: iPrimaryColor,
      body: Column(
        children: [
          invoiceHeader(context),
          InvoiceBody(InvList: InvList,InvTotal: InvTotal,),
        ],
      ),
    );
  }

  Widget invoiceHeader(context) {
    return Container(
      width: ScreenConfig.deviceWidth,
      height: ScreenConfig.getProportionalHeight(374),
      color: Color(0xFF13446f),
      padding: EdgeInsets.only(
          top: ScreenConfig.getProportionalHeight(50),
          left: ScreenConfig.getProportionalWidth(40),
          right: ScreenConfig.getProportionalWidth(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(children: [


                Text(
                  AppLocalizations.of(context).invoice,
                  style: TextStyle(
                      color: Color(0xFFff8500),
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenConfig.getProportionalHeight(56)),
                ),
                Spacer(),
                InkWell(child: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,),onTap: (){
                  Navigator.pop(context);
                },),
              ],),
              SizedBox(
                height: ScreenConfig.getProportionalHeight(20),
              ),
              topHeaderText("${InvName}"),
              SizedBox(
                height: ScreenConfig.getProportionalHeight(20),
              ),
              topHeaderText("${InvDate}"),
            ],
          ),
          SizedBox(
            height: ScreenConfig.getProportionalHeight(20),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "images/receipt.png",
                    height: ScreenConfig.getProportionalHeight(78),
                    //color: Colors.white,
                  ),
                  deliveryAddressColumn(context),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Column deliveryAddressColumn(context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context).personal_data,
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2,color: Color(0xFFff8500)),
        ),
        SizedBox(
          height: 10,
        ),
        Text("$InvEmail",style: TextStyle(color: Colors.white.withOpacity(0.5),),),
        Text("$InvPhone",style: TextStyle(color: Colors.white.withOpacity(0.5),),),
      ],
    );
  }

  Text topHeaderText(String label) {
    return Text(
      label,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white.withOpacity(0.5),
          fontSize: ScreenConfig.getProportionalHeight(20)),
    );
  }
}