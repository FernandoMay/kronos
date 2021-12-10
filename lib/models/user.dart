import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromMap(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class User {
  int? id;
  String name;
  String lastname;
  int phone;
  String email;
  double lat;
  double lon;
  String image;

  User(
      {this.id,
      required this.name,
      required this.lastname,
      required this.phone,
      required this.email,
      required this.lat,
      required this.lon,
      required this.image});

  factory User.fromMap(Map<String, dynamic> json) => User(
      id: json["id"],
      name: json["name"],
      lastname: json["lastname"],
      phone: json["phone"],
      email: json["email"],
      lat: json["lat"],
      lon: json["lon"],
      image: json["image"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "email": email,
        "lat": lat,
        "lon": lon,
        "image": image,
      };
}
