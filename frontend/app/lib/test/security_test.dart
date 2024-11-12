// test/calculator_test.dart
import 'package:app/core/secret/sercret.dart';
import 'package:app/core/utils/security.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Decrypt message', () {
    Map<String, dynamic> jsonData = {
      "name": "John Doe",
      "email": "johndoe@example.com",
      "age": 30
    };
    final securityService = SecurityService(Secret.aesKey);
    var srt = securityService.encryptData(jsonData);
  });
}
