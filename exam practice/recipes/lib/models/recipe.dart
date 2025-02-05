class Recipe {
  Recipe({
    this.id = 0,
    required this.date,
    required this.title,
    required this.ingredients,
    required this.category,
    required this.rating,
  });

  int id = 0;
  String date = "";
  String title = "";
  String ingredients = "";
  String category = "";
  double rating = 5.0;

  factory Recipe.fromJson(Map<String, dynamic> data) {
    final id = data['id'] ?? data['id'] as int;
    final date = data['date'] ?? data['date'] as String;
    final title = data['title'] ?? data['Title'] as String;
    final ingredients = data['ingredients'] ?? data['ingredients'] as String;
    final category = data['category'] ?? data['category'] as String;
    final rating = data['rating'] ?? data['rating'] as double;

    return Recipe(
      id: id,
      date: date,
      title: title,
      ingredients: ingredients,
      category: category,
      rating: rating,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'ingredients': ingredients,
      'category': category,
      'rating': rating,
    };
  }

  int getMonth() {
    return int.parse(date.split("-").elementAt(1));
  }
}
