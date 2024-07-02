import 'package:isar/isar.dart';
import 'package:rezept_app/src/database/models/unit.dart';

part 'ingredient.g.dart';

@collection
class Ingredient {
  final Id id = Isar.autoIncrement;
  final String name;
  final double amount;

  @Enumerated(EnumType.ordinal32)
  late Unit unit;

  @Enumerated(EnumType.ordinal32)
  late UnitPrefix unitPrefix;

  Ingredient({
    required this.name,
    required this.amount,
    required this.unit,
    this.unitPrefix = UnitPrefix.none,
  });
}
