import 'package:isar/isar.dart';
import 'package:rezept_app/src/database/models/unit.dart';

@collection
class Ingredient {
  final Id id = Isar.autoIncrement;
  late String name;
  late double amount;
  late String _unitName;
  late String _unitPrefix;

  @ignore
  late Unit unit;

  @ignore
  late UnitPrefix unitPrefix;

  Ingredient({
    required this.name,
    required this.amount,
    required Unit unit,
    UnitPrefix prefix = UnitPrefix.none,
  }) {
    unitPrefix = prefix;
    _unitName = unit.name;
    _unitPrefix = prefix.name;
  }
}
