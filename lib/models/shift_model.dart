class ShiftModel {
  ShiftModel({
    required this.shiftStartTime,
    required this.shiftEndTime,
    required this.shiftArea,
  });

  String shiftStartTime;
  String shiftEndTime;
  String shiftArea;

  factory ShiftModel.fromJson(Map<String, dynamic> json) => ShiftModel(
    shiftStartTime: json["shiftStartTime"],
    shiftEndTime: json["shiftEndTime"],
    shiftArea: json["shiftArea"],
  );

  Map<String, dynamic> toJson() => {
    "shiftStartTime": shiftStartTime,
    "shiftEndTime": shiftEndTime,
    "shiftArea": shiftArea,
  };
}