class TransactionHistory {
  String transactionId;
  String transactionDate;
  String transactionTime;
  String transactionAmount;

  TransactionHistory({
    required this.transactionId,
    required this.transactionDate,
    required this.transactionTime,
    required this.transactionAmount,
  });

  factory TransactionHistory.fromJson(Map<String, dynamic> json) => TransactionHistory(
    transactionId: json["transactionId"],
    transactionDate: json["transactionDate"],
    transactionTime: json["transactionTime"],
    transactionAmount: json["transactionAmount"],
  );

  Map<String, dynamic> toJson() => {
    "transactionId": transactionId,
    "transactionDate": transactionDate,
    "transactionTime": transactionTime,
    "transactionAmount": transactionAmount,
  };
}