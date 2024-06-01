import 'package:isar/isar.dart';

@collection
class Recipe {
  final id = Isar.autoIncrement;
  late String title;
  late String shortDescription;
  late String imageUri;
  final ingredients = IsarLinks<Ingredient>();
  late String description;
}

@collection
class Ingredient {
  final id = Isar.autoIncrement;
  late String name;
  late String amount;
  late String unit;
}
