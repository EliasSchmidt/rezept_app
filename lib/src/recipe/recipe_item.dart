class Recipe{
  final String title;
  final String shortDescription;
  final String imageUri;
  final List<Ingredient> ingredients;
  final String description;

  Recipe({
    required this.title,
    required this.description,
    required this.imageUri,
    required this.ingredients,
    required this.shortDescription});
}

class Ingredient{
  final String name;
  final String amount;
  final String unit;

  Ingredient({required this.name,
    required this.amount,
    required this.unit});
}