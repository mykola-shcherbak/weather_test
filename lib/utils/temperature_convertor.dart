intToDouble(dynamic val) {
  if (val.runtimeType == double) {
    return val;
  } else if (val.runtimeType == int) {
    return val.toDouble();
  } else {
    throw Exception(
        "value is not of type 'int' or 'double' got type '${val.runtimeType}'");
  }
}

enum TemperatureUnit { kelvin, celsius, fahrenheit }

class Temperature {
  final double _kelvin;

  Temperature(this._kelvin);

  double get kelvin => _kelvin;

  double get celsius => _kelvin - 273.15;

  double get fahrenheit => _kelvin * (9 / 5) - 459.67;
}
