// ignore: depend_on_referenced_packages
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  static Future<String?> readStrogeByKey(String key) async {
    var value = await secureStorage.read(key: key);
    return value;
  }

  static void writeStrogeByKey(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }
}
