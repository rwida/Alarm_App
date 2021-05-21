import 'package:superk_new/invoice/constants.dart';
import 'package:flutter/material.dart';
import 'package:superk_new/locale/localization.dart';

class InvoiceBody extends StatelessWidget {
  final String InvTotal;
  final List InvList;
  InvoiceBody({
    this.InvTotal,this.InvList
  });
  @override
  Widget build(BuildContext context) {
    var totalAmt = 64;
    double height =
        ScreenConfig.deviceHeight - ScreenConfig.getProportionalHeight(374);
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenConfig.getProportionalWidth(40),
      ),
      color: iPrimaryColor,
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: ScreenConfig.getProportionalHeight(27),
          ),
          // addItemAction(),
          // SizedBox(
          //   height: ScreenConfig.getProportionalHeight(27),
          // ),
          Column(
            children: [
              Column(
                children: List.generate(
                    InvList.length,
                        (index) => Column(
                      children: [
                        invoiceItem(
                            InvList[index]["quantity"].toString(),
                            //demoDate[index]["imagePath"],
                            InvList[index]["price"],
                            InvList[index]["title"]),
                        SizedBox(
                          height: ScreenConfig.getProportionalHeight(22),
                        )
                      ],
                    )),
              ),
              invoiceTotal(InvTotal,context),
              SizedBox(
                height: ScreenConfig.getProportionalHeight(56),
              ),
              // FlatButton(
              //     color: iAccentColor2,
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(18)),
              //     onPressed: () {},
              //     child: SizedBox(
              //       height: ScreenConfig.getProportionalHeight(80),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Icon(Icons.file_download),
              //           Text(
              //             "Download",
              //             style: TextStyle(
              //               fontSize: ScreenConfig.getProportionalHeight(27),
              //               fontWeight: FontWeight.bold,
              //             ),
              //           )
              //         ],
              //       ),
              //     ))
            ],
          )
        ]),
      ),
    );
  }

  Row invoiceTotal(String totalAmt,context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Text(AppLocalizations.of(context).total_price,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenConfig.getProportionalHeight(26),
                )),
            SizedBox(
              width: ScreenConfig.getProportionalWidth(40),
            ),
            Text(
              "$totalAmt  "+AppLocalizations.of(context).LE,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: ScreenConfig.getProportionalHeight(26),
              ),
            ),
          ],
        )
      ],
    );
  }

  Container invoiceItem(
      String quantity, String price, String itemDesc) {
    double totalValue = double.parse(quantity) * double.parse(price);
    return Container(
      height: ScreenConfig.getProportionalHeight(170),
      padding: EdgeInsets.symmetric(
          horizontal: ScreenConfig.getProportionalWidth(27)),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 11),
            blurRadius: 11,
            color: Colors.black.withOpacity(0.06),
          )
        ],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            quantity.toString(),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Image.asset(
          //   imagePath,
          //   height: 100,
          //   width: 80,
          // ),
          Text(
            "$price",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: ScreenConfig.getProportionalWidth(200.8),
            child: Text(
              itemDesc,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            "$totalValue ",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Row addItemAction() {
    return Row(
      children: [
        Text(
          "Items",
          style: TextStyle(
              color: Colors.black,
              fontSize: ScreenConfig.getProportionalHeight(30)),
        ),
        SizedBox(
          width: ScreenConfig.getProportionalWidth(50),
        ),
        FlatButton(
            color: iAccentColor2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            onPressed: () {},
            child: Row(
              children: [Icon(Icons.add), Text("Add Items")],
            ))
      ],
    );
  }
}