
class InvalidPropertyValueException implements Exception {
  String cause;

  InvalidPropertyValueException(String property, String value) {
    cause =
        'Invalid value $value for property $property.';
  }
}
