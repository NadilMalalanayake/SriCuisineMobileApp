class Recipe {
  final int? srno;
  final String? recipeName;
  final String? image;
  final String? servings;
  final String? course;
  final int? calorie;
  final String? ingredientsWithQuantites;
  final String? totalTimeInMins;
  final String? instructions;
  final String? allergens;

  Recipe({
    this.image =
        "https://c4.wallpaperflare.com/wallpaper/373/952/839/wooden-spoon-condiments-background-wallpaper-preview.jpg",
    this.srno,
    this.recipeName,
    this.servings,
    this.course,
    this.calorie,
    this.ingredientsWithQuantites,
    this.totalTimeInMins,
    this.instructions,
    this.allergens,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      srno: json['Srno'] ?? 0,
      recipeName: json['RecipeName'] ?? "None",
      ingredientsWithQuantites: json['IngredientsWithQuantites'] ?? "Nothing to display",
      totalTimeInMins: json['TotalTimeInMins'] ?? "0",
      instructions: json['Instructions'] ?? "Nothing to display",
      servings: json['Servings'] ?? "-",
      course: json['Course'] ?? "-",
      allergens: json['Allergens'] ?? "None",
      calorie: json['Calorie'] ?? 0,
    );
  }
}
