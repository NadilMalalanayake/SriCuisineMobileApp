class User {
  String? id;
  String? userName;
  String? email;
  List<String>? allergens;
  String? status;
  int? v;
  int? age;
  int? height;
  int? weight;

  User({
    this.id,
    this.userName,
    this.email,
    this.allergens,
    this.status,
    this.v,
    this.age,
    this.height,
    this.weight,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        userName: json["userName"],
        email: json["email"],
        allergens: json["allergens"] == null
            ? []
            : List<String>.from(json["allergens"]!.map((x) => x)),
        status: json["status"],
        v: json["__v"],
        age: json["age"],
        height: json["height"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userName": userName,
        "email": email,
        "allergens": allergens == null
            ? []
            : List<dynamic>.from(allergens!.map((x) => x)),
        "status": status,
        "__v": v,
        "age": age,
        "height": height,
        "weight": weight,
      };
}
