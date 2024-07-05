import 'package:isar/isar.dart';
import 'package:rezept_app/src/database/models/ingredient.dart';

part 'recipe.g.dart';

@collection
class Recipe {
  final Id id = Isar.autoIncrement;
  late String title;
  late String shortDescription;
  late String imageUri;
  late String description;
  final ingredients = IsarLinks<Ingredient>();

  Recipe({required this.title, required this.shortDescription, this.imageUri = 'assets/images/spaghetti-carbonara.webp', required this.description});
}
