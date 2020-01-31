import 'dart:convert';
import 'dart:math';

class Utils {
  static final Random _random = Random.secure();

  static String CreateCryptoRandomString([int length = 32]) {
    var values = List<int>.generate(length, (i) => _random.nextInt(256));

    return base64Url.encode(values);
  }

  static double convertStringTimeToDouble(s) {
    return double.parse(s.split(':')[0]) + double.parse(s.split(':')[1]) / 60;
  }

}