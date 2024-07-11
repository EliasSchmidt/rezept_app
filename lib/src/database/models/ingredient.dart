import 'package:isar/isar.dart';
import 'package:rezept_app/src/database/models/unit.dart';

part 'ingredient.g.dart';

@collection
class Ingredient {
  final Id id = Isar.autoIncrement;
  final String name;
  final String? description;
  final String? imageUri;

  Ingredient({
    required this.name,
    this.description,
    this.imageUri,
  });
}


@Collection()
class IngredientWithAmount {
  Id id = Isar.autoIncrement;
  final IsarLink<Ingredient> ingredient = IsarLink<Ingredient>();
  final double amount;

  @Enumerated(EnumType.ordinal32)
  late Unit unit;

  @Enumerated(EnumType.ordinal32)
  late UnitPrefix unitPrefix;

  IngredientWithAmount({
    required this.amount,
    required this.unit,
    this.unitPrefix = UnitPrefix.none,
  });
}
