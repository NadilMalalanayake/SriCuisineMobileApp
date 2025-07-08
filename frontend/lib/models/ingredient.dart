class Ingredient {
  String? id;
  String? user;
  String? name;
  DateTime? expiryDate;
  int? v;

  Ingredient({
    this.id,
    this.user,
    this.name,
    this.expiryDate,
    this.v,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        id: json["_id"],
        user: json["user"],
        name: json["name"],
        expiryDate: json["expiryDate"] == null
            ? null
            : DateTime.parse(json["expiryDate"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "name": name,
        "expiryDate": expiryDate?.toIso8601String(),
        "__v": v,
      };
}
