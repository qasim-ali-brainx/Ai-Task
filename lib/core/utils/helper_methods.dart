import 'dart:convert';

class HelperMethods {
  const HelperMethods._();

  static String prettyJson(Object? input) {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(input);
  }
}
