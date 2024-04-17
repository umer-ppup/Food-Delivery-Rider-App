class Rider{
  String id;
  String name;
  String email;
  String phoneNumber;
  String cnicNumber;
  String licenseNumber;
  String vehicleNumber;
  String password;

  Rider({required this.id, required this.name, required this.email, required this.phoneNumber, required this.cnicNumber, required this.licenseNumber, required this.vehicleNumber, required this.password});

  factory Rider.fromJson(Map<String, dynamic> json) => Rider(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    cnicNumber: json["cnicNumber"],
    licenseNumber: json["licenseNumber"],
    vehicleNumber: json["vehicleNumber"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phoneNumber": phoneNumber,
    "cnicNumber": cnicNumber,
    "licenseNumber": licenseNumber,
    "vehicleNumber": vehicleNumber,
    "password": password,
  };
}