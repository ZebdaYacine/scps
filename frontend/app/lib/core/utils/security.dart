import 'dart:convert';
import 'package:encrypt/encrypt.dart';

class SecurityService {
  final IV _iv;
  final Encrypter _encrypter;

  SecurityService(String keyString)
      : _iv = IV.fromLength(16),
        _encrypter = Encrypter(
          AES(
            Key.fromUtf8(keyString),
            mode: AESMode.cbc,
          ),
        );

  String encryptData(Map<String, dynamic> data) {
    final jsonString = jsonEncode(data); // Convert data to a JSON string
    final encrypted = _encrypter.encrypt(jsonString, iv: _iv);
    return encrypted.base64;
  }

  // Method to decrypt a Base64-encoded string back to a Map
  Map<String, dynamic> decryptData(String encryptedData) {
    final decrypted =
        _encrypter.decrypt(Encrypted.fromBase64(encryptedData), iv: _iv);
    final decoded = jsonDecode(decrypted) as Map<String, dynamic>;
    return decoded;
  }
}
