enum UnitPrefix {
  none(1.0, ""),
  milli(0.001, "m"),
  centi(0.01, "c"),
  deci(0.1, "d"),
  kilo(1000.0, "k");

  final double multiplier;
  final String symbol;

  const UnitPrefix(this.multiplier, this.symbol);
}

abstract class Unit {
  double get conversionFactor;
  String get name;

  double convert(double amount, Unit to,
      {UnitPrefix fromPrefix = UnitPrefix.none,
      UnitPrefix toPrefix = UnitPrefix.none});
}

enum VolumeUnit implements Unit {
  teaspoon(1.0, "teaspoon"),
  tablespoon(3.0, "tablespoon"),
  cup(48.0, "cup"),
  pint(96.0, "pint"),
  quart(192.0, "quart"),
  gallon(768.0, "gallon"),
  milliliter(0.202884, "milliliter"),
  liter(202.884, "liter");

  @override
  final double conversionFactor;
  final String unitName;

  const VolumeUnit(this.conversionFactor, this.unitName);

  @override
  double convert(double amount, Unit to,
      {UnitPrefix fromPrefix = UnitPrefix.none,
      UnitPrefix toPrefix = UnitPrefix.none}) {
    if (to is VolumeUnit) {
      if (this == to) {
        return amount * fromPrefix.multiplier / toPrefix.multiplier;
      }
      double amountInTeaspoons =
          amount * conversionFactor * fromPrefix.multiplier;
      return amountInTeaspoons / to.conversionFactor / toPrefix.multiplier;
    }
    throw ArgumentError(
        'Conversion from VolumeUnit to ${to.runtimeType} is not supported.');
  }

  @override
  String get name => unitName;
}

enum WeightUnit implements Unit {
  ounce(1.0, "ounce"),
  pound(16.0, "pound"),
  gram(0.035274, "gram"),
  kilogram(35.274, "kilogram");

  @override
  final double conversionFactor;
  final String unitName;

  const WeightUnit(this.conversionFactor, this.unitName);

  @override
  double convert(double amount, Unit to,
      {UnitPrefix fromPrefix = UnitPrefix.none,
      UnitPrefix toPrefix = UnitPrefix.none}) {
    if (to is WeightUnit) {
      if (this == to) {
        return amount * fromPrefix.multiplier / toPrefix.multiplier;
      }
      double amountInOunces = amount * conversionFactor * fromPrefix.multiplier;
      return amountInOunces / to.conversionFactor / toPrefix.multiplier;
    }
    throw ArgumentError(
        'Conversion from WeightUnit to ${to.runtimeType} is not supported.');
  }

  @override
  String get name => unitName;
}
