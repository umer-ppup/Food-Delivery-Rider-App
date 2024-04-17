class OrderList {
  String orderId;
  String deliveryTime;
  String orderType;

  OrderList({
    required this.orderId,
    required this.deliveryTime,
    required this.orderType,
  });

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
    orderId: json["orderId"],
    deliveryTime: json["deliveryTime"],
    orderType: json["orderType"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "deliveryTime": deliveryTime,
    "orderType": orderType,
  };
}