import 'package:flutter/material.dart';
import 'package:food_rider_app/models/order_history.dart';
import 'package:food_rider_app/resources/color_resources.dart';
import 'package:food_rider_app/resources/font_resources.dart';
import 'package:food_rider_app/resources/string_resources.dart';
import 'package:food_rider_app/util/util.dart';
import 'package:food_rider_app/widgets/custom_widgets.dart';
import 'package:intl/intl.dart';

class HistoryBody extends StatefulWidget {
  @override
  _HistoryBodyState createState() => _HistoryBodyState();
}

class _HistoryBodyState extends State<HistoryBody> {
  List<OrderHistory> orderHistory = [];
  DateTime selectedDate = DateFormat.yMMMMd().parse(StringResources.selectedDate);

  //region date picker function
  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      currentDate: DateTime.now(),// Refer step 1
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        StringResources.selectedDate = DateFormat.yMMMMd().format(picked);
        print(StringResources.selectedDate);
      });
  }
  //endregion

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //region order history api call
    readJson("URL", "orderHistoryData").then((value){
      setState(() {
        orderHistory = value;
      });
    });
    //endregion
  }

  @override
  Widget build(BuildContext context) {
    return orderHistory.isNotEmpty ? Scaffold(
      backgroundColor: ColorResources.whiteColor,
      body: Container(
        child: Column(
          children: [
            //region container for date at top of history screen
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              width: MediaQuery.of(context).size.width,
              color: ColorResources.dodgerBlueColor,
              child: Text(
                orderHistory[0].date != null ? orderHistory[0].date : "Date",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: ColorResources.whiteColor,
                  fontFamily: FontResources.bold,
                ),
              ),
            ),
            //endregion

            //region top row to show kilometers, total order and total cash collected
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    color: ColorResources.smokeWhiteColor,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.delivery_dining,
                          color: ColorResources.darkGreyColor,
                          size: 32.0,
                          semanticLabel: 'Kilometer icon.',
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        textBold(orderHistory[0].kilometers != null ? "${orderHistory[0].kilometers} km" : "Kilometers", TextAlign.center)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    color: ColorResources.smokeWhiteColor,
                    child: Column(
                      children: [
                        Icon(
                          Icons.beenhere_rounded,
                          color: ColorResources.darkGreyColor,
                          size: 32.0,
                          semanticLabel: 'Cash icon.',
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        textBold(orderHistory != null ? "${orderHistory[0].orderList.length.toString()} orders" : "Orders", TextAlign.center)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    color: ColorResources.smokeWhiteColor,
                    child: Column(
                      children: [
                        Icon(
                          Icons.account_balance_wallet_rounded,
                          color: ColorResources.darkGreyColor,
                          size: 32.0,
                          semanticLabel: 'Cash icon.',
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        textBold(orderHistory[0].cashCollected != null ? "${orderHistory[0].cashCollected} Rs." : "Cash", TextAlign.center)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //endregion

            //region order list text container
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              width: MediaQuery.of(context).size.width,
              child: Text(
                StringResources.orderList,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  color: ColorResources.darkGreyColor,
                  fontFamily: FontResources.bold,
                ),
              ),
            ),
            //endregion

            //region order list code
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(bottom: 66.0),
                itemCount: orderHistory[0].orderList.length,
                itemBuilder: (BuildContext context, int index) {
                  return orderHistoryWidget(
                    context,
                      orderHistory[0].orderList[index].orderType,
                      orderHistory[0].orderList[index].orderId,
                      orderHistory[0].orderList[index].deliveryTime);
                },
              ),
            )
            //endregion
          ],
        ),
      ),
      //region floating button to change date
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: FloatingActionButton(
          onPressed: () {
            _selectDate(context);
          },
          child: Icon(
            Icons.date_range_rounded,
            color: ColorResources.whiteColor,
          ),
          backgroundColor: ColorResources.dodgerBlueColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      //endregion
    ) :
    //region container when no data is available
    Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
    //endregion
  }
}