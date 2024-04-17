import 'package:food_rider_app/models/order_list.dart';

class OrderHistory {
  OrderHistory({
    required this.date,
    required this.kilometers,
    required this.cashCollected,
    required this.orderList,
  });

  String date;
  String kilometers;
  String cashCollected;
  List<OrderList> orderList;

  factory OrderHistory.fromJson(Map<String, dynamic> json) => OrderHistory(
    date: json["date"],
    kilometers: json["kilometers"],
    cashCollected: json["cashCollected"],
    orderList: List<OrderList>.from(json["orderList"].map((x) => OrderList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "kilometers": kilometers,
    "cashCollected": cashCollected,
    "orderList": List<dynamic>.from(orderList.map((x) => x.toJson())),
  };
}