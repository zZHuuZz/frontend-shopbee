import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final _storage = FlutterSecureStorage();
final apiURL = 'http://shopbee-api.shop/';

// Save the JWT token
Future<void> setToken(String token) async {
  await _storage.write(key: 'jwt_token', value: token);
}

// Retrieve the JWT token
Future<String?> getToken() async {
  return await _storage.read(key: 'jwt_token');
}
