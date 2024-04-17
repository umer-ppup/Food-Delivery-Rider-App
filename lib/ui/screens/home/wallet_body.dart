import 'package:flutter/material.dart';
import 'package:food_rider_app/models/order_history.dart';
import 'package:food_rider_app/models/transaction_history.dart';
import 'package:food_rider_app/resources/color_resources.dart';
import 'package:food_rider_app/resources/font_resources.dart';
import 'package:food_rider_app/resources/string_resources.dart';
import 'package:food_rider_app/util/util.dart';
import 'package:food_rider_app/widgets/custom_widgets.dart';

class WalletBody extends StatefulWidget {
  @override
  _WalletBodyState createState() => _WalletBodyState();
}

class _WalletBodyState extends State<WalletBody> {
  List<TransactionHistory> transactionHistory = [];
  double totalCash = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //region api call to read trasaction data
    readJson("URL", "transactionData").then((value){
      setState(() {
        transactionHistory = value;
        if(transactionHistory.isNotEmpty){
          for(int i = 0; i < transactionHistory.length; i++){
            totalCash = totalCash + double.parse(transactionHistory[i].transactionAmount);
          }
        }
      });
    });
    //endregion
  }

  @override
  Widget build(BuildContext context) {
    return transactionHistory.isNotEmpty ? Scaffold(
      backgroundColor: ColorResources.whiteColor,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //region top container for cash collected
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.0,
                      color: ColorResources.smokeWhiteColor,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    color: ColorResources.dodgerBlueColor,
                  ),
                  child: Column(
                    children: [
                      Text(
                        StringResources.walletCash,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: ColorResources.whiteColor,
                          fontFamily: FontResources.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "$totalCash Rs.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorResources.whiteColor,
                          fontFamily: FontResources.bold,
                        ),
                      )
                    ],
                  ),
                ),
                //endregion

                //region Transaction list text
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    StringResources.walletTransaction,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorResources.darkGreyColor,
                      fontFamily: FontResources.bold,
                    ),
                  ),
                ),
                //endregion

                //region transaction list
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: transactionHistory.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return walletWidget(
                          context,
                          transactionHistory[index].transactionId,
                          transactionHistory[index].transactionDate,
                          transactionHistory[index].transactionTime,
                          transactionHistory[index].transactionAmount
                      );
                    },
                  ),
                )
                //endregion
              ],
            ),
          ),
        ),
      )
    ) :
    //region view when transaction list is empty
    Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
    //endregion
  }
}
