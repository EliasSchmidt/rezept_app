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

enum Unit {
  // Volume Units
  teaspoon(1.0, "teaspoon", UnitType.volume),
  tablespoon(3.0, "tablespoon", UnitType.volume),
  cup(48.0, "cup", UnitType.volume),
  pint(96.0, "pint", UnitType.volume),
  quart(192.0, "quart", UnitType.volume),
  gallon(768.0, "gallon", UnitType.volume),
  milliliter(0.202884, "milliliter", UnitType.volume),
  liter(202.884, "liter", UnitType.volume),

  // Weight Units
  ounce(1.0, "ounce", UnitType.weight),
  pound(16.0, "pound", UnitType.weight),
  gram(0.035274, "gram", UnitType.weight),
  kilogram(35.274, "kilogram", UnitType.weight);

  final double conversionFactor;
  final String unitName;
  final UnitType unitType;

  const Unit(this.conversionFactor, this.unitName, this.unitType);

  double convert(double amount, Unit to,
      {UnitPrefix fromPrefix = UnitPrefix.none,
      UnitPrefix toPrefix = UnitPrefix.none}) {
    if (unitType != to.unitType) {
      throw ArgumentError(
          'Conversion from $unitType to ${to.unitType} is not supported.');
    }

    if (this == to) {
      return amount * fromPrefix.multiplier / toPrefix.multiplier;
    }

    double amountInBaseUnit =
        amount * conversionFactor * fromPrefix.multiplier;
    return amountInBaseUnit / to.conversionFactor / toPrefix.multiplier;
  }

  String get name => unitName;
}

enum UnitType {
  volume,
  weight;
}
